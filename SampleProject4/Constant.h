//
//  Constant.h
//  DropDownTable
//
//  Created by bala on 10/28/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#ifndef DropDownTable_Constant_h
#define DropDownTable_Constant_h

#define  IPAD 1
#define  OTHERDEVICE 2

#define  iADS 1
#define  ADMOB 2


#define xAxis 1
#define yAxis 2

#define positiveDirection 1
#define negativeDirection -1

#define iADS            1
#define ADDMOB          2

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

float ScreenWidthRatio;
float ScreenHeightRatio;
int   Device;
int   previousClicked_Menu_id;
int   previousClicked_Menu_id1;
BOOL   isholdeViewVisible;

id    delegates;
NSString *searchTerm;
NSString *currentSelecetedLeague;
BOOL    isVideoPage;

BOOL    disableTouch;

#endif
