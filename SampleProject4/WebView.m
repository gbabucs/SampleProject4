//
//  WebView.m
//  SampleProject4
//
//  Created by bala on 12/17/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "WebView.h"
#import "CustomConnection.h"
#import "CustomActivityViewController.h"
#import "HeaderViewController.h"
#import "AdsWrapper.h"

UIWebView *webView;
CustomConnection   *connection;
CustomActivityViewController  *activityIndicator;

@implementation WebView

@synthesize _disableGoback;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        webView = [[UIWebView alloc]init];
        webView.frame = CGRectMake(0,0 ,frame.size.width, frame.size.height);
        webView.delegate = self;
        webView.backgroundColor = [UIColor clearColor];
        
        connection = [[CustomConnection alloc]init];
        activityIndicator = [[CustomActivityViewController alloc] init];
        
        
         [self addSubview:webView];
        [self addSubview:activityIndicator.view];
        [self setBackgroundColor:[UIColor colorWithRed:256.0/256.0 green:256.0/256.0 blue:256.0/256.0 alpha:1.0]];
        
        [[NSNotificationCenter defaultCenter] addObserver:delegates selector:@selector(disableTouch) name:@"disableTouch" object:nil];
    }
    return self;
}

- (void)loadWebPage:(NSString*)weburl{
   // weburl = [weburl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:weburl]; 
    [webView loadRequest:[NSURLRequest  requestWithURL:url]];      
}


- (BOOL) webViewGoBack{
    if([webView canGoBack] && !_disableGoback){
        [[HeaderViewController getHeaderSharedInstance] disableVideoNameMessage];
        [webView goBack];
        webView.scrollView.scrollEnabled = YES;
        webView.scrollView.bounces = YES;       
        _disableGoback = YES;
        return YES;
    }
return NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *myString = [[request URL] absoluteString];
    [activityIndicator startAnimating];
    if ([myString rangeOfString:@"freekicktube_ipadplayvideo"].location != NSNotFound) {
        NSArray *stringContent = [myString componentsSeparatedByString:@"ref="];
        if([stringContent count] > 1){            
            
            NSString *subString = [[myString componentsSeparatedByString:@"ref="] objectAtIndex:1];
            subString = [subString stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            [[HeaderViewController getHeaderSharedInstance] shownVideoName:subString];
            
            _disableGoback = NO;
        }
    }    
    if([webView canGoBack]){
        //webView.scrollView.scrollEnabled = NO;
        //webView.scrollView.bounces = NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    if(!activityIndicator.activityIndicator.isAnimating){
        webView.hidden = YES;
        webView.userInteractionEnabled = NO;
        [activityIndicator startAnimating];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"disableTouch" object:self];
    }
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [activityIndicator stopAnimating];
    webView.hidden = NO;
    webView.userInteractionEnabled = YES;
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"disableTouch" object:self];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Error");
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
@end
