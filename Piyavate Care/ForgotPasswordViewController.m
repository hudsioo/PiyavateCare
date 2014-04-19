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

- (void)requestPassword{
    jData = [[NSMutableData alloc] init];
    
    NSString * username           = [self.usernameTextFiled.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * phone              = [self.phoneNumberTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * strRequest = [NSString stringWithFormat:@"http://piyavatecare.com/home/app/requestPass.php?username=%@&phone=%@",username,phone];
    
    NSURL *_url = [NSURL URLWithString:strRequest];
    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50];
    NSDictionary *_headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
    [_request setAllHTTPHeaderFields:_headers];
    
    urlConnection =[[NSURLConnection alloc] initWithRequest:_request delegate:self];
    
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
                UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"เข้าสู่ระบบไม่สำเร็จ" message:@"รหัสผู้ใช้ หรือ เบอร์โทรศัพท์ไม่ถูกต้อง" delegate:self cancelButtonTitle:@"ปิด" otherButtonTitles:nil, nil];
                [alertV show];
            }
            [SVProgressHUD dismiss];
            
        }
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)forgotPasswordAction:(id)sender {
    [SVProgressHUD showWithStatus:@"กำลังตรวจสอบ" maskType:SVProgressHUDMaskTypeGradient];
    [self requestPassword];
}

- (IBAction)backButtontapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
