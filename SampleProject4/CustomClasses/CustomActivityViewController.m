//
//  CustomActivityViewController.m
//  samplePro1
//
//  Created by bala on 5/20/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "CustomActivityViewController.h"
#import "Constant.h"

@interface CustomActivityViewController (){
    CGSize screenSize;
}
@end

@implementation CustomActivityViewController

@synthesize activityIndicator;


- (void)viewDidLoad
{
    screenSize = [UIScreen mainScreen].bounds.size;
     [super viewDidLoad];
    
    UIImage *baseImage =[UIImage imageNamed:@"rounded-rectangle.png"];
        
    
    self.view.frame = CGRectMake(((1024-baseImage.size.width*2)/ScreenWidthRatio)/2,((768 - baseImage.size.height*2 - 90)/ScreenHeightRatio)/2, baseImage.size.width/ScreenWidthRatio,baseImage.size.height/ScreenHeightRatio);
    
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);    
    baseImageView  = [[UIImageView alloc] initWithImage:baseImage];
    baseImageView.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, baseImageView.frame.size.width/ScreenWidthRatio, baseImageView.frame.size.height/ScreenHeightRatio);
    
    [baseImageView addSubview:activityIndicator];
    
    loadingText = [[UILabel alloc] initWithFrame:CGRectMake(0, (baseImage.size.height-40)/ScreenHeightRatio, baseImage.size.width/ScreenWidthRatio, 40/ScreenWidthRatio)];
    loadingText.text = @"Loading";
    loadingText.textColor = [UIColor whiteColor];
    loadingText.backgroundColor = [UIColor clearColor];
    loadingText.textAlignment = NSTextAlignmentCenter;
    loadingText.font = [UIFont fontWithName:@"Helvetica" size:20/ScreenHeightRatio];
   // [baseImageView addSubview:loadingText];
    
    [self.view addSubview:baseImageView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) startAnimating{
    self.view.hidden = NO;
     [activityIndicator startAnimating];
}

- (void)stopAnimating{   
    self.view.hidden = YES;
    [activityIndicator stopAnimating];
}


@end
