//
//  HomeViewController.m
//  Piyavate Care
//
//  Created by hudsioo on 4/10/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "HomeViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "AskDoctorViewController.h"
#import "WebViewController.h"
#import "HealthCheckViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"Update");
    self.currentLocation = newLocation.coordinate;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    [locationManager startUpdatingLocation];
}

- (IBAction)openGetHealth:(id)sender {
}

- (IBAction)openAskDoctor:(id)sender {
    AskDoctorViewController * askVC = [[AskDoctorViewController alloc] initWithNibName:@"AskDoctorViewController" bundle:nil];
    [self presentViewController:askVC animated:YES completion:nil];
}

- (IBAction)openHealthCheck:(id)sender {
    HealthCheckViewController * healthVC = [[HealthCheckViewController alloc] initWithNibName:@"HealthCheckViewController" bundle:nil];
    [self presentViewController:healthVC animated:YES completion:nil];
}

- (IBAction)openWorkingCare:(id)sender {
    WebViewController * webVC = [[WebViewController alloc] initWithURL:@"http://www.piyavatecare.com/home/articles/working-care" andTitle:@"Working Care"];
    UINavigationController * nv = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nv animated:YES completion:nil];
}

- (IBAction)openElderlyCare:(id)sender {
    WebViewController * webVC = [[WebViewController alloc] initWithURL:@"http://www.piyavatecare.com/home/articles/elderly-care" andTitle:@"Elderly Care"];
    UINavigationController * nv = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nv animated:YES completion:nil];
}

- (IBAction)openWomenCare:(id)sender {
    WebViewController * webVC = [[WebViewController alloc] initWithURL:@"http://www.piyavatecare.com/home/articles/women-care" andTitle:@"Women Care"];
    UINavigationController * nv = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nv animated:YES completion:nil];
}

- (IBAction)openWellbeingCare:(id)sender {
    WebViewController * webVC = [[WebViewController alloc] initWithURL:@"http://www.piyavatecare.com/home/articles/wellbeing-care" andTitle:@"Wellbeing Care"];
    UINavigationController * nv = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nv animated:YES completion:nil];
}

- (IBAction)openPromotion:(id)sender {
    WebViewController * webVC = [[WebViewController alloc] initWithURL:@"http://www.piyavatecare.com/home/promotions" andTitle:@"Promotion"];
    UINavigationController * nv = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nv animated:YES completion:nil];
}

- (IBAction)openNews:(id)sender {
    WebViewController * webVC = [[WebViewController alloc] initWithURL:@"http://www.piyavatecare.com/home/news" andTitle:@"News"];
    UINavigationController * nv = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nv animated:YES completion:nil];
}

- (IBAction)openMaps:(id)sender {
    NSString* url = [NSString stringWithFormat: @"maps://maps.google.com/maps?xyz=xyz&saddr=%f,%f&daddr=%f,%f",self.currentLocation.latitude, self.currentLocation.longitude,13.753471,100.580063];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (IBAction)openSOS:(id)sender {
    NSURL *fileURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds/sq_alarm.caf"]; // see list below
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)fileURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (IBAction)openPiyavateLocation:(id)sender {
    WebViewController * webVC = [[WebViewController alloc] initWithURL:@"http://www.piyavatecare.com/home/contact" andTitle:@"Piyavate Care"];
    UINavigationController * nv = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nv animated:YES completion:nil];
}

- (IBAction)callEmergency:(id)sender {
    NSURL *URL = [NSURL URLWithString:@"tel://026256666"];
    [[UIApplication sharedApplication] openURL:URL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
