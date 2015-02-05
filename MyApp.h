//
//  MyApp.h
//  RSSReaderApp
//
//  Created by Simon on 9/8/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyApp : NSManagedObject

@property (nonatomic, retain) NSString * appArtist;
@property (nonatomic, retain) NSString * appID;
@property (nonatomic, retain) NSString * appInfo;
@property (nonatomic, retain) NSString * appName;
@property (nonatomic, retain) NSData * appPic;
@property (nonatomic, retain) NSString * appPrice;
@property (nonatomic, retain) NSString * appRelease;
@property (nonatomic, retain) NSString * appRights;
@property (nonatomic, retain) NSString * appURL;

@end
