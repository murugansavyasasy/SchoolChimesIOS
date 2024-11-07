//
//  Util.m
//  DataBaseDemo
//
//  Created by Shenll on 22/02/14.
//  Copyright (c) 2014 Shenll. All rights reserved.
//

#import "Util.h"
//#import <FMDB/FMDB.h>
#import "Reachability.h"
#import "Constants.h"

@implementation Util
@synthesize str_deviceIP;
@synthesize xPosition;
@synthesize yPosition;


//+(NSString *)convertArrayToString:(NSMutableArray *)arry;

+(NSString *) convertTime:(NSString *)str_time
{
    NSString *str =[NSString stringWithFormat:@"%@",str_time];
    //date formatter for the above string
    NSDateFormatter *dateFormatterWS = [[NSDateFormatter alloc] init];
    [dateFormatterWS setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatterWS setTimeZone:[NSTimeZone systemTimeZone]];
    // [dateFormatterWS setDateFormat:@"dd-MM-yyyy"];
    [dateFormatterWS setDateFormat:@"HH:mm:ss"];
    NSDate *date =[dateFormatterWS dateFromString:str];
    //date formatter that you want
    NSDateFormatter *dateFormatterNew = [[NSDateFormatter alloc] init];
    [dateFormatterNew setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatterNew setTimeZone:[NSTimeZone systemTimeZone]];
    //[dateFormatterNew setDateFormat:@"MM/dd"];
    [dateFormatterNew setDateFormat:@"hh:mm a"];
    //dd-MMM-yyyy
    NSString *stringForNewDate = [dateFormatterNew stringFromDate:date];
    return  stringForNewDate;
}

+(NSString *) convertTimeFromAM:(NSString *)str_time
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    // [df setTimeZone:[NSTimeZone systemTimeZone]];
    [df setDateFormat:@"hh:mm a"];
    NSDate* newDate = [df dateFromString:str_time];
    [df setDateFormat:@"HH:mm"];
    // newDate = [df stringFromDate:newDate];
    //  //nslog(@"[df stringFromDate:newDate] %@",[df stringFromDate:newDate]);
    return  [df stringFromDate:newDate];
}
+(NSString *) convertTimeAMFormatFrom24:(NSString *)str_time
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    // [df setTimeZone:[NSTimeZone systemTimeZone]];
    [df setDateFormat:@"HH:mm"];
    NSDate* newDate = [df dateFromString:str_time];
    [df setDateFormat:@"hh:mm a"];
    // newDate = [df stringFromDate:newDate];
    //  //nslog(@"[df stringFromDate:newDate] %@",[df stringFromDate:newDate]);
    return  [df stringFromDate:newDate];
}

+(NSString *) convertTime24FormatFromAM:(NSString *)str_time
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    // [df setTimeZone:[NSTimeZone systemTimeZone]];
    [df setDateFormat:@"hh:mm a"];
    NSDate* newDate = [df dateFromString:str_time];
    [df setDateFormat:@"HH:mm"];
    // newDate = [df stringFromDate:newDate];
    //  //nslog(@"[df stringFromDate:newDate] %@",[df stringFromDate:newDate]);
    return  [df stringFromDate:newDate];
}
+(NSString *) convertTimestampToDate:(NSString *)timeStampString{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStampString doubleValue]/1000.0];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"dd.MM.yyyy"];
    return [_formatter stringFromDate:date];
}
#pragma mark - Check Nil String

+(NSString*)CheckNil:(NSString *)CheckString
{
    if(CheckString == nil||CheckString==NULL||[CheckString isEqualToString:@" "]||[CheckString isEqualToString:@"(null)"]||[CheckString isEqualToString:@""]||[CheckString length]==0 ||[CheckString isEqualToString:@"<null>"] )
    {
        CheckString=@"";
    }
    else{
        CheckString = CheckString;
    }
    return CheckString;
}

+(UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+(BOOL) isDatabaseFileExistsOrNot:(NSString *)file
{
    BOOL isDBPathAvailable = false;
    NSURL *url = [self applicationHiddenDocumentsDirectory:@"DatabaseFolder"];
    NSString *toPath = [[url relativePath] stringByAppendingPathComponent:file];
    //nslog(@"Verify DB Path :%@",toPath);
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:toPath])
    {
        isDBPathAvailable = true;
    }
    return isDBPathAvailable;
}

