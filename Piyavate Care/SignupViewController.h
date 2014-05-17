//
//  SignupViewController.h
//  Piyavate Care
//
//  Created by hudsioo on 4/1/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface SignupViewController : UIViewController<UIScrollViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate>{
    
     CLLocationManager *locationManager;
}




@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetTextFIELD;
@property (weak, nonatomic) IBOutlet UITextField *subDistrictTextField;
@property (weak, nonatomic) IBOutlet UITextField *districtTextField;
@property (weak, nonatomic) IBOutlet UITextField *provinceTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *postCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emergencyPersonTextField;
@property (weak, nonatomic) IBOutlet UITextField *emergencyPersonNumberPhoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *hearFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *pointHomeTextField;





- (IBAction)signUpAction:(id)sender;

- (IBAction)backButtontapped:(id)sender;

@end
