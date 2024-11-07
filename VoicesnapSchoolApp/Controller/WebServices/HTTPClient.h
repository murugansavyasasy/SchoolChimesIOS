//
//  HTTPClient.h
//  Massage-May
//
//  Created by SHENLL on 25/06/15.
//  Copyright (c) 2015 SHENLL. All rights reserved.
//

#import "HTTPClient.h"
#import "Util.h"


@class HTTPClient;

@protocol HTTPClientDelegate;

@interface HTTPClient : NSObject

@property (nonatomic, weak) id<HTTPClientDelegate>delegate;

// Initialisation Methods
+ (HTTPClient *)sharedHTTPClient;

- (void)apiGetRequest:(NSString *)getRequestUrl getRequestParams:(NSMutableDictionary *)getParams;
- (void)apiPostRequest:(NSString *)postRequestUrl postRequestParams:(NSMutableDictionary *)postParams;
- (void)apiMultiPartPostRequest:(NSString *)postMultiPartRequestUrl postMultiPart:(NSMutableDictionary *)postMultiPartRequestParams imagePath:(NSURL *)filePath imagePostKey:(NSString *)postingKey;
//- (void)apiPostRequestParams:(NSString *)postRequestUrl postRequestParams:(NSMutableDictionary *)postParams;
- (void)apiPostRequestParams:(NSString *)postRequestUrl postRequestParams:(NSMutableArray *)postParams;



@end

#pragma mark - Protocol Methods

@protocol HTTPClientDelegate <NSObject>

// Delegate Methods
- (void)HTTPClientDidSucceedWithResponse:(id)responseObject;
- (void)HTTPClientDidFailWithError:(NSError *)error;

//- (void)HTTPClient:(HTTPClient *)sharedHTTPClient didSucceedWithResponse:(id)responseObject;
//- (void)HTTPClient:(HTTPClient *)sharedHTTPClient didFailWithError:(NSError *)error;
    //- (void)HTTPClient:(HTTPClient *)sharedHTTPClient didSucceedWithOperations:(NSArray *)operations;
@end
