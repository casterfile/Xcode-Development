//
//  AuthenticationViewController.h
//  simpleAuthentication
//
//  Created by Anon on 7/27/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenticationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *setUsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *setPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)setUserNameAndPasswordButton:(id)sender;
- (IBAction)signInButton:(id)sender;

@end
