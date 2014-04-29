//
//  ViewController.m
//  Piyavate Care
//
//  Created by hudsioo on 3/27/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "ViewController.h"
#import "SignupViewController.h"
#import "SVProgressHUD.h"
#import "ForgotPasswordViewController.h"

#import "HomeViewController.h"


@interface ViewController (){
    NSMutableData * jData;
    NSURLConnection * urlConnection;
}

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

//Request Login
- (IBAction)loginAction:(id)sender {
    [SVProgressHUD showWithStatus:@"กำลังตรวจสอบ" maskType:SVProgressHUDMaskTypeGradient];
   // [self requestLogin];
    [self loginRequest];
}


//Request Lost Password

- (IBAction)forgotPasswordAction:(id)sender {
    UIStoryboard *storyboard     = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ForgotPasswordViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"forgotPassword"];
    [self presentViewController:vc animated:YES completion:nil];


}

- (void)loginRequest{
    
    NSString * username = [self.userTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * password = [self.passTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, @"username",
                            password, @"password",
                            nil];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:piyavateURL]];

    [client postPath:@"signin.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Respone %@",array);
        
        if ([array[0][@"userID"] isEqualToString:@""]) {
            [SVProgressHUD dismiss];
            UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"เข้าสู่ระบบไม่สำเร็จ" message:@"รหัสผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง" delegate:self cancelButtonTitle:@"ปิด" otherButtonTitles:nil, nil];
            [alertV show];
        }else{
            NSUserDefaults * UD = [NSUserDefaults standardUserDefaults];
            [UD setObject:array[0] forKey:@"userInfo"];
            [UD synchronize];
            
            [self performSelector:@selector(openHomeView) withObject:nil afterDelay:2];
        }
        
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)openHomeView{
    [SVProgressHUD dismiss];
    HomeViewController * homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self presentViewController:homeVC animated:YES completion:nil];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Regiter

- (IBAction)regiterAction:(id)sender {
    UIStoryboard *storyboard     = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    SignupViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Signup"];
    [self presentViewController:vc animated:YES completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.userTF) {
        [self.passTF becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
        [self loginAction:nil];
    }
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
