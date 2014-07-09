//
//  AdsWrapper.m
//  samplePro1
//
//  Created by bala on 9/23/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "AdsWrapper.h"
#import "HeaderViewController.h"


@implementation AdsWrapper
@synthesize adBannerView,bannerView_;
@synthesize adBannerViewIsVisible = _adBannerViewIsVisible;
addedLoaded localAddloaded;

int iADSFailed = YES;

static  AdsWrapper *sharedAdsWrapperInstance = nil;


+(id) getAdsSharedInstance{
    if(sharedAdsWrapperInstance == nil){
        
        sharedAdsWrapperInstance = [[super alloc] init];      
        
        
        if(Device == IPAD){
            sharedAdsWrapperInstance.view = [[UIView alloc] initWithFrame:CGRectMake(0, (768-180)/ScreenHeightRatio, 1024/ScreenWidthRatio, 90/ScreenHeightRatio)];
        }else{
            sharedAdsWrapperInstance.view = [[UIView alloc] initWithFrame:CGRectMake(0, (768-85)/ScreenHeightRatio - 60, 1024/ScreenWidthRatio, 60)];
        }
        
        // On iOS 6 ADBannerView introduces a new initializer, use it when available.
        [sharedAdsWrapperInstance createADMOBBannerAds];
        //[self createAdBannerView];
        [[NSNotificationCenter defaultCenter] addObserver:sharedAdsWrapperInstance selector:@selector(changeOrientaion) name:@"orientation" object:nil];
    }
    return sharedAdsWrapperInstance;
}

-(id) init{
    if(self = [super init]){       
       
        
        
    }
    return self;
}

- (void) addAdsView:(addedLoaded)isloaded{
    localAddloaded = [isloaded copy];
}

- (void)createADMOBBannerAds{
    CGPoint origin = CGPointMake(0.0/ScreenWidthRatio,0.0);
    if(Device == OTHERDEVICE){
        bannerView_ = [[[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:origin] autorelease];
    }else{
        bannerView_ = [[[GADBannerView alloc] initWithAdSize:kGADAdSizeLeaderboard origin:origin] autorelease];
    }
    
    bannerView_.adUnitID = @"a1524be03e56efc";
    bannerView_.delegate = self;  
    bannerView_.rootViewController = self;  
    
    
    bannerView_.frame = CGRectMake(150/ScreenWidthRatio, 0, bannerView_.frame.size.width, bannerView_.frame.size.height);
    
    [self.view addSubview:bannerView_];
    //bannerView_.hidden = YES;
    
   //[GADRequest request].testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];
    [bannerView_ loadRequest:[GADRequest request]];
   
   
}

- (void)createAdBannerView {
    Class classAdBannerView = NSClassFromString(@"ADBannerView");
    if (classAdBannerView != nil) {
        self.adBannerView = [[[classAdBannerView alloc] initWithFrame:CGRectZero] autorelease];
        
        if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
            adBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        } else {
            adBannerView = [[ADBannerView alloc] init];
        }
        adBannerView.delegate = self;
        if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown ){           
            adBannerView.frame = CGRectMake(0, 0, adBannerView.frame.size.width, adBannerView.frame.size.height);
        }
        if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight){//from landscape to portrait
            adBannerView.frame = CGRectMake(adBannerView.frame.size.width/6, 0, adBannerView.frame.size.width, adBannerView.frame.size.height);
            
        }
    }
[self.view addSubview:adBannerView];
    adBannerView.hidden = YES;    
    iADSFailed = YES;
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{    
    if([error code] == -1009){
        [[HeaderViewController getHeaderSharedInstance] showError:@"Network error"];
        return;
    }
    iADSFailed = YES;
    adBannerView.hidden = YES;
    bannerView_.hidden = NO;
    localAddloaded(-iADS);
    
}
-(void) bannerViewDidLoadAd:(ADBannerView *)banner{    
    iADSFailed = NO;
    
    adBannerView.hidden = NO;
    bannerView_.hidden = YES;
    
    localAddloaded(iADS);
}

- (void)adViewDidReceiveAd:(GADBannerView *)view{    
    if(iADSFailed || adBannerView.hidden){
        bannerView_.hidden = NO;        
    }
    localAddloaded(ADDMOB);
}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error{   
    bannerView_.hidden = YES;
   localAddloaded(-ADDMOB);
}

- (void) changeOrientaion{   
      
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    if(deviceOrientation == UIDeviceOrientationLandscapeLeft || deviceOrientation == UIDeviceOrientationLandscapeRight){
        //adBannerView.frame = CGRectMake(adBannerView.frame.size.width/6, 0, adBannerView.frame.size.width, adBannerView.frame.size.height);
        
       // bannerView_.frame = CGRectMake(150/ScreenWidthRatio, 0, bannerView_.frame.size.width, bannerView_.frame.size.height);
       
        if(Device == IPAD){
            sharedAdsWrapperInstance.view = [[UIView alloc] initWithFrame:CGRectMake(0, (768-180)/ScreenHeightRatio, 1024/ScreenWidthRatio, 90/ScreenHeightRatio)];
        }else{
            sharedAdsWrapperInstance.view = [[UIView alloc] initWithFrame:CGRectMake(0, (768-90)/ScreenHeightRatio - 60, 1024/ScreenWidthRatio, 60)];
        }
        
    }
    if(deviceOrientation == UIDeviceOrientationPortrait || deviceOrientation == UIDeviceOrientationPortraitUpsideDown){
        adBannerView.frame = CGRectMake(0, 0, adBannerView.frame.size.width, adBannerView.frame.size.height);
        bannerView_.frame = CGRectMake(20/ScreenWidthRatio,0, bannerView_.frame.size.width, bannerView_.frame.size.height);
        self.view.frame = CGRectMake(0, 70/ScreenWidthRatio, 768/ScreenWidthRatio, 90/ScreenHeightRatio);
        
    }
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
    
}
@end
