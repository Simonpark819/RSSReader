//
//  FavoriteTableViewController.h
//  RSSReaderApp
//
//  Created by Simon on 8/20/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyApp;
@class AppDelegate;
@class FavoriteViewController;

@interface FavoriteTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray *myFaveApps;
@property (nonatomic, strong) AppDelegate *appDel;


@end
