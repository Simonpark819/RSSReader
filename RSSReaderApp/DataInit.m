//
//  DataInit.m
//  RSSReaderApp
//
//  Created by Simon on 8/18/14.
//  Copyright (c) 2014 Clover. All rights reserved.
//

#define jsonLink "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topgrossingapplications/sf=143441/limit=25/json"

#import "DataInit.h"
#import "ItemData.h"

@implementation DataInit


-(void)loadJSONwithCompletionHandler:(void (^)(void))handler
{
    NSLog(@"Loading JSON!");
    
    self.completionHandler = handler;
    
     AFHTTPRequestOperationManager *requestOP = [[AFHTTPRequestOperationManager alloc]init];
    [requestOP GET:@jsonLink parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

    //Populate an array with only the entries of the json data.
    NSArray *jsonArray = [responseObject valueForKeyPath:@"feed.entry"];
    self.appsArray = [[NSMutableArray alloc]init];
        
    [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        ItemData *itemDatas = [[ItemData alloc]init];
        
        [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([key isEqual:@"im:name"]) {
                itemDatas.appName = [NSMutableDictionary new];
                [itemDatas.appName setValue:[obj objectForKey:@"label"] forKey:@"appName"];
            } else if ([key isEqual:@"im:image"]) {
                itemDatas.appImages = obj;
            } else if ([key isEqual:@"summary"]) {
                itemDatas.appDescrip = [NSMutableDictionary new];
                [itemDatas.appDescrip setValue:[obj objectForKey:@"label"] forKey:@"appDescrip"];
            } else if ([key isEqual:@"im:price"]) {
                itemDatas.appPrice = [NSMutableDictionary new];
                [itemDatas.appPrice setValue:[obj objectForKey:@"label"] forKey:@"appPrice"];
            } else if ([key isEqual:@"rights"]) {
                itemDatas.appRights = [NSMutableDictionary new];
                [itemDatas.appRights setValue:[obj objectForKey:@"label"] forKey:@"appRights"];
            } else if ([key isEqual:@"link"]) {
                itemDatas.appURL = [NSMutableDictionary new];
                [itemDatas.appURL setValue:[[obj objectForKey:@"attributes"] objectForKey:@"href"] forKey:@"appURL"];
            } else if ([key isEqual:@"id"]) {
                itemDatas.appID = [NSMutableDictionary new];
                [itemDatas.appID setValue:[[obj objectForKey:@"attributes"] objectForKey:@"im:id"] forKey:@"appID"];
            } else if ([key isEqual:@"im:artist"]) {
                itemDatas.appArtist = [NSMutableDictionary new];
                [itemDatas.appArtist setValue:[obj objectForKey:@"label"] forKey:@"appArtist"];
            } else if ([key isEqual:@"im:releaseDate"]) {
                itemDatas.appRelease = [NSMutableDictionary new];
                [itemDatas.appRelease setValue:[[obj objectForKey:@"attributes"] objectForKey:@"label"] forKey:@"appRelease"];
            }
        }];
        
        //initial placeholder image before images are done loading
        itemDatas.appImage = [UIImage imageNamed:@"applelogo.jpg"];
        
        //dispatching a serial queue for our images
        dispatch_queue_t imageDownloadQueue = dispatch_queue_create("imageDownloadQueue", NULL);
        dispatch_async(imageDownloadQueue, ^{
            
            NSURL *url = [NSURL URLWithString:[[itemDatas.appImages objectAtIndex:2] objectForKey:@"label"]];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:imageData];
            itemDatas.appImage = image;
            
            self.completionHandler();
        });
        
        [self.appsArray addObject:itemDatas];
    }];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}



@end
