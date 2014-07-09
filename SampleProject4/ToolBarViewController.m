//
//  ToolBarViewController.m
//  SampleProject4
//
//  Created by bala on 12/16/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "ToolBarViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ToolBarViewController (){
    UIImageView  *headerImageview;
    UIButton *menuItem[10];
     UIButton *tagItem[10];
    NSArray *mainMenuContent;
    NSArray *tagList;
}

@end

@implementation ToolBarViewController


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerimage.png"]];
        bgImage.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:bgImage];
        
        //self.backgroundColor = [UIColor redColor];
        mainMenuContent = [AppData sharedAPPInstance]._mainMenu;
        tagList = [AppData sharedAPPInstance]._tagList;
        [self createMenu];
    }
    return self;
}

- (void) createMenu{
    for(int i = 0 ; i < [mainMenuContent count];i++){
        NSDictionary *eachMenuItem = [mainMenuContent objectAtIndex:i];        
        menuItem[i] = [UIButton buttonItemWithImage:[UIImage imageNamed:[eachMenuItem objectForKey:@"image"]] target:delegates action:@selector(loadTeamIcon:) position:CGRectMake((100+(i*180))/ScreenWidthRatio,2, 85/ScreenWidthRatio, 85/ScreenHeightRatio) tag:[[eachMenuItem objectForKey:@"id"] integerValue]];
        
        menuItem[i].layer.cornerRadius = 8;
        menuItem[i].layer.masksToBounds = YES;
        [self addSubview:menuItem[i]];
    }
    
    int xDirectionCount = 0;
    int yDirectionCount = 0;
    for(int i = 0 ; i < [tagList count];i++){
        if(xDirectionCount == 2){
            xDirectionCount = 0;
            yDirectionCount++;
        }
        NSDictionary *eachMenuItem = [tagList objectAtIndex:i];
        tagItem[i] = [UIButton buttonItemWithText:[eachMenuItem objectForKey:@"name"] textColor:[UIColor whiteColor] fontSize:20/ScreenWidthRatio target:delegates action:@selector(loadTag_rel_videos:) position:CGRectMake((750+(xDirectionCount*120))/ScreenHeightRatio,5+(yDirectionCount*40)/ScreenHeightRatio, 100/ScreenWidthRatio, 40/ScreenHeightRatio) tag:i];
        [self addSubview:tagItem[i]];
        xDirectionCount++;
    }
}

- (void) doButtonAnimation:(UIButton *)buttonView  animationAxis:(int)axis animationDirection:(int)direction moveDistance:(int)distance{
    CGRect newFrame = buttonView.frame;
    
    if(axis == xAxis)
        newFrame.origin.x += distance*direction;
    else
        newFrame.origin.y += distance*direction;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:.01];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    
    buttonView.frame = newFrame;
    [UIView commitAnimations];
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

- (void) dealloc{    
    [super dealloc];
}

@end
