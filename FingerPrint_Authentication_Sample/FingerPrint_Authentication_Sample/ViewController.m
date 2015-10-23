//
//  ViewController.m
//  FingerPrint_Authentication_Sample
//
//  Created by Samrat on 10/23/15.
//  Copyright © 2015 footyapps27. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>//Required for local authentication

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* Create the Authentication Context Object & the associated error */
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    /* Important to check that we can use "Touch Id" for the authentication process. */
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        /* Declare the string that will be shown to the user for using Touch ID. */
        NSString *strReason = @"Login to your account.";
        
        /* Start the authentication process. */
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:strReason
                          reply:^(BOOL success, NSError *error) {
                              
                              /* Success */
                              if (success) {
                                  /* Navigate to the required screen. It is important to use the MAIN thread for all the tasks here. */
                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Now we display the Accounts" preferredStyle:UIAlertControllerStyleAlert];
                                  
                                  [self presentViewController:alert animated:YES completion:nil];
                              }
                              else {/* Some problem detected. It is important to use the MAIN thread for all the tasks here. */
                                  switch (error.code) {
                                      case LAErrorAuthenticationFailed:{
                                          UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed" message:@"Authentication Failed" preferredStyle:UIAlertControllerStyleAlert];
                                          [self presentViewController:alert animated:YES completion:nil];
                                      }
                                          break;
                                      case LAErrorUserCancel:{
                                          NSLog(@"User Cancelled");
                                      }
                                          break;
                                      case LAErrorUserFallback:{
                                          NSLog(@"User using Fallback");
                                      }
                                          break;
                                      case LAErrorSystemCancel:{
                                          NSLog(@"System Cancelled");
                                      }
                                          break;
                                      default:
                                          break;
                                  }
                              }
                          }];
    }
    else{/* The Biometrics authnetication was denied. We can also use this to decide if we want to show the Touch ID authentication. */
        NSLog(@"not available");
        switch (error.code) {
            case LAErrorTouchIDNotAvailable:{
                
            }
                break;
            case LAErrorPasscodeNotSet:{
                
            }
                break;
            case LAErrorTouchIDNotEnrolled:{
                
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
