//
//  YDownload.m
//  SampleProject4
//
//  Created by bala on 12/20/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "YDownload.h"
#import "CustomConnection.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

BOOL isDownloaded = NO;
@implementation YDownload{
    CustomConnection *connection;    
}
@synthesize videoView;

- (id) init{
    
    
    if(self == NULL)
        self = [super init];
    videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    videoView.backgroundColor = [UIColor redColor];
    
    return self;
    
}

- (void)downloadVideo:(NSURL*)VideoUrl{
 
    connection = [[CustomConnection alloc] init];
    [connection readContentFromUrl:VideoUrl completion:
     ^(NSData *data) {
         NSLog(@"DownLaodCompleted");
         isDownloaded = YES;
         UIWebView *wview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 500,500)];        
         [self StroreFile:data];
         
     }];    

}

- (void)StroreFile:(NSData *)fileData{
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	[fileManager createFileAtPath:[NSString stringWithFormat:@"%@.mp4", [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Barcelona"]] contents:fileData attributes:nil];
	
	NSString *imagePath = [NSString stringWithFormat:@"%@.png", [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Barcelona"]];
	
	AVAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@.mp4", [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Barcelona"]]] options:nil];
	
	AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
	
	Float64 durationSeconds = CMTimeGetSeconds(asset.duration);
	
	CMTime midpoint = CMTimeMakeWithSeconds(durationSeconds / 2.0, 600);
	CMTime actualTime;
    
	CGImageRef preImage = [imageGenerator copyCGImageAtTime:midpoint actualTime:&actualTime error:NULL];
	
	if (preImage != NULL) {
		CGRect rect = CGRectMake(0.0, 0.0, CGImageGetWidth(preImage) * 0.5, CGImageGetHeight(preImage) * 0.5);
		
		UIImage *image = [UIImage imageWithCGImage:preImage];
		
		UIGraphicsBeginImageContext(rect.size);
		
		[image drawInRect:rect];
		
		NSData *data = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext());
		
		[fileManager createFileAtPath:imagePath contents:data attributes:nil];
		
		UIGraphicsEndImageContext();
	}
	
	CGImageRelease(preImage);
	[imageGenerator release];
	[asset release];
    
    NSLog(@"check");
    
    [self playVideo:@"Barcelona"];
}

- (void)playVideo:(NSString*)videoName{
    NSLog(@"check1");
    NSString *contentURL = [NSString stringWithFormat:@"%@.mp4", videoName];
	
	MPMoviePlayerViewController *moviePlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:contentURL]];
	if (moviePlayerViewController) {
		[videoView addSubview:moviePlayerViewController.view];
		[moviePlayerViewController.moviePlayer setMovieSourceType:MPMovieSourceTypeFile];
        
        if ([moviePlayerViewController.moviePlayer respondsToSelector:@selector(setAllowsAirPlay:)]) {
            [moviePlayerViewController.moviePlayer setAllowsAirPlay:YES];
        }
		
		[[NSNotificationCenter defaultCenter] addObserverForName:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayerViewController queue:nil usingBlock:^(NSNotification *notification) {
			[[NSNotificationCenter defaultCenter] removeObserver:self];
            [moviePlayerViewController.view removeFromSuperview];
			[moviePlayerViewController release];
		}];
		
		[moviePlayerViewController.moviePlayer play];
	}
}

@end
