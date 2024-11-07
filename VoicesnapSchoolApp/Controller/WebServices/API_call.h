
//
//  API_call.h
//  BrianVickers
//
//  Created by Rifluxyss on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "Constants.h"

@protocol Apidelegate

//-(void)responestring:(NSData *)csData :(NSString *)pagename;
//-(void)responestring:(NSMutableDictionary *)csData :(NSString *)pagename;

-(void)responestring:(NSMutableArray *)csData :(NSString *)pagename;

-(void)failedresponse:(NSError *)pagename;


@optional
-(void)responeDictstring:(NSDictionary *)csData :(NSString *)pagename;


-(void)currentprogress:(float)value;


@end

@interface API_call : NSObject {
	id<Apidelegate> delegate;
	NSMutableData *receivedData;
	NSString *strapiname;
    float total_length;
    NSURLConnection *conn;

}

@property(nonatomic,retain)NSMutableData *receivedData;
@property(nonatomic,retain)id<Apidelegate> delegate;
@property(nonatomic,retain)NSString *strapiname;

-(void)cancelconnection;
-(void) GETFunction:(NSString *)feedURLString :(NSString *)apiname ;
- (void) pass_data_header:(NSData *)videoData : (NSString *)title :(NSString *)discription :(NSString *)Aurtorizartion;
-(void) PutViemoApiCall:(NSString *)feedURLString :(NSString *)postParams :(NSString *)apiname;
-(void) NSURLConnectionFunction:(NSString *)feedURLString :(NSString *)postParams :(NSString *)apiname;
-(void) NSURLVimeoFunction:(NSString *)feedURLString :(NSString *)postParams :(NSString *)apiname;
//-(void)Upload_connection:(NSString *)feedURLString :(NSString *)apiname:(NSString *)str_productid;

//-(void)Upload_connection1:(NSString *)feedURLString :(NSString *)apiname:(NSString *)str_productid;

//-(void)Upload_Edit_connection:(NSString *)feedURLString :(NSString *)apiname:(NSString *)str_productid;

//-(void)Upload_connection2:(NSString *)feedURLString :(NSString *)apiname;

//-(void)Upload_ProductImg:(NSString *)feedURLString :(NSString *)apiname:(NSString *)str_productid;

//-(void)UploadCrashLog:(NSString *)feedURLString :(NSString *)apiname;

-(void)postAPIformissing:(NSDictionary *) dicMiss :(NSString *)apiname;

-(void)UploadImagetoServer:(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData;
-(void)callPassParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData;
-(void)callPassImageParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData;
-(void)callPassVoiceParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)VocieData;
-(void)callVoiceParams:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)VocieData;
-(void)callPassVoiceStaff:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)VocieData;
-(void)callPassParmsImage:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData;
-(void)CommoncallPassParmsImage:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData;
-(void)callPassPDFParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData;
-(void)callPassVideoParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)videoData;
-(void)callPassVimeoVideoParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)videoData;
-(void)callPassUploadVimeoVideoParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)videoData;
-(void)callPassAssignmentParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData:(NSString *)extension;
//parent app
-(void)callPassParms:(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData;

-(void)callRazorPayment:(NSString *)feedURLString :(NSString *)postParams :(NSString *)token :(NSString *)apiname;
-(void)callSendTextParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname;
@end
