//
//  AskDoctorViewController.h
//  Piyavate Care
//
//  Created by hudsioo on 4/11/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AskDoctorViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *topicTF;
@property (weak, nonatomic) IBOutlet UITextField *detailTF;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)closeView:(id)sender;
- (IBAction)sendTopicAction:(id)sender;
@end
