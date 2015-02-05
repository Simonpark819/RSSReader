//
//  DetailViewController.h
//  RSSReaderApp
//
//  Created by Simon on 7/25/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FavoriteTableViewController;
@class AppDelegate;
@class ItemData;
@class MyApp;


@interface DetailViewController : UIViewController
{
    bool favoredApp;
}

@property (nonatomic, strong) FavoriteTableViewController *faveTable;
@property (nonatomic, strong) AppDelegate *appDel;
@property (nonatomic, strong) ItemData *appItem;

@property (nonatomic, strong) NSString *currentAppID;

//Core Data
@property (nonatomic, retain) NSMutableArray *favoriteList;

//Xib Outlets/Labels
@property (strong, nonatomic) IBOutlet UIImageView *imageViwer;
@property (strong, nonatomic) IBOutlet UITextView *textViewDescrip;
@property (strong, nonatomic) IBOutlet UILabel *appCostLabel;
@property (strong, nonatomic) IBOutlet UILabel *appRelease;
@property (strong, nonatomic) IBOutlet UILabel *appArtist;


//Social/Sharing Functions
@property (nonatomic, strong) UIPopoverController *popVC;
@property (nonatomic, strong) UIBarButtonItem *sharingButton;
@property (nonatomic, strong) UIBarButtonItem *myFavoritesButton;


//Buttons
- (IBAction)saveButton:(id)sender;
-(void)shareFunctions;
-(void)myFaveList;

-(void)initButtonsAndLabels;
-(void)reloadFavorites;


@end
