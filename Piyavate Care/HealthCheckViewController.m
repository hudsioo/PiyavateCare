//
//  HealthCheckViewController.m
//  Piyavate Care
//
//  Created by hudsioo on 4/18/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "HealthCheckViewController.h"
#import "BMICalculatorViewController.h"
@interface HealthCheckViewController ()

@end

@implementation HealthCheckViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openBMICheck:(id)sender {
    BMICalculatorViewController * bmiVC = [[BMICalculatorViewController alloc] initWithNibName:@"BMICalculatorViewController" bundle:nil];
    bmiVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:bmiVC animated:YES completion:nil];
}

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
