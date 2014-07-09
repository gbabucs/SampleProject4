//
//  ViewController.m
//  SampleProject4
//
//  Created by bala on 12/13/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "ViewController.h"
#import "MainMenuViewController.h"
#import "HeaderViewController.h"
#import "ToolBarViewController.h"
#import "Constant.h"
#import "WebView.h"
#import "AdsWrapper.h"

@interface ViewController (){
    MainMenuViewController *mainMenu;
    HeaderViewController *headerView;
    ToolBarViewController *toolBar;
    WebView               *webView;
    AdsWrapper *adsWrapperInstance;
    
    UIImageView  *bgView;
    
}

@end

@implementation ViewController

- (id) initWithFrame:(CGRect)frame{
    self = [super init];
    if (self) {
        delegates = self;
        
        bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
        bgView.frame = CGRectMake(0, 0, 1024/ScreenWidthRatio, 768/ScreenHeightRatio);
        [self.view addSubview:bgView];
        
        headerView = [HeaderViewController headerViewSharedInstance:self];
        
        mainMenu = [[MainMenuViewController alloc] initWithFrame:CGRectMake(0, 0, 1024/ScreenWidthRatio, 768/ScreenHeightRatio)];
        [self.view addSubview:mainMenu];
        
        toolBar = [[ToolBarViewController alloc] initWithFrame:CGRectMake(0, (768-90)/ScreenHeightRatio, 1024/ScreenWidthRatio, 90/ScreenHeightRatio)];
        
        webView = [[WebView alloc] initWithFrame:CGRectMake(0, 65/ScreenHeightRatio, 1024/ScreenWidthRatio,(768 - 155)/ScreenHeightRatio)];
        
        [self.view addSubview:headerView];
        [self.view addSubview:toolBar];
        [self.view addSubview:webView];
        webView.hidden = YES;       
       
        adsWrapperInstance = [AdsWrapper getAdsSharedInstance];
        
        adsWrapperInstance.view.backgroundColor = [UIColor clearColor];
        [adsWrapperInstance addAdsView:^(int _addLoaded) {
            
        }];
        
        [self.view addSubview:adsWrapperInstance.view];
           
    }
    return self;
}


- (void) loadTeamVideo:(id)sender{
    
     UIButton *tempBtn = (UIButton *)sender;
    for(NSDictionary *teamDetail in [AppData sharedAPPInstance]._teamList){
        if(tempBtn.tag == [[teamDetail objectForKey:@"id"] integerValue]){
            webView.hidden = NO;
            headerView.backButton.hidden = NO;
            //toolBar.hidden = YES;
            
            searchTerm = [teamDetail objectForKey:@"name"];
            
            NSString *urlString = [[NSString alloc] initWithFormat:@"http://www.freekicktube.com/freekicktube_ipad?searchterm=%@",[searchTerm stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
            
            [headerView shownInfo:[NSString stringWithFormat:@"%@ Videos",searchTerm]];
            webView._disableGoback = YES;
            if(toolBar.frame.origin.y == 0)
                [self doViewAnimation:toolBar animationAxis:yAxis animationDirection:negativeDirection moveDistance:toolBar.frame.size.width];
            [webView loadWebPage:urlString];
            
            //
            
            if(Device == IPAD){
                adsWrapperInstance.view.frame = CGRectMake(0, (768-90)/ScreenHeightRatio,  adsWrapperInstance.view.frame.size.width, adsWrapperInstance.view.frame.size.height);
            }else{
                adsWrapperInstance.view.frame = CGRectMake(0, 768/ScreenHeightRatio - 60,  adsWrapperInstance.view.frame.size.width, adsWrapperInstance.view.frame.size.height);
                
            }
            adsWrapperInstance.view.backgroundColor = [UIColor whiteColor];
        }
    }
}

-(void) backToTeamScreen{
    if(![webView webViewGoBack]){
        headerView.backButton.hidden = YES;
        webView.hidden = YES;
        [[HeaderViewController getHeaderSharedInstance] shownInfo:currentSelecetedLeague];
        [[HeaderViewController getHeaderSharedInstance] disableVideoNameMessage];
        
        webView._disableGoback = YES;
        if(toolBar.frame.origin.y < 0)
            [self doViewAnimation:toolBar animationAxis:yAxis animationDirection:positiveDirection moveDistance:toolBar.frame.size.width];
        
        adsWrapperInstance.view.backgroundColor = [UIColor clearColor];
        if(Device == IPAD){
            adsWrapperInstance.view.frame = CGRectMake(adsWrapperInstance.view.frame.origin.x, (768-180)/ScreenHeightRatio,  adsWrapperInstance.view.frame.size.width, adsWrapperInstance.view.frame.size.height);
        }else{
            adsWrapperInstance.view.frame = CGRectMake(adsWrapperInstance.view.frame.origin.x, (768-90)/ScreenHeightRatio - 60,  adsWrapperInstance.view.frame.size.width, adsWrapperInstance.view.frame.size.height);
            
        }
        adsWrapperInstance.view.backgroundColor = [UIColor clearColor];
        
    }
}

- (void)disableTouch{
   // disableTouch = !disableTouch;
    //self.view.userInteractionEnabled = disableTouch;
}


- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft ;
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIDeviceOrientationLandscapeRight || interfaceOrientation == UIDeviceOrientationLandscapeLeft){
        return YES;
    }else
        return NO;
}

