//
//  JSONParsing.m
//  samplePro1
//
//  Created by bala on 5/20/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "CustomConnection.h"


@interface CustomConnection(){
    NSMutableData *responseData;
    
    NSDictionary* json;
    completion _done;
}

@end


@implementation CustomConnection


- (void) readContentFromUrl:(NSURL*)url completion:(completion) done{
    _done = [done copy];
       if(responseData)
           [responseData release];
    responseData = [[NSMutableData alloc] init];
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   
    // Create url connection and fire request
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //_done(responseData);
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

        NSHTTPURLResponse *r = (NSHTTPURLResponse*) response;
        NSDictionary *headers = [r allHeaderFields];
        NSLog(@"[DO::didReceiveResponse] response headers: %@", headers);
        if (headers){
            if ([headers objectForKey: @"Content-Range"]) {
                NSString *contentRange = [headers objectForKey: @"Content-Range"];
                NSLog(@"Content-Range: %@", contentRange);
                NSRange range = [contentRange rangeOfString: @"/"];
                NSString *totalBytesCount = [contentRange substringFromIndex: range.location + 1];
                NSLog(@"totalBytesCount:%f",[totalBytesCount floatValue]);
            } else if ([headers objectForKey: @"Content-Length"]) {
                NSLog(@"Content-Length: %@", [headers objectForKey: @"Content-Length"]);
                //expectedBytes = [[headers objectForKey: @"Content-Length"] floatValue];
                NSLog(@"totalBytesCount:%f",[[headers objectForKey: @"Content-Length"] floatValue]);
            } 
            
            if ([@"Identity" isEqualToString: [headers objectForKey: @"Transfer-Encoding"]]) {
                //expectedBytes = bytesReceived;
                //operationFinished = YES;
            }
        }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
   // [[HeaderView getHeaderSharedInstance] disableErrorMessage];
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _done(responseData);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //[[HeaderView getHeaderSharedInstance] showError:@"Failed to Load"];
}


@end
