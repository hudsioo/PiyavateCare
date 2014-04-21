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
    [self requestSignUp];
}

- (void)requestSignUp{
    jData = [[NSMutableData alloc] init];
    

    
    NSString * strRequest = [NSString stringWithFormat:@"http://piyavatecare.com/home/app/register.php?name=%@&age=%@&address=%@&street=%@&subDistrict=%@&district=%@&province=%@&postCode=%@&phone=%@&email=%@&username=%@&password=%@&emergencyPerson=%@&emergencyPersonNumberPhone=%@&hearFrom=%@&poiHome=%@&latitude=%f&longitude=%f",
                             self.nameTextField.text,
                             self.ageTextField.text,
                             self.addressTextField.text,
                             self.streetTextFIELD.text,
                             self.subDistrictTextField.text,
                             self.districtTextField.text,
                             self.provinceTextFiled.text,
                             self.postCodeTextField.text,
                             self.telephoneNumberTextField.text,
                             self.emailTextField.text,
                             self.usernameTextField.text,
                             self.passwordTextField.text,
                             self.emergencyPersonTextField.text,
                             self.emergencyPersonNumberPhoneTextField.text,
                             self.hearFromTextField.text,
                             self.pointHomeTextField.text,
                             coord.latitude,
                             coord.longitude];
    NSLog(@"URL %@",strRequest);
    NSURL *_url = [NSURL URLWithString:strRequest];
    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50];
    NSDictionary *_headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
    [_request setAllHTTPHeaderFields:_headers];
    
    urlConnection=[[NSURLConnection alloc] initWithRequest:_request delegate:self];
    [urlConnection start];
}


#pragma mark - Connection delegate
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [jData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
        NSMutableArray * dicA = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Request Webservice %@",dicA);
        if (dicA[0]) {
            if ([dicA[0][@"status"] isEqualToString:@"fail"]) {
                UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"สมัครไม่สำเร็จ" message:@"กรุณาตรวจสอบข้อมูล" delegate:self cancelButtonTitle:@"ปิด" otherButtonTitles:nil, nil];
                [alertV show];
            }
            [SVProgressHUD dismiss];
            
        }
    
    
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