- (void)loadTeamIcon:(id)sender{
    UIButton *tempBtn = (UIButton *)sender;
    mainMenu.baseScrollView.contentOffset = CGPointMake(mainMenu.baseScrollView.frame.size.width*(tempBtn.tag - 1),0);
    [mainMenu ChangeTitle:tempBtn.tag];
    //[self doViewAnimation:toolBar animationAxis:yAxis animationDirection:positiveDirection moveDistance:toolBar.frame.size.width];

}

- (void)loadTag_rel_videos:(id)sender{
    UIButton *tempBtn = (UIButton *)sender;
    NSDictionary *tagDetail = [[AppData sharedAPPInstance]._tagList objectAtIndex:tempBtn.tag];
    searchTerm = [tagDetail objectForKey:@"searchterm"];
    if(toolBar.frame.origin.y == 0){
     [self doViewAnimation:toolBar animationAxis:yAxis animationDirection:negativeDirection moveDistance:toolBar.frame.size.width];
    }
    [self loadVideofromTag];
}

- (void) loadVideofromTag{
    
    webView.hidden = NO;
    headerView.backButton.hidden = NO;
    //toolBar.hidden = YES;   
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://www.freekicktube.com/freekicktube_ipad?searchterm=%@",[searchTerm stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
        
    [headerView shownInfo:[NSString stringWithFormat:@"%@ Videos",searchTerm]];
    
    webView._disableGoback = YES;
    [webView loadWebPage:urlString];
    if(Device == IPAD){
        adsWrapperInstance.view.frame = CGRectMake(0, (768-90)/ScreenHeightRatio,  adsWrapperInstance.view.frame.size.width, adsWrapperInstance.view.frame.size.height);
    }else{
        adsWrapperInstance.view.frame = CGRectMake(0, 768/ScreenHeightRatio - 60,  adsWrapperInstance.view.frame.size.width, adsWrapperInstance.view.frame.size.height);
        
    }
    adsWrapperInstance.view.backgroundColor = [UIColor whiteColor];
}

- (void) doViewAnimation:(UIView *)view  animationAxis:(int)axis animationDirection:(int)direction moveDistance:(int)distance{//direction(1,-1) or axis(x=1,y=2)
    
    
    CGRect newFrame = view.frame;
    
    if(axis == xAxis)
        newFrame.origin.x += distance*direction;
    else
        newFrame.origin.y += distance*direction;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:.01];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    
    view.frame = newFrame;
    [UIView commitAnimations];
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


@end
