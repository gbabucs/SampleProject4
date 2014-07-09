//
//  addData.h
//  SampleProject4
//
//  Created by bala on 12/13/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject{
    
} 
@property (strong) NSMutableArray *_mainMenu;
@property (strong) NSMutableArray *_teamList;
@property (strong) NSMutableArray *_tagList;

+ (AppData *)sharedAPPInstance;

@end
