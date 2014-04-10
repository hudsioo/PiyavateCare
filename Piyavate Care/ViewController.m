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

@interface ViewController (){
    NSMutableData * jData;
    NSURLConnection * logInConnect;
    NSURLConnection * lostPassConnect;
}

@end

@implementation ViewController

- (void)requestPassword{
    jData = [[NSMutableData alloc]init];
    NSString * username = [self.lostUserTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * phone = [self.lostPhoneTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * strRequest = [NSString stringWithFormat:@"http://piyavatecare.com/home/app/requestPass.php?username=%@&phone=%@",username,phone];
    NSURL *_url = [NSURL URLWithString:strRequest];
    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50];
    NSDictionary *_headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
    [_request setAllHTTPHeaderFields:_headers];
    logInConnect=[[NSURLConnection alloc] initWithRequest:_request delegate:self];
    if (logInConnect) {NSLog(@"ok");} else {NSLog(@"fail");}
    
}

- (void)requestLogin{
    jData = [[NSMutableData alloc]init];
    NSString * username = [self.userTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * password = [self.passTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * strRequest = [NSString stringWithFormat:@"http://piyavatecare.com/home/app/signin.php?username=%@&password=%@",username,password];
    NSURL *_url = [NSURL URLWithString:strRequest];
    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50];
    NSDictionary *_headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
    [_request setAllHTTPHeaderFields:_headers];
    logInConnect=[[NSURLConnection alloc] initWithRequest:_request delegate:self];
    if (logInConnect) {NSLog(@"ok");} else {NSLog(@"fail");}
    
}

#pragma mark - Connection delegate
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [jData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (connection == logInConnect) {
        NSMutableArray * dicA = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Request Webservice %@",[dicA class]);
        if (dicA[0]) {
            if ([dicA[0][@"status"] isEqualToString:@"fail"]) {
                UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"เข้าสู่ระบบไม่สำเร็จ" message:@"รหัสผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง" delegate:self cancelButtonTitle:@"ปิด" otherButtonTitles:nil, nil];
                [alertV show];
            }
            [SVProgressHUD dismiss];
            
        }
    }
    else if (connection == lostPassConnect){
        NSMutableArray * dicA = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Request Webservice %@",[dicA class]);
        if (dicA[0]) {
            if ([dicA[0][@"status"] isEqualToString:@"fail"]) {
                UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"เข้าสู่ระบบไม่สำเร็จ" message:@"รหัสผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง" delegate:self cancelButtonTitle:@"ปิด" otherButtonTitles:nil, nil];
                [alertV show];
            }
            [SVProgressHUD dismiss];
            
        }
    }
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

//Request Login
- (IBAction)loginAction:(id)sender {
    [SVProgressHUD showWithStatus:@"กำลังตรวจสอบ" maskType:SVProgressHUDMaskTypeGradient];
    [self requestLogin];
}




//Request Lost Password

- (IBAction)requestPasswordAction:(id)sender {
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Regiter

- (IBAction)regiterAction:(id)sender {
    SignupViewController * signupVC = [[SignupViewController alloc]initWithNibName:@"SignupViewController" bundle:nil];
    [self presentViewController:signupVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
