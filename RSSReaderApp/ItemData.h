//
//  ItemData.h
//  RSSReaderApp
//
//  Created by Simon on 8/11/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemData : NSObject

@property (nonatomic, strong) NSMutableDictionary *appName;
@property (nonatomic, strong) NSArray *appImages;
@property (nonatomic, strong) UIImage *appImage;
@property (nonatomic, strong) NSMutableDictionary *appDescrip;
@property (nonatomic, strong) NSMutableDictionary *appPrice;
@property (nonatomic, strong) NSMutableDictionary *appRights;
@property (nonatomic, strong) NSMutableDictionary *appURL;
@property (nonatomic, strong) NSMutableDictionary *appID;
@property (nonatomic, strong) NSMutableDictionary *appArtist;
@property (nonatomic, strong) NSMutableDictionary *appRelease;

@end
