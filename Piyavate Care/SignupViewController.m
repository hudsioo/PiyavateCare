//
//  SignupViewController.m
//  Piyavate Care
//
//  Created by hudsioo on 4/1/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "SignupViewController.h"
#import "SVProgressHUD.h"


@interface SignupViewController (){
    NSMutableData * jData;
    NSURLConnection * urlConnection;
    
    CLLocationCoordinate2D coord;
}

@end

@implementation SignupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    [locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    
    CLLocation *location = [locationManager location];
    
    
    coord.longitude = location.coordinate.longitude;
    coord.latitude = location.coordinate.latitude;
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(320, 1350);
}


- (IBAction)signUpAction:(id)sender {
    [SVProgressHUD showWithStatus:@"กำลังตรวจสอบ" maskType:SVProgressHUDMaskTypeGradient];
    [self registerRequest];
}

- (void)registerRequest{
    
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
    NSString *  lati    = [NSString stringWithFormat:@"%f",coord.latitude];
    NSString *  longti  = [NSString stringWithFormat:@"%f",coord.longitude];
    
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
                            lati, @"latitude",
                            longti, @"longitude",
                            nil];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:piyavateURL]];
    
    [client postPath:@"register.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Respone %@",array);
        
        if ([array[0][@"status"] isEqualToString:@"fail"]) {
            [SVProgressHUD dismiss];
            UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"ลงทะเบียนไม่สำเร็จ" message:@"กรุณาตรวจสอบข้อมูล" delegate:self cancelButtonTitle:@"ปิด" otherButtonTitles:nil, nil];
            [alertV show];
        }else{
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
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
