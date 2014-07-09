//
//  MainMenuViewController.m
//  SampleProject4
//
//  Created by bala on 12/13/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "MainMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "HeaderViewController.h"

@interface MainMenuViewController (){   
    NSArray      *teamContent;
    UIButton     *teamItem[100];
    
    NSMutableArray      *teamButtonArray;
    
    NSArray      *leagueConetent;
    
}

@end

@implementation MainMenuViewController

@synthesize baseScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        teamContent = [[NSArray alloc] init];
        teamContent = [AppData sharedAPPInstance]._teamList;
        
        leagueConetent = [[NSArray alloc] init];
        leagueConetent = [AppData sharedAPPInstance]._mainMenu;
        
        //self.backgroundColor = [UIColor colorWithRed:256.0/256.0 green:256.0/256.0 blue:256.0/256.0 alpha:0.8];
        self.backgroundColor = [UIColor clearColor];
        teamButtonArray = [[NSMutableArray alloc]init];
        //[self loadTeam:1];
        
        baseScrollView = [[UIScrollView alloc] initWithFrame:frame];
        baseScrollView.delegate = self;
        baseScrollView.contentSize = CGSizeMake(frame.size.width*3, frame.size.height);
        baseScrollView.pagingEnabled = YES;
        [self addSubview:baseScrollView];
        
        [self loadTeam:1];
        [self loadTeam:2];
        [self loadTeam:3];
        
        [self ChangeTitle:1];
}
    return self;
}
- (void) loadTeam:(int)leagueID{    
   
    UIView *teamView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width *(leagueID - 1), 0, self.frame.size.width, self.frame.size.height)];   
    
    
    int row = 0;
    int column = 0;
    int i = 0;
    for(NSDictionary *eachTeamItem in teamContent){
       // NSDictionary *eachTeamItem = [teamContent objectAtIndex:i];
        int localLeagueID = [[eachTeamItem objectForKey:@"league_id"] integerValue];
        if(localLeagueID == leagueID){
            if(i != 0 && i%7 == 0){
                row++;
                column = 0;
            }
            teamItem[i] = [UIButton buttonItemWithImage:[UIImage imageNamed:[eachTeamItem objectForKey:@"image"]] target:delegates action:@selector(loadTeamVideo:) position:CGRectMake((50 + (column*140))/ScreenWidthRatio, (80/ScreenHeightRatio)+(row*150/ScreenHeightRatio), 100/ScreenWidthRatio, 100/ScreenHeightRatio) tag:[[eachTeamItem objectForKey:@"id"] integerValue]];
            teamItem[i].layer.cornerRadius = 10;
            teamItem[i].layer.masksToBounds = YES;
            
            teamItem[i].tag = [[eachTeamItem objectForKey:@"id"] integerValue];
            
            UILabel *teamNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(teamItem[i].frame.origin.x, teamItem[i].frame.origin.y + teamItem[i].frame.size.height, 170/ScreenWidthRatio, 20/ScreenHeightRatio)];
            [teamNameLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18/ScreenHeightRatio]];
            NSString *teamNameString = [eachTeamItem objectForKey:@"name"];
            if( [teamNameString length] > 13){
                teamNameString = [teamNameString substringWithRange:NSMakeRange(0, 13)];
            }
            teamNameLbl.backgroundColor = [UIColor clearColor];
            teamNameLbl.text = teamNameString;
            teamNameLbl.textColor = [UIColor whiteColor];
            
            [teamView addSubview:teamNameLbl];
            [teamView addSubview:teamItem[i]];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:teamNameLbl forKey:@"namelabel"];
            [dic setObject:teamItem[i] forKey:@"teambutton"];
            [teamButtonArray addObject:dic];
            
            column++;
            i++;
            
        }
        
    }
    [baseScrollView addSubview:teamView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self ChangeTitle:(scrollView.contentOffset.x/(1024/ScreenWidthRatio)) + 1];
}

- (void) ChangeTitle:(int)index{
    for(NSDictionary *eachMainMenuContent in leagueConetent){
        if([[eachMainMenuContent objectForKey:@"id"] integerValue] == index){
            currentSelecetedLeague = [eachMainMenuContent objectForKey:@"name"];
            [[HeaderViewController getHeaderSharedInstance] shownInfo:currentSelecetedLeague];
        }
    }
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
