//
//  AppsTableViewController.h
//  RSSReaderApp
//
//  Created by Simon on 7/25/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataInit;


@interface AppsTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) DataInit *allDataInit;


@end
