//
//  HTTPClient.m
//  Massage-May
//
//  Created by SHENLL on 25/06/15.
//  Copyright (c) 2015 SHENLL. All rights reserved.
//

#import "HTTPClient.h"
#import "AFNetworking.h"
#import "Constants.h"

@implementation HTTPClient

+ (HTTPClient *)sharedHTTPClient
{
    static HTTPClient *_sharedHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //_sharedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:apiRequestBaseURL]];
        _sharedHTTPClient = [[self alloc] init];
    });
    
    return _sharedHTTPClient;
}


- (void)apiGetRequest:(NSString *)getRequestUrl getRequestParams:(NSMutableDictionary *)getParams{
    
    [Constants printLogKey:@"GET Request url" printValue:getRequestUrl];
    [Constants printLogKey:@"GET Request Params" printValue:getParams];
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
           for (NSHTTPCookie *cookie in cookies) {
               // Here I see the correct rails session cookie
               NSLog(@"cookie: %@", cookie);
           }
    
    [manager GET:getRequestUrl parameters:getParams progress:nil success:^(NSURLSessionTask *task,  id responseObject) {
        [task cancel];
        
        [Constants printLogKey:@"GET  JSON Response" printValue:responseObject];
        if ([self.delegate respondsToSelector:@selector(HTTPClientDidSucceedWithResponse:)]) {
            //[self.delegate HTTPClient:self didSucceedWithResponse:responseObject];
           [self.delegate HTTPClientDidSucceedWithResponse:responseObject];
        }else{
            [Constants printLogKey:@"GET didSucceedWithResponse" printValue:@"Delegate respond error"];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error){
        [Constants printLogKey:@"GET  JSON Error" printValue:error];
        if ([self.delegate respondsToSelector:@selector(HTTPClientDidFailWithError:)]) {
            //[self.delegate HTTPClient:self didFailWithError:error];
            [self.delegate HTTPClientDidFailWithError:error];
        }else{
            [Constants printLogKey:@"GET didFailWithError" printValue:@"Delegate respond error"];
        }
    }];
}

/*
    URL Form encoded method to Post request
 */
- (void)apiPostRequest:(NSString *)postRequestUrl postRequestParams:(NSMutableDictionary *)postParams{
    
    [Constants printLogKey:@"POST Request url" printValue:postRequestUrl];
    [Constants printLogKey:@"POST Request Params" printValue:postParams];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //If uncomment the below line. Then there will be no response. Be careful.
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
           for (NSHTTPCookie *cookie in cookies) {
               // Here I see the correct rails session cookie
               NSLog(@"cookie: %@", cookie);
           }
   //[manager.operationQueue cancelAllOperations];
    
    [manager POST:postRequestUrl parameters:postParams progress:nil success:^(NSURLSessionTask *task,  id responseObject) {
     
         [Constants printLogKey:@"POST  JSON Response" printValue:responseObject];
         if ([self.delegate respondsToSelector:@selector(HTTPClientDidSucceedWithResponse:)]) {
             //[self.delegate HTTPClient:self didSucceedWithResponse:responseObject];
             [self.delegate HTTPClientDidSucceedWithResponse:responseObject];
         }else{
             [Constants printLogKey:@"POST didSucceedWithResponse" printValue:@"Delegate respond error"];
         }
    }  failure:^(NSURLSessionTask *operation, NSError *error){
         [Constants printLogKey:@"POST  JSON Error" printValue:error];
         if ([self.delegate respondsToSelector:@selector(HTTPClientDidFailWithError:)]) {
             //[self.delegate HTTPClient:self didFailWithError:error];
            [self.delegate HTTPClientDidFailWithError:error];
         }else{
             [Constants printLogKey:@"POST  didFailWithError" printValue:@"Delegate respond error"];
         }
     }];
    
}
- (void)apiPostRequestParams:(NSString *)postRequestUrl postRequestParams:(NSMutableArray *)postParams{
    
    [Constants printLogKey:@"POST Request url" printValue:postRequestUrl];
    [Constants printLogKey:@"POST Request Params" printValue:postParams];
    //    NSData *jsonObject = [NSJSONSerialization dataWithJSONObject:postParams options:NSJSONWritingPrettyPrinted error:nil];
    //
    //    NSString *strParams =  [[NSString alloc] initWithData:jsonObject encoding:NSUTF8StringEncoding];
    //    strParams = [strParams stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
    //
    // [Constants printLogKey:@"POST Request strParams" printValue:postParams];
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
           for (NSHTTPCookie *cookie in cookies) {
               // Here I see the correct rails session cookie
               NSLog(@"cookie: %@", cookie);
           }
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
   // manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // [manager.operationQueue cancelAllOperations];
    
     NSString *myString = [Util convertDictionaryToString:postParams];
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
   // manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
   // manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   // [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //    //
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
     manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    // NSLog(@"JSON: %@",manager.responseSerializer);
   // manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    
    
    [manager POST:postRequestUrl parameters:myString success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         NSString *json = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"%@", json);
         [Constants printLogKey:@"POST  JSON Response" printValue:responseObject];
         if ([self.delegate respondsToSelector:@selector(HTTPClientDidSucceedWithResponse:)])
         {
           
            // [self.delegate HTTPClient:self didSucceedWithResponse:responseObject];
              [self.delegate HTTPClientDidSucceedWithResponse:responseObject];
              [Constants printLogKey:@"GET didSucceedWithResponse" printValue:responseObject];
         }
         else
         {
             [Constants printLogKey:@"GET didSucceedWithResponse" printValue:@"Delegate responds error"];
         }
     }failure:^(NSURLSessionDataTask *operation, NSError *error) {
         [Constants printLogKey:@"POST  JSON Error" printValue:error];
         if ([self.delegate respondsToSelector:@selector(HTTPClientDidFailWithError:)]) {
             //[self.delegate HTTPClient:self didFailWithError:error];
             [self.delegate HTTPClientDidFailWithError:error];
         }else{
             [Constants printLogKey:@"POST didFailWithError" printValue:@"Delegate respond error"];
         }
     }];
    
    
}
/*
    Multi- Part encoded method to Post request
 */
