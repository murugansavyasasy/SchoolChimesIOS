//
//  Childrens.h
//  VoicesnapSchoolApp
//
//  Created by Madhavan on 26/06/18.
//  Copyright © 2018 Shenll-Mac-04. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelManager.h"

@interface Childrens : NSObject

+(void)deleteTables;
+(void)saveXhilsDetail:(NSArray *)responeDictionary;
+(NSArray *)GetChildromDB;
+(void)saveTextDateListDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetTextDateListFromDB:(NSString *)ChildID;
+(void)saveSchoolEventDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetSchoolEventFromDB:(NSString *)ChildID;
+(void)saveSchoolNoticeBoardDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetSchoolNoticeBoardFromDB:(NSString *)ChildID;
+(void)saveAttendanceReportDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetAttendanceReportFromDB:(NSString *)ChildID;

+(void)saveExamTestDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetExamTestFromDB:(NSString *)ChildID;

+(void)saveExamTestSectionDetail:(NSArray *)responeDictionary : (NSString *)strChildID : (NSString *)strExamID;
+(NSMutableArray *)GetExamTestSectionDetailFromDB:(NSString *)ChildID getExamId :(NSString *)strexamID;


+(void)saveExamMarkListDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetExamMarkListFromDB:(NSString *)ChildID;

+(void)saveLibraryDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetLibraryFromDB:(NSString *)ChildID;

+(void)saveStudentExamMarkDetail:(NSArray *)responeDictionary : (NSString *)strChildID : (NSString *)strExamID;
+(NSMutableArray *)GetStudentExamMarkFromDB:(NSString *)ChildID getExamId :(NSString *)strexamID;

+(void)savePastFeeDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetPastFeeFromDB:(NSString *)ChildID;

+(void)saveUpcomingFeeDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetUpcomingFeeFromDB:(NSString *)ChildID;

+(void)saveFeeInvoiceDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetFeeInvoiceFromDB:(NSString*)ChildID getinvoiceId:(NSString *)InvoiceID;

+(void)saveMonthlyFeeDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetMonthlyFeeFromDB:(NSString*)ChildID;

+(void)saveDateWiseTextDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetDateWiseTextFromDB:(NSString*)ChildID getDateId:(NSString *)DateID;


+(void)saveVoiceDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetVoiceFromDB:(NSString*)ChildID;

+(void)saveHomeWorkDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetHomeWorkDetailFromDB : (NSString*)ChildID;

+(void)saveHomeWorkTextDetail:(NSArray *)responeDictionary : (NSString *)strChildID getDateId :(NSString *)strDateID;
+(NSMutableArray *)GetHomeWorkTextDetailFromDB:(NSString*)ChildID getDateId:(NSString *)DateID;


+(void)saveHomeWorkVoiceDetail:(NSArray *)responeDictionary : (NSString *)strChildID getDateId :(NSString *)strDateID;
+(NSMutableArray *)GetHomeWorkVoiceDetailFromDB:(NSString*)ChildID getDateId:(NSString *)DateID;


+(void)saveNormalVoiceListDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetNormalVoiceListFromDB : (NSString*)ChildID;

+(void)saveNormalVoiceDateWiseDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
+(NSMutableArray *)GetNormalVoiceDateWiseFromDB:(NSString*)ChildID getDateId:(NSString *)DateID;


@end
