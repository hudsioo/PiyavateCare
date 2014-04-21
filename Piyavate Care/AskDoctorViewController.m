//
//  AskDoctorViewController.m
//  Piyavate Care
//
//  Created by hudsioo on 4/11/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "AskDoctorViewController.h"

@interface AskDoctorViewController (){
    NSMutableData * jData;
}

@end

@implementation AskDoctorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)requestWebService{
    jData = [NSMutableData data];
    NSString * strRequest = [NSString stringWithFormat:@"http://piyavatecare.com/home/app/postDoctor.php?userID=%@&doctorID=%@&name=%@&email=%@&phone=%@&userID=%@",
                             @"userID",
                             @"DoctorID",
                             self.nameTF.text,
                             self.emailTF.text,
                             self.phoneTF.text,
                             @"userID"
                             ];
    //?
    // แล้ว หัวข้อ กับ รายอะเอียด ส่งตรงไป ............. - -' งง
    // doctorID เอามาจากไส งง มาก
    
    NSURL *_url = [NSURL URLWithString:strRequest];
    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50];
    NSDictionary *_headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
    [_request setAllHTTPHeaderFields:_headers];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:_request delegate:self];
    if (theConnection) {NSLog(@"ok");} else {NSLog(@"fail");}
    
}

#pragma mark - Connection delegate
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [jData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Request Webservice %@",dic);
    if (dic) {
        
    }
}

- (IBAction)sendTopicAction:(id)sender {
    [self requestWebService];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(320, 800);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
