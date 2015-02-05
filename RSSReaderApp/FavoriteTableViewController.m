//
//  FavoriteTableViewController.m
//  RSSReaderApp
//
//  Created by Simon on 8/20/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "MyApp.h"
#import "AppDelegate.h"
#import "FavoriteViewController.h"

@interface FavoriteTableViewController ()

@end


@implementation FavoriteTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"My Favorite Apps";
    
    self.appDel = [UIApplication sharedApplication].delegate;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    
    if ([self.tableView isEditing]) {
        
        [self.tableView setEditing:NO];
    }
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
    return [self.myFaveApps count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    MyApp *myCoreApp = [self.myFaveApps objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [myCoreApp appName];
    if ([cell.textLabel.text length] >= 50) cell.textLabel.text = [cell.textLabel.text substringToIndex:50];
    cell.detailTextLabel.text = [myCoreApp appPrice];
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    
    NSData *imageData = [NSData dataWithData:[myCoreApp appPic]];
    UIImage *myCoreImage = [UIImage imageWithData:imageData];
    
    [[cell imageView] setImage:myCoreImage];
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MyApp *myCoreApp = [self.myFaveApps objectAtIndex:indexPath.row];
        
        //delete the object from core data, array, tableview, reload the core data, and save changes.
        [self.appDel.managedObjectContext deleteObject:myCoreApp];
        [self.myFaveApps removeObjectAtIndex:indexPath.row];
        [self.appDel reloadCoreDataWithArray:self.myFaveApps];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.appDel saveContext];
        
        self.tableView.editing = NO;
        
        NSLog(@"Object deleted from CoreData");
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavoriteViewController *favoriteVC = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController" bundle:nil];

    
    // Pass the selected object to the new view controller.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad running iOS 3.2 or later.
        favoriteVC = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController~ipad" bundle:nil];
    }
    else {
        // The device is an iPhone or iPod touch.
        favoriteVC = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController~iphone" bundle:nil];
    }
    
    
    favoriteVC.coreDataApp = [self.myFaveApps objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:favoriteVC animated:YES];
}


@end
