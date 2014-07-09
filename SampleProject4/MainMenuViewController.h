//
//  MainMenuViewController.h
//  SampleProject4
//
//  Created by bala on 12/13/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIView<UIScrollViewDelegate>{
    
}
- (void) loadTeam:(int)teamID;

@property(strong) UIScrollView   *baseScrollView;
- (void) ChangeTitle:(int)index;
@end
