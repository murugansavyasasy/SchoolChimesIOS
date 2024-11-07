//
//  Vimeo_uploader.h
//  VoicesnapSchoolApp
//
//  Created by Preethi on 30/05/20.
//  Copyright © 2020 Shenll-Mac-04. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol vimeodelagate;
@interface Vimeo_uploader : NSObject<NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property(weak) id<vimeodelagate> delegate;



+(id)SharedManger;
-(void)pass_data_header:(NSData *)videoData;
- (void)Give_title_to_video:(NSString *)VIdeo_id With_name:(NSString *)name ;


@end

@protocol vimeodelagate <NSObject>
-(void)vimeouploader_succes:(NSString *)link methodName:(NSString *)methodName;
-(void)vimeouploader_progress:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalByte;
-(void)vimeouploader_error:(NSError *)error methodName:(NSString *)methodName;

@end
