//
//  WebViewController.m
//  Piyavate Care
//
//  Created by hudsioo on 4/11/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithURL:(NSString*)url andTitle:(NSString*) t
{
    self = [super initWithNibName:@"WebViewController" bundle:nil];
    if (self) {
        self.urlStr = url;
        self.title = t;
    }
    return self;
}

- (void)closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"Update");
    self.currentLocation = newLocation.coordinate;
    
}

- (void)openMap{
    NSString* url = [NSString stringWithFormat: @"maps://maps.google.com/maps?xyz=xyz&saddr=%f,%f&daddr=%f,%f",self.currentLocation.latitude, self.currentLocation.longitude,13.753471,100.580063];
    NSLog(@"urlmap:%@",url);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * closeBtn = [[UIBarButtonItem alloc] initWithTitle:@"ปิด" style:UIBarButtonItemStylePlain target:self action:@selector(closeAction)];
    self.navigationItem.leftBarButtonItem = closeBtn;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    if ([self.title isEqualToString:@"Piyavate Care"]) {
        UIBarButtonItem * mapBtn = [[UIBarButtonItem alloc] initWithTitle:@"นำทาง" style:UIBarButtonItemStylePlain target:self action:@selector(openMap)];
        self.navigationItem.rightBarButtonItem = mapBtn;
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      if ([self.title isEqualToString:@"Piyavate"]) {
          locationManager = [[CLLocationManager alloc] init];
          locationManager.delegate = self;
          locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
          locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
          [locationManager startUpdatingLocation];
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
