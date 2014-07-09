//
//  JSONParsing.h
//  samplePro1
//
//  Created by bala on 5/20/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completion)(NSData *data);

@interface CustomConnection : NSObject<NSURLConnectionDelegate,NSURLConnectionDownloadDelegate>{

}
- (void) readContentFromUrl:(NSURL*)url completion:(completion) done;

@end
