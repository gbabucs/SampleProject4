//
//  HeaderViewController.h
//  sampleProject3
//
//  Created by bala on 11/5/13.
//
//

#import <UIKit/UIKit.h>

@interface HeaderViewController : UIView{
    
}
@property  UIButton     *backButton;
+(id) headerViewSharedInstance:(id)delegate;
+(id) getHeaderSharedInstance;

- (void) shownInfo:(NSString *)erroMessage;
- (void) disableInfoMessage;

- (void) shownVideoName:(NSString *)erroMessage;
- (void) disableVideoNameMessage;

- (void) showError:(NSString *)erroMessage;
@end
