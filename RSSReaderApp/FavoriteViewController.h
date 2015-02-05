//
//  FavoriteViewController.h
//  RSSReaderApp
//
//  Created by Simon on 9/8/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyApp;


@interface FavoriteViewController : UIViewController

@property (nonatomic, strong) MyApp *coreDataApp;

@property (strong, nonatomic) IBOutlet UIImageView *appImageView;
@property (strong, nonatomic) IBOutlet UILabel *appArtistLabel;
@property (strong, nonatomic) IBOutlet UILabel *appReleaseLabel;
@property (strong, nonatomic) IBOutlet UILabel *appCostLabel;
@property (strong, nonatomic) IBOutlet UITextView *appTextView;

@end
