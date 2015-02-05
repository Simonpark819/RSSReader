//
//  DetailViewController.m
//  RSSReaderApp
//
//  Created by Simon on 7/25/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import "DetailViewController.h"
#import "FavoriteTableViewController.h"
#import "AppDelegate.h"
#import "MyApp.h"
#import "ItemData.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        self.faveTable = [[FavoriteTableViewController alloc]init];
        
        //populating the favorite list from core data
        self.favoriteList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [self.appItem.appName objectForKey:@"appName"];
    
    self.appDel = [UIApplication sharedApplication].delegate;
    
    [self reloadFavorites];
    [self initButtonsAndLabels];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.textViewDescrip scrollRangeToVisible:NSMakeRange(0, 0)];
    
    [self reloadFavorites];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveButton:(id)sender {
    
    if (favoredApp) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Already in favorites!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alertView show];
        
        return;
        
    } else {
        
        //Saving to CoreData for our favorite list
        MyApp *myApp = [NSEntityDescription insertNewObjectForEntityForName:@"MyApp" inManagedObjectContext: [self.appDel managedObjectContext]];
        
        myApp.appName = [self.appItem.appName objectForKey:@"appName"];
        myApp.appInfo = [self.appItem.appDescrip objectForKey:@"appDescrip"];
        
        NSData *imageData = [[NSData alloc]init];
        imageData = UIImageJPEGRepresentation(self.appItem.appImage, 1);
        myApp.appPic = imageData;
        
        myApp.appPrice = [self.appItem.appPrice objectForKey:@"appPrice"];
        myApp.appURL = [self.appItem.appURL objectForKey:@"appURL"];
        myApp.appArtist = [self.appItem.appArtist objectForKey:@"appArtist"];
        myApp.appRelease = [self.appItem.appRelease objectForKey:@"appRelease"];
        myApp.appRights = [self.appItem.appRights objectForKey:@"appRights"];
        myApp.appID = [self.appItem.appID objectForKey:@"appID"];
        
        
        NSError *error;
        if (![[self.appDel managedObjectContext] save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        } else {
            [self.favoriteList addObject:myApp];
            NSLog(@"favorite: %@", self.favoriteList);
            
            [self.appDel reloadCoreDataWithArray:self.favoriteList];
            
            self.faveTable.myFaveApps = [[NSMutableArray alloc]initWithArray:self.favoriteList];
            [self.faveTable.tableView reloadData];
            
            //Flag for our favorite apps list
            favoredApp = YES;
            
            //Tell the user of the update
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Saved" message:@"App has been added to favorites!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alertView show];
        }
        
    }
}


-(void)myFaveList {
    
    [self.appDel reloadCoreDataWithArray:self.favoriteList];
    
    self.faveTable.myFaveApps = [[NSMutableArray alloc]initWithArray:self.favoriteList];
    
    [self.navigationController pushViewController:self.faveTable animated:YES];
}


#pragma mark - Sharing/Social Functions
-(void)shareFunctions
{
    NSString *defaultMSG = @"Check out this cool app!";
    
    UIActivityViewController *actVC = [[UIActivityViewController alloc] initWithActivityItems:@[defaultMSG, [self.appItem.appURL objectForKey:@"appURL"]] applicationActivities:nil];
    
    actVC.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                     UIActivityTypeMessage,
                                     UIActivityTypePrint,
                                     UIActivityTypeAssignToContact,
                                     UIActivityTypeSaveToCameraRoll,
                                     UIActivityTypeAddToReadingList,
                                     UIActivityTypePostToFlickr,
                                     UIActivityTypePostToVimeo,
                                     UIActivityTypePostToTencentWeibo,
                                     UIActivityTypeAirDrop];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        self.popVC = [[UIPopoverController alloc] initWithContentViewController:actVC];
        
        [self.popVC presentPopoverFromBarButtonItem:self.sharingButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        [self presentViewController:actVC animated:YES completion:nil];
    }
    
}


#pragma mark - Loading and Initializing
-(void)reloadFavorites
{
    favoredApp = NO;
    
    self.favoriteList = [self.appDel reloadCoreData];
    
    //Checking to see if the selected app is already in favorites
    for (MyApp *obj in self.favoriteList) {
        if ([[obj appID] isEqualToString:[NSString stringWithFormat:@"%@", [self.appItem.appID objectForKey:@"appID"]]])
        {
            favoredApp = YES;
            return;
        } else {
            favoredApp = NO;
        }
    };
}


-(void)initButtonsAndLabels
{
    self.sharingButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareFunctions)];
    self.myFavoritesButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(myFaveList)];
    
    [self.navigationItem setRightBarButtonItems:@[self.sharingButton, self.myFavoritesButton]];
    
    self.imageViwer.image = self.appItem.appImage;
    self.textViewDescrip.text = [self.appItem.appDescrip objectForKey:@"appDescrip"];
    self.appCostLabel.text = [NSString stringWithFormat:@"Cost: %@", [self.appItem.appPrice objectForKey:@"appPrice"]];
    self.appArtist.text = [self.appItem.appArtist objectForKey:@"appArtist"];
    self.appRelease.text = [self.appItem.appRelease objectForKey:@"appRelease"];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // do something after rotation
    [self.textViewDescrip scrollRangeToVisible:NSMakeRange(0, 0)];
}



@end
