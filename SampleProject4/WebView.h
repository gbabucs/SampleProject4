//
//  WebView.h
//  SampleProject4
//
//  Created by bala on 12/17/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebView : UIView <UIWebViewDelegate>{
    
}

- (void)loadWebPage:(NSString*)weburl;
- (BOOL) webViewGoBack;

@property BOOL _disableGoback;
@end
