//
//  AdsWrapper.h
//  samplePro1
//
//  Created by bala on 9/23/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import "GADBannerView.h"
#import "GADBannerViewDelegate.h"

typedef void (^addedLoaded)(int _addLoaded);

@interface AdsWrapper : UIViewController<ADBannerViewDelegate,GADBannerViewDelegate>{

}

@property (atomic, retain) ADBannerView *adBannerView;
@property(atomic ,retain)GADBannerView *bannerView_;
@property (atomic) BOOL adBannerViewIsVisible;

- (void) addAdsView:(addedLoaded)isloaded;
+(id) getAdsSharedInstance;
@end
