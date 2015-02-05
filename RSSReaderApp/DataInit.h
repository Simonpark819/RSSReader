//
//  DataInit.h
//  RSSReaderApp
//
//  Created by Simon on 8/18/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemData;

@interface DataInit : NSObject

@property (nonatomic, strong) ItemData *appItemData;

@property (nonatomic, strong) NSMutableArray *appsArray;

-(void)loadJSONwithCompletionHandler:(void (^)(void))handler;
@property (nonatomic, strong) void(^completionHandler)(void);


@end
