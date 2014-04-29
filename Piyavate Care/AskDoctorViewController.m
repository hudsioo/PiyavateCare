//
//  AskDoctorViewController.m
//  Piyavate Care
//
//  Created by hudsioo on 4/11/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "AskDoctorViewController.h"
#import "SVProgressHUD.h"
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [SVProgressHUD dismiss];
        [self performSelector:@selector(closeView:) withObject:nil afterDelay:2];
    }
}


- (void)askDocRequest{
//    userID, doctorID, name, email, phone,
    NSUserDefaults * UD = [NSUserDefaults standardUserDefaults];
    NSString * userID = [[UD objectForKey:@"userInfo"] objectForKey:@"userID"];
    NSString * doctorID = @"";
    NSString * name = [self.nameTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * email = [self.emailTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * phone = [self.phoneTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userID, @"userID",
                            doctorID, @"doctorID",
                            name, @"name",
                            email, @"email",
                            phone, @"phone",
                            nil];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                            [NSURL URLWithString:piyavateURL]];
    
    [client postPath:@"postDoctor.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Respone %@",array);
        
        if ([array[0][@"status"] isEqualToString:@"fail"]) {
            [SVProgressHUD dismiss];
            UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"เข้าสู่ระบบไม่สำเร็จ" message:@"รหัสผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง" delegate:self cancelButtonTitle:@"ปิด" otherButtonTitles:nil, nil];
            [alertV show];
        }else{
           
            UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"ระบบได้ทำการบันทึกข้อมูลของคุณแล้ว" message:@"รอการติดต่อกลับ" delegate:self cancelButtonTitle:@"ปิด" otherButtonTitles:nil, nil];
            [alertV show];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (IBAction)sendTopicAction:(id)sender {
    [SVProgressHUD showWithStatus:@"กำลังส่งข้อมูล" maskType:SVProgressHUDMaskTypeGradient];

    [self askDocRequest];
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