+(void) copyFile:(NSString *)file
{
    NSURL *url = [self applicationHiddenDocumentsDirectory:@"DatabaseFolder"];
    NSString *toPath = [[url relativePath] stringByAppendingPathComponent:file];
    //nslog(@"DB Path :%@",toPath);
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:toPath])
    {
        NSString *fromPath=[[NSBundle mainBundle] pathForResource:DB_NAME ofType:@"sqlite"];
        [fileManager copyItemAtPath:fromPath toPath:toPath error:nil];
    }
}

+(void) removeFile:(NSString *)file
{
    NSURL *url = [self applicationHiddenDocumentsDirectory:@"DatabaseFolder"];
    NSString *toPath = [[url relativePath] stringByAppendingPathComponent:file];
    //nslog(@"REmove :%@",toPath);
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:toPath])
    {
        [fileManager removeItemAtPath:toPath error:nil];
    }
}
+(NSString*) convertNSMutableArrayToString:(NSMutableArray*) dict
{
    NSError* error;
    NSDictionary* tempDict = [dict copy]; // get Dictionary from mutable Dictionary
    //giving error as it takes dic, array,etc only. not custom object.
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:tempDict
                                                       options:NSJSONReadingMutableLeaves error:&error];
    NSString* nsJson=  [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    return nsJson;
}
+(NSString*) convertDictionaryToString:(NSMutableArray*) dict
{
    NSError* error;
    NSDictionary* tempDict = [dict copy]; // get Dictionary from mutable Dictionary
    //giving error as it takes dic, array,etc only. not custom object.
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:tempDict
                                                       options:NSJSONReadingMutableLeaves error:&error];
    NSString* nsJson=  [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    return nsJson;
}


+(NSString*) convertNSDictionaryToString:(NSMutableDictionary*) dict
{
    NSError* error;
    NSDictionary* tempDict = [dict copy]; // get Dictionary from mutable Dictionary
    //giving error as it takes dic, array,etc only. not custom object.
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:tempDict
                                                       options:NSJSONReadingMutableLeaves error:&error];
    NSString* nsJson=  [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    return nsJson;
}

+(void)openDatabase{
    Util * util = [[Util alloc]init];
    NSURL *url = [self applicationHiddenDocumentsDirectory:DB_FOLDER];
    NSString *strWritablePath = [[url relativePath] stringByAppendingPathComponent:FULL_DB_NAME];
    util.masterDatabase = [FMDatabase databaseWithPath:strWritablePath];
    if([util.masterDatabase open]){
        [Constants printLogKey:@"Open Database" printValue:@"Success"];
        [Constants printLogKey:@"Open Database path" printValue:strWritablePath];
        
    }
    
}

+(void)createDatabase:(NSString *)dbName{
    NSError *error = nil;
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:DB_NAME ofType:@"sqlite"];
    NSURL *url = [self applicationHiddenDocumentsDirectory:@"DatabaseFolder"];
    NSString *strWritablePath = [[url relativePath] stringByAppendingPathComponent:FULL_DB_NAME];
    if(![[NSFileManager defaultManager] fileExistsAtPath:strWritablePath]){
        [[NSFileManager defaultManager] copyItemAtPath:bundlePath toPath:strWritablePath error:&error];
    }
}


+(void)create_folder:(NSString *)foldername{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:foldername];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (!success){
        [fileManager createDirectoryAtPath:writableDBPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
+(void)QuitApp
{
    exit(0);
}
+ (NSURL *)applicationHiddenDocumentsDirectory:(NSString *)str_folder {
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [libraryPath stringByAppendingPathComponent:str_folder];
    [Constants printLogKey:@"applicationHiddenDocumentsDirectory" printValue:@"folder"];
    NSURL *pathURL = [NSURL fileURLWithPath:path];
    
    BOOL isDirectory = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (isDirectory) {
            return pathURL;
        } else {
            // Handle error. ".data" is a file which should not be there...
            [NSException raise:@"'Private Documents' exists, and is a file" format:@"Path: %@", path];
        }
    }
    NSError *error = nil;
    if (![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
        // Handle error.
        [NSException raise:@"Failed creating directory" format:@"[%@], %@", path, error];
    }
    return pathURL;
}

+(void)showAlert:(NSString *)strTitle Msg:(NSString *)strMsg
{
    UIAlertView *csAlert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [csAlert show];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // exit(0);
    }
}

+(BOOL)IsNetworkConnected
{
    Reachability    *csReachablity      = [Reachability reachabilityForInternetConnection];
    NetworkStatus    csStatus           = [csReachablity currentReachabilityStatus];
    
    return !(csStatus == NotReachable);
}

+(BOOL) validEmailAddress:(NSString*) emailString {
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    if (regExMatches == 0)
        return NO; // email invalid
    else
        return YES; // email valid
}

+(BOOL)ValidatePhonenumber:(NSString *)str_phone{
    NSCharacterSet* numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+()-"];
    for (int i = 0; i < [str_phone length]; ++i)
    {
        unichar c = [str_phone characterAtIndex:i];
        if (![numberCharSet characterIsMember:c])
        {
            return NO;
        }
    }
    return YES;
}

+(BOOL)ValidateNumbers:(NSString *)str_phone{
    NSCharacterSet* numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [str_phone length]; ++i)
    {
        unichar c = [str_phone characterAtIndex:i];
        if (![numberCharSet characterIsMember:c])
        {
            return NO;
        }
    }
    
    return YES;
}

