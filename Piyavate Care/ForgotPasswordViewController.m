//
//  ForgotPasswordViewController.m
//  Piyavate Care
//
//  Created by Chakrit Paniam on 4/19/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "SVProgressHUD.h"

@interface ForgotPasswordViewController (){
    NSMutableData * jData;
    NSURLConnection * urlConnection;
}

@end

@implementation ForgotPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)forgetPassRequest{
    
    NSString * username           = [self.usernameTextFiled.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * phone              = [self.phoneNumberTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, @"username",
                            phone, @"phone",
                            nil];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:piyavateURL]];
    
    [client postPath:@"requestPass.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Respone %@",array);
        
        if ([array[0][@"status"] isEqualToString:@"fail"]) {
            [SVProgressHUD dismiss];
            UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"ขอรหัสผ่านไม่สำเร็จ" message:@"รหัสผู้ใช้ หรือ หมายเลขโทรศัพท์ ไม่ถูกต้อง" delegate:self cancelButtonTitle:@"ปิด" otherButtonTitles:nil, nil];
            [alertV show];
        }else{

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (IBAction)forgotPasswordAction:(id)sender {
    [SVProgressHUD showWithStatus:@"กำลังตรวจสอบ" maskType:SVProgressHUDMaskTypeGradient];
    [self forgetPassRequest];
}

- (IBAction)backButtontapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
