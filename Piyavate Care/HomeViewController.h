//
//  HomeViewController.h
//  Piyavate Care
//
//  Created by hudsioo on 4/10/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface HomeViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (nonatomic, assign)CLLocationCoordinate2D currentLocation;

- (IBAction)openGetHealth:(id)sender;
- (IBAction)openAskDoctor:(id)sender;
- (IBAction)openHealthCheck:(id)sender;
- (IBAction)openWorkingCare:(id)sender;
- (IBAction)openElderlyCare:(id)sender;
- (IBAction)openWomenCare:(id)sender;
- (IBAction)openWellbeingCare:(id)sender;
- (IBAction)openPromotion:(id)sender;
- (IBAction)openNews:(id)sender;
- (IBAction)openMaps:(id)sender;
- (IBAction)openSOS:(id)sender;
- (IBAction)openPiyavateLocation:(id)sender;

- (IBAction)callEmergency:(id)sender;

@end
