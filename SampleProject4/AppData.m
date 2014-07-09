//
//  addData.m
//  SampleProject4
//
//  Created by bala on 12/13/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "AppData.h"


@implementation AppData
@synthesize _mainMenu,_teamList,_tagList;
    
static AppData *sharedInstance;


+ (AppData *)sharedAPPInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
        sharedInstance._mainMenu = [[NSMutableArray alloc] init];
        sharedInstance._teamList = [[NSMutableArray alloc] init];
        sharedInstance._tagList = [[NSMutableArray alloc] init];
        [sharedInstance parsePlistData];
    }
    
    return sharedInstance;
}

- (void)parsePlistData{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"MainMenu" ofType:@"plist"];
    
    NSArray *allMainMenuContent = [[NSArray alloc] initWithContentsOfFile:filePath];

    for(int i = 0 ; i < [allMainMenuContent count]; i++){        
        NSDictionary *eachMainMenuContent = [allMainMenuContent objectAtIndex:i];
        [_mainMenu addObject:eachMainMenuContent];
    }
    
    filePath = [[NSBundle mainBundle] pathForResource:@"Team" ofType:@"plist"];
    
    NSArray *allTeamContent = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    for(int i = 0 ; i < [allTeamContent count]; i++){
        NSDictionary *eachTeamContent = [allTeamContent objectAtIndex:i];
        [_teamList addObject:eachTeamContent];
    }
    
    filePath = [[NSBundle mainBundle] pathForResource:@"TagList" ofType:@"plist"];
    
    NSArray *allTagContent = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    for(int i = 0 ; i < [allTagContent count]; i++){
        NSDictionary *eachTagContent = [allTagContent objectAtIndex:i];
        [_tagList addObject:eachTagContent];
    }
}

@end
