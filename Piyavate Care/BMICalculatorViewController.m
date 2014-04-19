//
//  BMICalculatorViewController.m
//  Piyavate Care
//
//  Created by hudsioo on 4/18/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "BMICalculatorViewController.h"

@interface BMICalculatorViewController ()

@end

@implementation BMICalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isMale = YES;
}


- (IBAction)genderToggle:(id)sender {
    UISegmentedControl * segment = (UISegmentedControl*)sender;
    if (segment.selectedSegmentIndex == 0) {
        isMale = YES;
    }else{
        isMale = NO;
    }
}
- (IBAction)calculateBMI:(id)sender {
    float high = [self.highTF.text floatValue]/100;
    BMI = [self.weight.text floatValue]/(high*high);
    
    [self.weight resignFirstResponder];
    [self.highTF resignFirstResponder];
    
    self.bmiTF.text = [NSString stringWithFormat:@"%.2f",BMI];
    self.pointTF.text = [self bmiCheckResult];
    
}

-(NSString *)bmiCheckResult{
    NSString * textResult;
    if (isMale) {
        if (BMI < 19) {
            textResult = @"ผอมบาง";
        }else if (BMI > 19 && BMI < 25){
            textResult = @"พอเหมาะ";
        }else if (BMI > 25 && BMI < 30){
            textResult = @"น้ำหนักเกิน";
        }else if (BMI > 30){
            textResult = @"เป็นโรคอ้วน";
        }
    }else{
        if (BMI < 18) {
            textResult = @"ผอมบาง";
        }else if (BMI > 18 && BMI < 24){
            textResult = @"พอเหมาะ";
        }else if (BMI > 24 && BMI < 30){
            textResult = @"น้ำหนักเกิน";
        }else if (BMI > 30){
            textResult = @"เป็นโรคอ้วน";
        }
    }
    return textResult;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
