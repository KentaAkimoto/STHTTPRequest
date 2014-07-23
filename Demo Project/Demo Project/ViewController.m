//
//  ViewController.m
//  STHTTPRequestDemo
//
//  Created by Nicolas Seriot on 8/10/12.
//  Copyright (c) 2012 Nicolas Seriot. All rights reserved.
//

/*
 TEST Basic Authentication:
 http://ericasadun.com/Private
 PrivateAccess / tuR7!mZ#eh
 
 TEST Digest Authentication:
 http://jigsaw.w3.org/HTTP/Digest/
 guest / guest
 */

#import "ViewController.h"
#import "STHTTPRequest.h"

@implementation ViewController

- (IBAction)buttonClicked:(id)sender {
    
#if 0
    [_activityIndicator startAnimating];
    
    _fetchButton.enabled = NO;
    _statusLabel.text = @"";
    _headersTextView.text = @"";
    _imageView.image = nil;
    
    __block STHTTPRequest *r = [STHTTPRequest requestWithURLString:@"https://raw.github.com/github/media/master/octocats/octocat.png"];
    __weak STHTTPRequest *wr = r; // so that we can access the request from within the callback blocks but without creating a retain cycle
    
    r.completionBlock = ^(NSDictionary *headers, NSString *body) {
        
        _imageView.image = [UIImage imageWithData:wr.responseData];
        _statusLabel.text = [NSString stringWithFormat:@"HTTP status %@", @(wr.responseStatus)];
        _headersTextView.text = [headers description];
        
        _fetchButton.enabled = YES;
        [_activityIndicator stopAnimating];
    };
    
    r.errorBlock = ^(NSError *error) {
        _statusLabel.text = [error localizedDescription];
        
        NSLog(@"-- isCancellationError: %d", [error st_isCancellationError]);
        
        _fetchButton.enabled = YES;
        [_activityIndicator stopAnimating];
    };
    
    [r startAsynchronous];
    //    [r cancel];
#endif
    
#if 0
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:@"http://jigsaw.w3.org/HTTP/Digest/"];
    [r setUsername:@"guest" password:@"guest_"];
    
    r.addCredentialsToURL = NO;
    
    r.completionBlock = ^(NSDictionary *headers, NSString *body) {
        NSLog(@"-- success: %@", body);
        
    };
    
    r.errorBlock = ^(NSError *error) {
        NSLog(@"-- error: %@", error);
        
        STHTTPRequest *r2 = [STHTTPRequest requestWithURLString:@"http://jigsaw.w3.org/HTTP/Digest/"];
        
        [r2 setUsername:@"guest" password:@"guest"];
        
        r2.addCredentialsToURL = NO;
        
        r2.completionBlock = ^(NSDictionary *headers, NSString *body) {
            NSLog(@"-- success: %@", body);
        };
        
        r2.errorBlock = ^(NSError *error) {
            NSLog(@"-- error: %@", error);
        };
        
        [r2 startAsynchronous];
    };
    
    [r startAsynchronous];
#endif
    
#if 0
    NSString *email = @"sburlot@coriolis.ch";
    NSString *password = @"123456";

    STHTTPRequest *r = [STHTTPRequest requestWithURLString:@"http://mywebsite.com"];
    [r setHeaderWithName:@"Content-Type" value:@"application/json"];
    [r setHeaderWithName:@"Accept" value:@"application/json"];
    NSString *jsonString = [NSString stringWithFormat:@"{\"user\":{\"email\":\"%@\", \"password\":\"%@\"}}", email, password];
    [r setPOSTData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    [r startSynchronousWithError:&error];
    
    if (error) {
        _statusLabel.text = [error localizedDescription];
        [_activityIndicator stopAnimating];
    } else {
        NSLog(@"response: %@", [r responseString]);
        _statusLabel.text = [NSString stringWithFormat:@"HTTP status %d", r.responseStatus];
        _headersTextView.text = [r.responseHeaders description];
        _fetchButton.enabled = YES;
        [_activityIndicator stopAnimating];
    }
#endif

#if 0
    __block STHTTPRequest *up = [STHTTPRequest requestWithURLString:@"http://127.0.0.1:81/"];
    
    //    NSString *s = [@"s&df" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"-- %@", [self urlEncodedString]);
    
    up.POSTDictionary = @{@"asd":@"&&", @"dfg":@"fg&h"};
    
    //    NSData *data = [[[NSData alloc] initWithContentsOfFile:@"/tmp/photo.jpg"] autorelease];
    //
    //    [up setDataToUpload:data parameterName:@"XXX"];
    
    up.uploadProgressBlock = ^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
        NSLog(@"-- %d / %d / %d", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
    
    up.completionBlock = ^(NSDictionary *headers, NSString *body) {
        NSLog(@"-- body: %@", body);
        [_activityIndicator stopAnimating];
    };
    
    up.errorBlock = ^(NSError *error) {
        NSLog(@"-- %@", [error localizedDescription]);
        [_activityIndicator stopAnimating];
    };
    
    [up startAsynchronous];
    
}

#endif
    
#if 1
    __block STHTTPRequest *up = [STHTTPRequest requestWithURLString:@"http://macbookair.local:8185/post_stream.php"];
    up.timeoutSeconds = 60;
    NSLog(@"-- %@", [self urlEncodedString]);
    
    up.POSTDictionary = @{@"asd":@"&&", @"dfg":@"fg&h"};
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"untitled-prezi-lwodydzhqzlz" ofType:@"zip"];
    [up addStreamFileToUpload:file parameterName:nil chunkSize:1024000];
    //[up addRawStreamFileToUpload:file parameterName:@"upfile"];

    up.uploadProgressBlock = ^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
        NSLog(@"-- %d / %d / %d", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
    
    up.completionBlock = ^(NSDictionary *headers, NSString *body) {
        NSLog(@"-- body: %@", body);
        [_activityIndicator stopAnimating];
    };
    
    up.errorBlock = ^(NSError *error) {
        NSLog(@"-- %@", [error localizedDescription]);
        [_activityIndicator stopAnimating];
    };
    
    [up startAsynchronous];

}

- (NSString *)urlEncodedString {
    // https://dev.twitter.com/docs/auth/percent-encoding-parameters
    
    NSString *s = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                      (CFStringRef)@"a&d",
                                                                      NULL,
                                                                      CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                      kCFStringEncodingUTF8));
    return s;
#endif

}

@end