- (void)apiMultiPartPostRequest:(NSString *)postMultiPartRequestUrl postMultiPart:(NSMutableDictionary *)postMultiPartRequestParams imagePath:(NSURL *)filePath imagePostKey:(NSString *)postingKey{
    
    [Constants printLogKey:@"POST Request Multi part url" printValue:postMultiPartRequestUrl];
    [Constants printLogKey:@"POST Request Multi part Params" printValue:postMultiPartRequestParams];
    [Constants printLogKey:@"POST Request Image Path" printValue:filePath];
    [Constants printLogKey:@"POST Request Key" printValue:postingKey];
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
           for (NSHTTPCookie *cookie in cookies) {
               // Here I see the correct rails session cookie
               NSLog(@"cookie: %@", cookie);
           }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:postMultiPartRequestUrl parameters:postMultiPartRequestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:postingKey error:nil];
    }  progress:nil  success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"Success: %@", responseObject);
        if ([self.delegate respondsToSelector:@selector(HTTPClientDidSucceedWithResponse:)]) {
            //[self.delegate HTTPClient:self didSucceedWithResponse:responseObject];
            [self.delegate HTTPClientDidSucceedWithResponse:responseObject];
        }else{
            [Constants printLogKey:@"POST Multi part didSucceedWithResponse" printValue:@"Delegate respond error"];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error){
        if ([self.delegate respondsToSelector:@selector(HTTPClientDidFailWithError:)]) {
            //[self.delegate HTTPClient:self didFailWithError:error];
            [self.delegate HTTPClientDidFailWithError:error];
        }else{
            [Constants printLogKey:@"POST Multi part didFailWithError" printValue:@"Delegate respond error"];
        }
    }];
}


@end



