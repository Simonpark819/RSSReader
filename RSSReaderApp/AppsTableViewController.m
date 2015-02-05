//
//  AppsTableViewController.m
//  RSSReaderApp
//
//  Created by Simon on 7/25/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import "AppsTableViewController.h"
#import "DetailViewController.h"
#import "ItemData.h"
#import "DataInit.h"

@interface AppsTableViewController ()

@end

@implementation AppsTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Top Grossing Apps";
};


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allDataInit.appsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    ItemData *appItem = [self.allDataInit.appsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [appItem.appName objectForKey:@"appName"];
    if ([cell.textLabel.text length] >= 50) cell.textLabel.text = [cell.textLabel.text substringToIndex:50];
    
    cell.detailTextLabel.text = [appItem.appPrice objectForKey:@"appPrice"];
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    
    [[cell imageView] setImage:appItem.appImage];
    
    return cell;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create the next view controller.
    DetailViewController *detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad running iOS 3.2 or later.
        detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController~ipad" bundle:nil];
    }
    else {
        // The device is an iPhone or iPod touch.
        detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController~iphone" bundle:nil];
    }
    
    detailVC.appItem = [self.allDataInit.appsArray objectAtIndex:indexPath.row];
    // Push the view controller.
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