+(NSString*)urlspecialCheck: (NSString *) stringUrl
{
    stringUrl = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"\t" withString:@"%09"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"#" withString:@"%23"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@">" withString:@"%3E"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"\n" withString:@"%0A"];
    return stringUrl;
}

+(NSString *)convertDate:(NSString *)str_date
{
    NSString *str =[NSString stringWithFormat:@"%@",str_date];
    //date formatter for the above string
    NSDateFormatter *dateFormatterWS = [[NSDateFormatter alloc] init];
    [dateFormatterWS setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatterWS setTimeZone:[NSTimeZone systemTimeZone]];
    // [dateFormatterWS setDateFormat:@"dd-MM-yyyy"];
    [dateFormatterWS setDateFormat:@"dd-MM-yyyy"];
    NSDate *date =[dateFormatterWS dateFromString:str];
    //date formatter that you want
    NSDateFormatter *dateFormatterNew = [[NSDateFormatter alloc] init];
    [dateFormatterNew setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatterNew setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatterNew setDateFormat:@"dd/MM/yyyy"];
    // [dateFormatterNew setDateFormat:@"dd MMM yyyy"];
    //dd-MMM-yyyy
    NSString *stringForNewDate = [dateFormatterNew stringFromDate:date];
    return  stringForNewDate;
}


+(NSString *) convertDateTime:(NSString *)str_date
{
    NSString *str =[NSString stringWithFormat:@"%@",str_date];
    //date formatter for the above string
    NSDateFormatter *dateFormatterWS = [[NSDateFormatter alloc] init];
    [dateFormatterWS setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatterWS setTimeZone:[NSTimeZone systemTimeZone]];
    // [dateFormatterWS setDateFormat:@"dd-MM-yyyy"];
    [dateFormatterWS setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date =[dateFormatterWS dateFromString:str];
    //date formatter that you want
    NSDateFormatter *dateFormatterNew = [[NSDateFormatter alloc] init];
    [dateFormatterNew setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatterNew setTimeZone:[NSTimeZone systemTimeZone]];
    //[dateFormatterNew setDateFormat:@"MM/dd"];
    [dateFormatterNew setDateFormat:@"dd MMM yyyy hh:mm a"];
    //dd-MMM-yyyy
    NSString *stringForNewDate = [dateFormatterNew stringFromDate:date];
    return  stringForNewDate;
}

+(NSString *)getCurrentDate{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"dd-MM-yyyy"];
    //nslog(@"Date %@",[DateFormatter stringFromDate:[NSDate date]]);
    return [DateFormatter stringFromDate:[NSDate date]];
}
+(NSString *)getCurrentDate1{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    //nslog(@"Date %@",[DateFormatter stringFromDate:[NSDate date]]);
    return [DateFormatter stringFromDate:[NSDate date]];
}

+(NSString*)getCurrentTime{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"hh:mm a"];
    //nslog(@"Time %@",[DateFormatter stringFromDate:[NSDate date]]);
    return [DateFormatter stringFromDate:[NSDate date]];
    
}


