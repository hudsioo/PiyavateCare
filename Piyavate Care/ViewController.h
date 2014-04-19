//
//  ViewController.h
//  Piyavate Care
//
//  Created by hudsioo on 3/27/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate,UIWebViewDelegate>{
    
}

//Login View
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)loginAction:(id)sender;

//Request Password View
- (IBAction)forgotPasswordAction:(id)sender;

@end
