//
//  FavoriteViewController.m
//  RSSReaderApp
//
//  Created by Simon on 9/8/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import "FavoriteViewController.h"
#import "MyApp.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController


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
    
    [self initLabelsandView];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self.appTextView scrollRangeToVisible:NSMakeRange(0, 0)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initLabelsandView
{
    self.title = self.coreDataApp.appName;
    
    NSData *imageData = [NSData dataWithData:[self.coreDataApp appPic]];
    UIImage *myCoreImage = [UIImage imageWithData:imageData];
    
    self.appImageView.image = myCoreImage;
    self.appArtistLabel.text = [self.coreDataApp appArtist];
    self.appCostLabel.text = [self.coreDataApp appPrice];
    self.appReleaseLabel.text = [self.coreDataApp appRelease];
    self.appTextView.text = [self.coreDataApp appInfo];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // do something after rotation
    [self.appTextView scrollRangeToVisible:NSMakeRange(0, 0)];
}

@end
