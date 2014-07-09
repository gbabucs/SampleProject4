//
//  CustomActivityViewController.h
//  samplePro1
//
//  Created by bala on 5/20/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CustomActivityViewController : UIViewController{
    UIImageView *baseImageView;
    UILabel *loadingText;
    UIActivityIndicatorView *activityIndicator;
}
@property(assign)UIActivityIndicatorView *activityIndicator;
- (void) startAnimating;
- (void) stopAnimating;
@end
