//
//  ForgotPasswordViewController.h
//  Piyavate Care
//
//  Created by Chakrit Paniam on 4/19/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController



@property (weak, nonatomic) IBOutlet UITextField *usernameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;


- (IBAction)forgotPasswordAction:(id)sender;
- (IBAction)backButtontapped:(id)sender;

@end