+(NSString*)getCurrentTimeWithSeconds{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"HH:mm:ss"];
    //nslog(@"Time %@",[DateFormatter stringFromDate:[NSDate date]]);
    return [DateFormatter stringFromDate:[NSDate date]];
    
}
+(NSString *)convertNewFormatDate:(NSString *)str_date
{
    NSString *str =[NSString stringWithFormat:@"%@",str_date];
    //date formatter for the above string
    NSDateFormatter *dateFormatterWS = [[NSDateFormatter alloc] init];
    [dateFormatterWS setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatterWS setTimeZone:[NSTimeZone systemTimeZone]];
    // [dateFormatterWS setDateFormat:@"dd-MM-yyyy"];
    [dateFormatterWS setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *date =[dateFormatterWS dateFromString:str];
    //date formatter that you want
    NSDateFormatter *dateFormatterNew = [[NSDateFormatter alloc] init];
    [dateFormatterNew setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatterNew setTimeZone:[NSTimeZone systemTimeZone]];
    // [dateFormatterNew setDateFormat:@"yyyy-MM-dd"];
    [dateFormatterNew setDateFormat:@"dd MMM yyyy"];
    //dd-MMM-yyyy
    NSString *stringForNewDate = [dateFormatterNew stringFromDate:date];
    return  stringForNewDate;
}

+(NSString *)createNewUUID {
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

+(NSString *)str_deviceid{
    NSString *strdevice=@"";
    
    NSString *retrieveuuid = [SSKeychain passwordForService:BUNDLE_ID account:@"user"];
    
    strdevice=retrieveuuid;
    if (retrieveuuid == nil) {
        NSString *uuid  = [self createNewUUID];
        [SSKeychain setPassword:uuid forService:BUNDLE_ID account:@"user"];
        strdevice=uuid;
    }
    return strdevice;
}

+(void)createLogfile{
    NSLog(@"log fileutil");
    //Created logfile
    NSURL *url = [self applicationHiddenDocumentsDirectory:DB_FOLDER];
    NSString *logPath = [[url relativePath] stringByAppendingPathComponent:@"console.log"];
    // logPath = [logPath stringByAppendingPathComponent:@"console.log"];
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
}

+(void)configPush{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    if(IS_OS_8_OR_LATER) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeBadge                                                                            |UIUserNotificationTypeSound                                                                                              |UIUserNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        //register to receive notifications
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    
    //This code will work in iOS 8.0 xcode 6.0 or later
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeNewsstandContentAvailability| UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

-(NSURL *)applicationHiddenDocumentsDirectory:(NSString *)str_folder {
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [libraryPath stringByAppendingPathComponent:str_folder];
    ////nslog(@"path==>%@",path);
    NSURL *pathURL = [NSURL fileURLWithPath:path];
    
    BOOL isDirectory = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (isDirectory) {
            return pathURL;
        } else {
            // Handle error. ".data" is a file which should not be there...
            [NSException raise:@"'Private Documents' exists, and is a file" format:@"Path: %@", path];
        }
    }
    NSError *error = nil;
    if (![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
        // Handle error.
        [NSException raise:@"Failed creating directory" format:@"[%@], %@", path, error];
    }
    return pathURL;
}

#pragma mark - Loading Activity

-(UIActivityIndicatorView *)loadingActivity{
    //Blue : 50 - 158 - 216
    if(loadingActivityIndicator==nil){
        loadingActivityIndicator = [[UIActivityIndicatorView alloc]    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        //loadingActivityIndicator.color = [UIColor grayColor];
        loadingActivityIndicator.color = [UIColor colorWithRed:50/255.0 green:158/255.0 blue:216/255.0 alpha:1.0];
        loadingActivityIndicator.hidesWhenStopped = YES;
        loadingActivityIndicator.frame = CGRectMake(0, 0, 80, 80);
    }
    return loadingActivityIndicator;
}


-(void)startLoading{
    
    float x,y;
    
    x = [xPosition floatValue];
    y = [yPosition floatValue];
    self.loadingActivity.center = CGPointMake(x, y);
    [self.view addSubview:self.loadingActivity];
    [self.loadingActivity startAnimating];
}

-(void)stopLoading{
    
    [self.loadingActivity stopAnimating];
    [refreshControl endRefreshing];
    
    [UIView transitionWithView: self.view
                      duration: 0.2
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
     }
                    completion: nil];
}


+(NSString *)getCurrentPlusMin{
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components=[NSDateComponents new];
    components.minute=10;
    NSDate *newDate=[calendar dateByAddingComponents: components toDate: [NSDate date] options: 0];
    //To get date in  `hour:minute` format.
    NSDateFormatter *dateFormatterHHMM=[NSDateFormatter new];
    [dateFormatterHHMM setDateFormat:@"hh:mm a"];
    NSString *timeString=[dateFormatterHHMM stringFromDate:newDate];
    return timeString;
}

@end
