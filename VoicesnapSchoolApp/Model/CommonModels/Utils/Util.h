//
//  Util.h
//  DataBaseDemo
//
//  Created by Shenllon 22/02/14.
//  Copyright (c) 2014 Shenll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "FMResultSet.h"
#import <UIKit/UIKit.h>
#import "SSKeychain.h"

@interface Util : NSObject
{
    UIRefreshControl *refreshControl;
    UIActivityIndicatorView *loadingActivityIndicator;
}
//+(NSString *)convertDictionaryToString:(NSMutableArray *)dict;
+(BOOL)IsNetworkConnected;
+(BOOL)validEmailAddress:(NSString*) emailString;
+(BOOL)ValidatePhonenumber:(NSString *)str_phone;
+(BOOL)ValidateNumbers:(NSString *)str_phone;

+(void)showAlert:(NSString *)strTitle Msg:(NSString *)strMsg;
+(void)copyFile:(NSString *)file;
//+(void)createDatabase:(NSString *)dbName;
+(void)create_folder:(NSString *)foldername;
//+(void)openDatabase;
+(void)removeFile:(NSString *)file;
+(void)configPush;
+(void)createLogfile;
+(BOOL)isDatabaseFileExistsOrNot:(NSString *)file;
+(void)QuitApp;
+(NSString *)createNewUUID;
+(NSString *)str_deviceid;
+(NSString *)convertTime:(NSString *)str_time;
+(NSString *)convertTimeFromAM:(NSString *)str_time;
+(NSString *)convertTime24FormatFromAM:(NSString *)str_time;
+(NSString*)CheckNil:(NSString *)CheckString;
+(NSString *)convertDate:(NSString *)str_date;
+(NSString *)convertDateTime:(NSString *)str_date;
+(NSString*)urlspecialCheck: (NSString *) stringUrl;
+(NSString*)getCurrentTime;
+(NSString*)getCurrentTimeWithSeconds;
+(NSString *)getCurrentDate;
+(NSString *)getCurrentDate1;
+(NSURL *)applicationHiddenDocumentsDirectory:(NSString *)str_folder;
+(UIColor *)colorFromHexString:(NSString *)hexString;
+(NSString *)convertNewFormatDate:(NSString *)str_date;
+(NSString *) convertTimestampToDate:(NSString *)timeStampString;

+(NSString *) convertTimeAMFormatFrom24:(NSString *)str_time;
+(NSString *)convertArrayToString:(NSMutableArray *)arry;
+(NSString *)convertDictionaryToString:(NSMutableDictionary *)dict;
+(NSString *)convertNSMutableArrayToString:(NSMutableArray *)dict;
+(NSString*) convertNSDictionaryToString:(NSMutableDictionary*) dict;

+(NSString *)getCurrentPlusMin;

-(void)startLoading;
-(void)stopLoading;
-(UIActivityIndicatorView *)loadingActivity;

@property (nonatomic,retain) UIView *view;

@property (nonatomic, retain) FMDatabase *masterDatabase;
@property (nonatomic, retain) FMResultSet *resultSet;
@property (nonatomic,retain) NSString *str_deviceIP;
@property (nonatomic,retain) NSString *xPosition;
@property (nonatomic,retain) NSString *yPosition;

+(void)openDatabase;
+(void)createDatabase:(NSString *)dbName;


@end
