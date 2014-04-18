//
//  BMICalculatorViewController.h
//  Piyavate Care
//
//  Created by hudsioo on 4/18/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMICalculatorViewController : UIViewController<UITextFieldDelegate>{
    BOOL isMale;
    float BMI;
}

- (IBAction)genderToggle:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *highTF;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UILabel *bmiTF;
@property (weak, nonatomic) IBOutlet UILabel *pointTF;
- (IBAction)calculateBMI:(id)sender;
- (IBAction)closeAction:(id)sender;
@end
