//
//  WebViewController.h
//  Piyavate Care
//
//  Created by hudsioo on 4/11/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface WebViewController : UIViewController<UIWebViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationManager;

}

@property (nonatomic, assign)CLLocationCoordinate2D currentLocation;

@property (strong, nonatomic) NSString * urlStr;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (id)initWithURL:(NSString*)url andTitle:(NSString*) t;
@end
