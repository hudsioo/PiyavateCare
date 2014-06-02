//
//  GetHealthViewController.m
//  Piyavate Care
//
//  Created by hudsioo on 6/2/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "GetHealthViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "AFHTTPClient.h"

@interface GetHealthViewController ()

@end

@implementation GetHealthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)editRequest{
    
    NSString * name     = [self.nameTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * age      = [self.ageTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * add      = [self.addressTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * street   = [self.streetTextFIELD.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * subDis   = [self.subDistrictTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * dis      = [self.districtTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * prov     = [self.provinceTextFiled.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * post     = [self.postCodeTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * tel      = [self.telephoneNumberTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * email    = [self.emailTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * user     = [self.usernameTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * pass     = [self.passwordTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * emerP    = [self.emergencyPersonTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *  emerT   = [self.emergencyPersonNumberPhoneTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * hear     = [self.hearFromTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *  point   = [self.pointHomeTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * healthInfo = @"healthInfo";
    NSString * disease = @"disease";
    NSString * drug = @"drug";
    NSString * treatmentInfo = @"treatmentInfo" ;
    NSString * claim = @"claim";
    NSString * userID = @"userID";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            name , @"name",
                            age , @"age",
                            add , @"address",
                            street , @"street",
                            subDis , @"subDistrict",
                            dis , @"district",
                            prov , @"province",
                            post , @"postCode",
                            tel , @"phone",
                            email , @"email",
                            user , @"username",
                            pass , @"password",
                            emerP , @"emergencyPerson",
                            emerT , @"emergencyPersonNumberPhone",
                            hear , @"hearFrom",
                            point , @"poiHome",
                            healthInfo, @"healthInfo",
                            disease, @"disease",
                            drug, @"drug",
                            treatmentInfo, @"treatmentInfo" ,
                            claim, @"claim",
                            userID , @"userID",
                            nil];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:piyavateURL]];
    
    [client postPath:@"postmyhealth.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Respone %@",array);
        
        if ([array[0][@"status"] isEqualToString:@"fail"]) {
            [SVProgressHUD dismiss];
            UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"แก้ไขข้อมูลไม่สำเร็จ" message:@"กรุณาตรวจสอบข้อมูล" delegate:self cancelButtonTitle:@"ปิด" otherButtonTitles:nil, nil];
            [alertV show];
        }else{
            [SVProgressHUD dismiss];
            [self backButtontapped:nil];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}


- (void)getMyHealth{
   /* Get My Health Profile
    
        URL: getmyhealth.php
    
        Parameter: userID
    
    Post My Health Profile
    
    URL: postmyhealth.php
    
    Parameter: name, age, address, street, subDistrict, district, province, postCode, phone, email,
    
    username, password, emergencyPerson, emergencyPersonNumberPhone, hearFrom, poiHome,
    
    healthInfo, disease, drug, treatmentInfo, claim, userID
    */
    
    
    NSUserDefaults * UD = [NSUserDefaults standardUserDefaults];
    NSString * userID = [[UD objectForKey:@"userInfo"] objectForKey:@"userID"];
    NSLog(@"%@ user",userID);
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userID, @"userID",
                            nil];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:piyavateURL]];
    
    [client postPath:@"getmyhealth.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:array[0]];
        NSLog(@"Respone %@",dic);
        
        [SVProgressHUD dismiss];
        
        self.nameTextField.text = dic[@"name"];
        self.ageTextField.text = dic[@"age"];
        self.addressTextField.text = dic[@"address"];
        self.streetTextFIELD.text = dic[@"street"];
        self.subDistrictTextField.text = dic[@"subDistrict"];
        self.districtTextField.text = dic[@"district"];
        self.provinceTextFiled.text = dic[@"province"];
        self.postCodeTextField.text = dic[@"postCode"];
        self.telephoneNumberTextField.text = dic[@"phone"];
        self.emailTextField.text = dic[@"email"];
        self.usernameTextField.text = dic[@"username"];
        self.passwordTextField.text = dic[@"password"];
        self.emergencyPersonTextField.text = dic[@"emergencyPerson"];
        self.emergencyPersonNumberPhoneTextField.text = dic[@"emergencyPersonNumberPhone"];
        self.hearFromTextField.text = dic[@"hearFrom"];
        self.pointHomeTextField.text = dic[@"poiHome"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(320, 1350);
    [SVProgressHUD showWithStatus:@"กำลังโหลดข้อมูล" maskType:SVProgressHUDMaskTypeGradient];
    [self getMyHealth];
}

- (IBAction)editProfileAction:(id)sender{
    [SVProgressHUD showWithStatus:@"กำลังตรวจสอบ" maskType:SVProgressHUDMaskTypeGradient];
    [self editRequest];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"xxxx");
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backButtontapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
