//
//  AppDelegate.h
//  RSSReaderApp
//
//  Created by Simon on 7/25/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataInit;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) DataInit *dataParser;


//====Core Data====
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(NSMutableArray*)reloadCoreData;
-(void)reloadCoreDataWithArray:(NSMutableArray*)reloadArray;
//=================

@end
