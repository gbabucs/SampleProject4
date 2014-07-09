//
//  HeaderViewController.m
//  sampleProject3
//
//  Created by bala on 11/5/13.
//
//

#import "HeaderViewController.h"
#import "AppData.h"
#import  "UIButton+CustomButton.h"
#import <QuartzCore/QuartzCore.h>

#define xAxis 1
#define yAxis 2

@interface HeaderViewController (){
    //UIButton     *mainHeadeButton[3];
    UILabel     *errorLabel;
    UIImageView  *headerImageview;

    UILabel     *Infolabel;
    UILabel     *VideoNamelabel;
}

@end

@implementation HeaderViewController
@synthesize backButton;
static  HeaderViewController *sharedHeaderInstance = nil;


+(id) headerViewSharedInstance:(id)delegate{
    if(sharedHeaderInstance == nil){
        sharedHeaderInstance = [[super allocWithZone:NULL] init];
               
        sharedHeaderInstance.frame = CGRectMake(0, 0, 1024/ScreenWidthRatio, 65/ScreenHeightRatio);
        UIImage *headerImage = [UIImage imageNamed: @"headerimage.png"];
        sharedHeaderInstance->headerImageview = [[UIImageView alloc] initWithImage: headerImage];
        sharedHeaderInstance->headerImageview.frame = sharedHeaderInstance.frame;
        
        sharedHeaderInstance->errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(490/ScreenWidthRatio,25/ScreenHeightRatio, 300/ScreenWidthRatio, 20/ScreenHeightRatio)];
        [sharedHeaderInstance->errorLabel setBackgroundColor: [UIColor clearColor]];
        [sharedHeaderInstance->errorLabel  setTextColor: [UIColor whiteColor]];
        [sharedHeaderInstance->errorLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16/ScreenHeightRatio]];
        sharedHeaderInstance->errorLabel.numberOfLines = 0;
        
        sharedHeaderInstance->Infolabel = [[UILabel alloc] initWithFrame:CGRectMake(420/ScreenWidthRatio,5/ScreenHeightRatio, 250/ScreenWidthRatio, 20/ScreenHeightRatio)];
        [sharedHeaderInstance->Infolabel setBackgroundColor: [UIColor clearColor]];
        [sharedHeaderInstance->Infolabel  setTextColor: [UIColor whiteColor]];
        [sharedHeaderInstance->Infolabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18/ScreenHeightRatio]];
        sharedHeaderInstance->Infolabel.numberOfLines = 0;
        
        sharedHeaderInstance->VideoNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(220/ScreenWidthRatio,20/ScreenHeightRatio, 600/ScreenWidthRatio, 40/ScreenHeightRatio)];
        [sharedHeaderInstance->VideoNamelabel setBackgroundColor: [UIColor clearColor]];
        [sharedHeaderInstance->VideoNamelabel  setTextColor: [UIColor whiteColor]];
        [sharedHeaderInstance->VideoNamelabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16/ScreenHeightRatio]];
        sharedHeaderInstance->VideoNamelabel.numberOfLines = 0;
        
        [sharedHeaderInstance addSubview:sharedHeaderInstance->headerImageview];       
        [sharedHeaderInstance addSubview:sharedHeaderInstance->errorLabel];
        [sharedHeaderInstance addSubview:sharedHeaderInstance->Infolabel];
        [sharedHeaderInstance addSubview:sharedHeaderInstance->VideoNamelabel];
        
        sharedHeaderInstance->backButton = [UIButton buttonItemWithImage:[UIImage imageNamed:@"BackArrow.jpg"] target:delegate action:@selector(backToTeamScreen) position:CGRectMake(20/ScreenWidthRatio,7/ScreenHeightRatio ,50/ScreenWidthRatio, 50/ScreenHeightRatio) tag:1];
        [sharedHeaderInstance addSubview:sharedHeaderInstance->backButton];
        sharedHeaderInstance->backButton.layer.cornerRadius = 8;
        sharedHeaderInstance->backButton.layer.masksToBounds = YES;
        sharedHeaderInstance->backButton.hidden = YES;
    }
    return sharedHeaderInstance;
}

+(id) getHeaderSharedInstance{
    return sharedHeaderInstance;
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

- (void) showError:(NSString *)erroMessage{
    sharedHeaderInstance->errorLabel.text = erroMessage;
    sharedHeaderInstance->errorLabel.hidden = NO;
}

- (void) disableErrorMessage{
    sharedHeaderInstance->errorLabel.hidden = YES;
}

- (void) shownInfo:(NSString *)erroMessage{
    erroMessage = [erroMessage capitalizedString];
    
    sharedHeaderInstance->Infolabel.text = erroMessage;
    sharedHeaderInstance->Infolabel.hidden = NO;
}

- (void) disableInfoMessage{
    sharedHeaderInstance->Infolabel.hidden = YES;
}

- (void) shownVideoName:(NSString *)erroMessage{
    sharedHeaderInstance->VideoNamelabel.text = erroMessage;
    sharedHeaderInstance->VideoNamelabel.hidden = NO;
}

- (void) disableVideoNameMessage{
    sharedHeaderInstance->VideoNamelabel.hidden = YES;
}

- (void)dealloc{   
    
    [[NSNotificationCenter defaultCenter] removeAllObjects];
    [super dealloc];
}

@end
