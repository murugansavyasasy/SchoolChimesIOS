//
//  Childrens.m
//  VoicesnapSchoolApp
//
//  Created by Madhavan on 26/06/18.
//  Copyright © 2018 Shenll-Mac-04. All rights reserved.
//

#import "Childrens.h"

@implementation Childrens

+ (NSMutableArray *)ChildArray
{
    static NSMutableArray *ChildArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ChildArray = [[NSMutableArray alloc] initWithObjects:
                      @"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
                      ];
        
        
    });
    return ChildArray;
}

+ (NSDictionary *)getChildDicForDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self ChildArray] count];dbColumnIndex++){
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self ChildArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self ChildArray] objectAtIndex:dbColumnIndex]];
    }
    return childDicForDBTask;
}

+(void)saveXhilsDetail:(NSArray *)responeDictionary
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict = [responeDictionary objectAtIndex:iCoun];
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@",@"ChildID",@"tbl_child",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_child" keyValueDic:[self getChildDicForDBTask:resDict]  whereFieldName:@"ChildID" whereFieldValue:teamId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_child" keyValueDic:[self getChildDicForDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSArray *)GetChildromDB
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    NSString *strQry=@"";
    
    strQry =@"SELECT * FROM tbl_child ORDER BY ChildID DESC";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}

//-(int)getcountDBTeamList{
//
//    NSString* selectQuerySql = [NSString stringWithFormat:@"select count(*) from %@",TABLE_TEAM];
//
//    int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
//
//    return userCount;



//Text Date Details
+ (NSMutableArray *)TextDateListArray
{
    static NSMutableArray *TextDateListArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TextDateListArray = [[NSMutableArray alloc] initWithObjects:
                             @"Date",@"Day",@"UnreadCount",@"ChildID",nil
                             ];
        
        
    });
    return TextDateListArray;
}


+ (NSDictionary *)TextDateListForDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self TextDateListArray] count];dbColumnIndex++){
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self TextDateListArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self TextDateListArray] objectAtIndex:dbColumnIndex]];
    }
    
    return childDicForDBTask;
}
+(void)saveTextDateListDetail:(NSArray *)responeDictionary : (NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"Date"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_textdatelist",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"Date",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_textdatelist" keyValueDic:[self TextDateListForDBTask:resDict]  whereFieldName:@"Date" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_textdatelist" keyValueDic:[self TextDateListForDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetTextDateListFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_textdatelist where %@=%@",@"ChildID",ChildID];
    
    //strQry =@"SELECT * FROM tbl_textdatelist";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}


//+(void)saveNormalVoiceDateWiseDetail:(NSArray *)responeDictionary : (NSString *)strChildID getDateId :(NSString *)strDateID;
//+(NSMutableArray *)GetNormalVoiceDateWiseFromDB:(NSString*)ChildID getDateId:(NSString *)DateID;

//School NormalVoiceDateWise

+ (NSMutableArray *)SchoolNormalVoiceDateWiseArray
{
    static NSMutableArray *SchoolNormalVoiceDateWiseArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolNormalVoiceDateWiseArray = [[NSMutableArray alloc] initWithObjects:
                                          @"AppReadStatus",@"Date",@"Description",@"ID",@"Subject",@"Time",@"URL",@"ChildID",nil
                                          ];
        
        
    });
    return SchoolNormalVoiceDateWiseArray;
}


+ (NSDictionary *)SchoolNormalVoiceDateWiseDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolNormalVoiceDateWiseArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolNormalVoiceDateWiseArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolNormalVoiceDateWiseArray] objectAtIndex:dbColumnIndex]];
      
    }
    
    return childDicForDBTask;
}

+(void)saveNormalVoiceDateWiseDetail:(NSArray *)responeDictionary : (NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"ID"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_NormalVoiceDateWiseDetail",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"ID",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        NSLog(@"%d", userCount);
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_NormalVoiceDateWiseDetail" keyValueDic:[self SchoolNormalVoiceDateWiseDBTask:resDict]  whereFieldName:@"ID" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_NormalVoiceDateWiseDetail" keyValueDic:[self SchoolNormalVoiceDateWiseDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetNormalVoiceDateWiseFromDB:(NSString*)ChildID getDateId:(NSString *)DateID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_NormalVoiceDateWiseDetail where %@=%@ AND %@=%@ ORDER BY ID DESC" ,@"ChildID",ChildID,@"Date",[NSString stringWithFormat:@"'%@'",DateID]];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
   
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}

//School HomeWorkTextDetail

+ (NSMutableArray *)SchoolHomeWorkTextDetailArray
{
    static NSMutableArray *SchoolHomeWorkTextDetailArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolHomeWorkTextDetailArray = [[NSMutableArray alloc] initWithObjects:
                                         @"HomeworkDate",@"ID",@"HomeworkContent",@"HomeworkID",@"HomeworkSubject",@"HomeworkTitle",@"ChildID",nil
                                         ];
        
        
    });
    return SchoolHomeWorkTextDetailArray;
}


+ (NSDictionary *)SchoolHomeWorkTextDetailDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolHomeWorkTextDetailArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolHomeWorkTextDetailArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolHomeWorkTextDetailArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}

+(void)saveHomeWorkTextDetail:(NSArray *)responeDictionary : (NSString *)strChildID getDateId :(NSString *)strDateID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        [resDict setObject:strDateID forKey:@"HomeworkDate"];
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"ID"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ AND %@=%@",@"ChildID",@"tbl_HomeWorkTextDetail",@"ChildID",teamId,@"HomeworkDate",[NSString stringWithFormat:@"'%@'",strDateID],@"ID",DateId];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        NSLog(@"%d", userCount);
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_HomeWorkTextDetail" keyValueDic:[self SchoolHomeWorkTextDetailDBTask:resDict]  whereFieldName:@"ID" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_HomeWorkTextDetail" keyValueDic:[self SchoolHomeWorkTextDetailDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetHomeWorkTextDetailFromDB:(NSString*)ChildID getDateId:(NSString *)DateID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    //select * from tbl_HomeWorkTextDetail where ChildID=1298951 AND HomeworkDate='13-06-2018'
    
    //NSString *strQry = [NSString stringWithFormat:@"select * from tbl_HomeWorkTextDetail where %@=%@ AND %@=%@" ,@"ChildID",ChildID,@"HomeworkDate",[NSString stringWithFormat:@"'%@'",DateID]];
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_HomeWorkTextDetail where %@=%@ AND %@=%@" ,@"ChildID",ChildID,@"HomeworkDate",[NSString stringWithFormat:@"'%@'",DateID]];
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
  
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}
//+(void)saveNormalVoiceListDetail:(NSArray *)responeDictionary : (NSString *)strChildID;
//+(NSMutableArray *)GetNormalVoiceListFromDB : (NSString*)ChildID;
//School NormalVoiceList

+ (NSMutableArray *)SchoolNormalVoiceListArray
{
    static NSMutableArray *SchoolNormalVoiceListArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolNormalVoiceListArray = [[NSMutableArray alloc] initWithObjects:
                                      @"Date",@"Day",@"UnreadCount",@"ChildID",nil
                                      ];
        
        
    });
    return SchoolNormalVoiceListArray;
}


+ (NSDictionary *)SchoolNormalVoiceListDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolNormalVoiceListArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolNormalVoiceListArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolNormalVoiceListArray] objectAtIndex:dbColumnIndex]];
       
    }
    
    return childDicForDBTask;
}
+(void)saveNormalVoiceListDetail:(NSArray *)responeDictionary : (NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"Date"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_NormalVoiceList",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"Date",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        NSLog(@"%d", userCount);
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_NormalVoiceList" keyValueDic:[self SchoolNormalVoiceListDBTask:resDict]  whereFieldName:@"Date" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_NormalVoiceList" keyValueDic:[self SchoolNormalVoiceListDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetNormalVoiceListFromDB : (NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_NormalVoiceList where %@=%@",@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
  
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}


//School HOmeWork

+ (NSMutableArray *)SchoolHomeWorkListArray
{
    static NSMutableArray *SchoolHomeWorkListArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolHomeWorkListArray = [[NSMutableArray alloc] initWithObjects:
                                   @"HomeworkDate",@"HomeworkDay",@"TextCount",@"VoiceCount",@"ChildID",nil
                                   ];
        
        
    });
    return SchoolHomeWorkListArray;
}


+ (NSDictionary *)SchoolHomeWorkListDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolHomeWorkListArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolHomeWorkListArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolHomeWorkListArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveHomeWorkDetail:(NSArray *)responeDictionary : (NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"HomeworkDate"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_HomeWorkList",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"HomeworkDate",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        NSLog(@"%d", userCount);
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_HomeWorkList" keyValueDic:[self SchoolHomeWorkListDBTask:resDict]  whereFieldName:@"HomeworkDate" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_HomeWorkList" keyValueDic:[self SchoolHomeWorkListDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetHomeWorkDetailFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_HomeWorkList where %@=%@",@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
 
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}


//School Event Details
+ (NSMutableArray *)SchoolEventArray
{
    static NSMutableArray *SchoolEventArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolEventArray = [[NSMutableArray alloc] initWithObjects:
                            @"EventContent",@"EventDate",@"EventTime",@"EventTitle",@"ChildID",nil
                            ];
        
        
    });
    return SchoolEventArray;
}


+ (NSDictionary *)SchoolEventForDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolEventArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolEventArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolEventArray] objectAtIndex:dbColumnIndex]];
       
    }
    
    return childDicForDBTask;
}
+(void)saveSchoolEventDetail:(NSArray *)responeDictionary:(NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"EventDate"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_Events",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"EventDate",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        NSLog(@"%d", userCount);
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_Events" keyValueDic:[self SchoolEventForDBTask:resDict]  whereFieldName:@"EventDate" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_Events" keyValueDic:[self SchoolEventForDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetSchoolEventFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_Events where %@=%@",@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
  
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}


//School Notice Board Details
+ (NSMutableArray *)SchoolNoticeBoardArray
{
    static NSMutableArray *SchoolNoticeBoardArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolNoticeBoardArray = [[NSMutableArray alloc] initWithObjects:
                                  @"Date",@"Day",@"NoticeBoardContent",@"NoticeBoardTitle",@"ChildID",@"ID",nil
                                  ];
        
        
    });
    return SchoolNoticeBoardArray;
}


+ (NSDictionary *)SchoolNoticBoardDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolNoticeBoardArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolNoticeBoardArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolNoticeBoardArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveSchoolNoticeBoardDetail:(NSArray *)responeDictionary:(NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"ID"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_NoticeBoard",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"ID",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        NSLog(@"%d", userCount);
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_NoticeBoard" keyValueDic:[self SchoolNoticBoardDBTask:resDict]  whereFieldName:@"Date" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_NoticeBoard" keyValueDic:[self SchoolNoticBoardDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetSchoolNoticeBoardFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_NoticeBoard where %@=%@",@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
   
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}

//School Attendance Report Details
+ (NSMutableArray *)SchoolAttendanceReportArray
{
    static NSMutableArray *SchoolAttendanceReportArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolAttendanceReportArray = [[NSMutableArray alloc] initWithObjects:
                                       @"Date",@"Day",@"ChildID",nil
                                       ];
        
        
    });
    return SchoolAttendanceReportArray;
}


+ (NSDictionary *)SchoolAttendanceReportDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolAttendanceReportArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolAttendanceReportArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolAttendanceReportArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveAttendanceReportDetail:(NSArray *)responeDictionary:(NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"Date"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_AttendanceReport",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"Date",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_AttendanceReport" keyValueDic:[self SchoolAttendanceReportDBTask:resDict]  whereFieldName:@"Date" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_AttendanceReport" keyValueDic:[self SchoolAttendanceReportDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetAttendanceReportFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_AttendanceReport where %@=%@",@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}

//School Exam Test Details
+ (NSMutableArray *)SchoolExamTestArray
{
    static NSMutableArray *SchoolExamTestArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolExamTestArray = [[NSMutableArray alloc] initWithObjects:
                               @"ExamId",@"ExaminationName",@"ExaminationSyllabus",@"ChildID",nil
                               ];
        
        
    });
    return SchoolExamTestArray;
}


+ (NSDictionary *)SchoolExamTestDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolExamTestArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolExamTestArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolExamTestArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveExamTestDetail:(NSArray *)responeDictionary: (NSString *)strChildID;
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        
        NSString * DateId=[resDict objectForKey:@"ExamId"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_ExamTest",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"ExamId",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_ExamTest" keyValueDic:[self SchoolExamTestDBTask:resDict]  whereFieldName:@"ExamId" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_ExamTest" keyValueDic:[self SchoolExamTestDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetExamTestFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_ExamTest where %@=%@ ORDER BY ExamId DESC",@"ChildID",ChildID];
    
     //NSString *strQry = @"SELECT * FROM tbl_ExamTest";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}
//School Exam mark List Details
+ (NSMutableArray *)SchoolExamMarkListArray
{
    static NSMutableArray *SchoolExamMarkListArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolExamMarkListArray = [[NSMutableArray alloc] initWithObjects:
                                   @"name",@"value",@"ChildID",nil
                                   ];
        
        
    });
    return SchoolExamMarkListArray;
}


+ (NSDictionary *)SchoolExamMarkListDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolExamMarkListArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolExamMarkListArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolExamMarkListArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveExamMarkListDetail:(NSArray *)responeDictionary:(NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"value"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_ExamMarkList",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"value",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_ExamMarkList" keyValueDic:[self SchoolExamMarkListDBTask:resDict]  whereFieldName:@"value" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_ExamMarkList" keyValueDic:[self SchoolExamMarkListDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetExamMarkListFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_ExamMarkList where %@=%@",@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}
//School Library Details
+ (NSMutableArray *)SchoolLibraryArray
{
    static NSMutableArray *SchoolLibraryArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolLibraryArray = [[NSMutableArray alloc] initWithObjects:
                              @"BookName",@"DueDate",@"IssuedOn",@"RefBookID",@"ChildID",nil
                              ];
        
        
    });
    return SchoolLibraryArray;
}


+ (NSDictionary *)SchoolLibraryDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolLibraryArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolLibraryArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolLibraryArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveLibraryDetail:(NSArray *)responeDictionary :(NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"RefBookID"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_Library",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"RefBookID",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_Library" keyValueDic:[self SchoolLibraryDBTask:resDict]  whereFieldName:@"RefBookID" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_Library" keyValueDic:[self SchoolLibraryDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetLibraryFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_Library where %@=%@",@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}

//School Past Fee Details
+ (NSMutableArray *)SchoolPastFeeArray
{
    static NSMutableArray *SchoolPastFeeArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolPastFeeArray = [[NSMutableArray alloc] initWithObjects:
                              @"CreatedOn",@"InvoiceId",@"IsRejected",@"LateFee",@"PaymentType",@"TotalPaid",@"ChildID",nil
                              ];
        
        
    });
    return SchoolPastFeeArray;
}


+ (NSDictionary *)SchoolPastFeeDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolPastFeeArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolPastFeeArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolPastFeeArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)savePastFeeDetail:(NSArray *)responeDictionary:(NSString *)strChildID;
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"InvoiceId"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_FeePast",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"InvoiceId",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_FeePast" keyValueDic:[self SchoolPastFeeDBTask:resDict]  whereFieldName:@"InvoiceId" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_FeePast" keyValueDic:[self SchoolPastFeeDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetPastFeeFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_FeePast where %@=%@",@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}


//School Past Invoice Details
+ (NSMutableArray *)SchoolFeeInvocieArray
{
    static NSMutableArray *SchoolFeeInvocieArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolFeeInvocieArray = [[NSMutableArray alloc] initWithObjects:
                                 @"FeeGroupId",@"FeeName",@"FeeTerm",@"InvoiceId",@"PaidAmount",@"ChildID",nil
                                 ];
        
        
    });
    return SchoolFeeInvocieArray;
}


+ (NSDictionary *)SchoolFeeInvocieDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolFeeInvocieArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolFeeInvocieArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolFeeInvocieArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveFeeInvoiceDetail:(NSArray *)responeDictionary : (NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        [resDict setObject:strChildID forKey:@"ChildID"];
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"FeeGroupId"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_FeeInvoice",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"FeeGroupId",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_FeeInvoice" keyValueDic:[self SchoolFeeInvocieDBTask:resDict]  whereFieldName:@"FeeGroupId" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_FeeInvoice" keyValueDic:[self SchoolFeeInvocieDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetFeeInvoiceFromDB:(NSString*)ChildID getinvoiceId:(NSString *)InvoiceID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_FeeInvoice where %@=%@ AND %@=%@" ,@"ChildID",ChildID,@"InvoiceId",InvoiceID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}

//School Monthly Fee Details
+ (NSMutableArray *)SchoolMonthlyFeeArray
{
    static NSMutableArray *SchoolMonthlyFeeArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolMonthlyFeeArray = [[NSMutableArray alloc] initWithObjects:
                                 @"FeeGroupId",@"PendingAmount",@"FeeName",@"TotalMonthly",@"Monthly",@"StartMonthName",@"EndMonthName",@"ChildID",nil
                                 ];
        
        
    });
    return SchoolMonthlyFeeArray;
}


+ (NSDictionary *)SchoolMonthlyFeeDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolMonthlyFeeArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolMonthlyFeeArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolMonthlyFeeArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveMonthlyFeeDetail:(NSArray *)responeDictionary:(NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"FeeGroupId"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_FeeMonthly",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"FeeGroupId",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_FeeMonthly" keyValueDic:[self SchoolMonthlyFeeDBTask:resDict]  whereFieldName:@"FeeGroupId" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_FeeMonthly" keyValueDic:[self SchoolMonthlyFeeDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetMonthlyFeeFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_FeeMonthly where %@=%@" ,@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}

//School Upcoming Fee Details
+ (NSMutableArray *)SchoolUpcomingFeeArray
{
    static NSMutableArray *SchoolUpcomingFeeArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolUpcomingFeeArray = [[NSMutableArray alloc] initWithObjects:
                                  @"ChildID",@"AcademicId",@"FeeGroupId",@"FeeName",@"PaidAmount",@"StandardFeeID",@"Term1_From",@"Term1_To",@"Term2_From",@"Term2_To",@"Term3_From",@"Term3_To",@"Term4_From",@"Term4_To",@"Term_I",@"Term_II",@"Term_III",@"Term_IV",@"Total",@"Yearly",nil
                                  ];
        
        
    });
    return SchoolUpcomingFeeArray;
}


+ (NSDictionary *)SchoolUpcomingFeeDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolUpcomingFeeArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolUpcomingFeeArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolUpcomingFeeArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveUpcomingFeeDetail:(NSArray *)responeDictionary : (NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        [resDict setObject:strChildID forKey:@"ChildID"];
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"StandardFeeID"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_FeeUpcoming",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"StandardFeeID",DateId];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_FeeUpcoming" keyValueDic:[self SchoolUpcomingFeeDBTask:resDict]  whereFieldName:@"StandardFeeID" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_FeeUpcoming" keyValueDic:[self SchoolUpcomingFeeDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetUpcomingFeeFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_FeeUpcoming where %@=%@" ,@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}
//School StudentMarlk Details
+ (NSMutableArray *)SchoolStudentmarkDetailArray
{
    static NSMutableArray *SchoolStudentmarkDetailArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolStudentmarkDetailArray = [[NSMutableArray alloc] initWithObjects:
                                        @"Marks",@"ID",@"Subject",@"ExamId",@"ChildID",nil
                                        ];
        
        
    });
    return SchoolStudentmarkDetailArray;
}


+ (NSDictionary *)SchoolStudentMarkDetailDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolStudentmarkDetailArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolStudentmarkDetailArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolStudentmarkDetailArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveStudentExamMarkDetail:(NSArray *)responeDictionary:(NSString *)strChildID:(NSString *)strExamID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        [resDict setObject:strExamID forKey:@"ExamId"];
        
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId = [resDict objectForKey:@"ID"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_ExamMarkDetail",@"ChildID",teamId,@"ID",DateId];
        
        //  NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@",@"ChildID",@"tbl_ExamMarkDetail",@"ID",DateId];
        
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        NSLog(@"%d", userCount);
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_ExamMarkDetail" keyValueDic:[self SchoolStudentMarkDetailDBTask:resDict]  whereFieldName:@"ID" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_ExamMarkDetail" keyValueDic:[self SchoolStudentMarkDetailDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetStudentExamMarkFromDB:(NSString*)ChildID getExamId :(NSString *)strexamID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_ExamMarkDetail where %@=%@ AND %@=%@",@"ChildID",ChildID,@"ExamId",strexamID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}


//School DateWise Text Details
+ (NSMutableArray *)SchoolDateWiseTextArray
{
    static NSMutableArray *SchoolDateWiseTextArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolDateWiseTextArray = [[NSMutableArray alloc] initWithObjects:
                                   @"AppReadStatus",@"Date",@"Description",@"ID",@"Subject",@"Time",@"URL",@"ChildID",nil
                                   ];
        
        
    });
    return SchoolDateWiseTextArray;
}


+ (NSDictionary *)SchoolDateWiseTextDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolDateWiseTextArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolDateWiseTextArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolDateWiseTextArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveDateWiseTextDetail:(NSArray *)responeDictionary : (NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"ID"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_TextDateWiseMsg",@"ChildID",[NSString stringWithFormat:@"'%@'",teamId],@"ID",[NSString stringWithFormat:@"'%@'",DateId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_TextDateWiseMsg" keyValueDic:[self SchoolDateWiseTextDBTask:resDict]  whereFieldName:@"ID" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_TextDateWiseMsg" keyValueDic:[self SchoolDateWiseTextDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetDateWiseTextFromDB:(NSString*)ChildID getDateId:(NSString *)DateID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_TextDateWiseMsg where %@=%@ AND %@=%@ ORDER BY ID DESC" ,@"ChildID",ChildID,@"Date",[NSString stringWithFormat:@"'%@'",DateID]];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}

+ (NSMutableArray *)VoiceArray
{
    static NSMutableArray *ChildArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ChildArray = [[NSMutableArray alloc] initWithObjects:
                      @"MessageID",@"Description",@"AppReadStatus",@"Date",@"Subject",@"Time",@"URL",@"ChildID",nil
                      ];
        
        
    });
    return ChildArray;
}

+ (NSDictionary *)getVoiceDicForDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self VoiceArray] count];dbColumnIndex++){
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self VoiceArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self VoiceArray] objectAtIndex:dbColumnIndex]];
    }
    return childDicForDBTask;
}

+(void)saveVoiceDetail:(NSArray *)responeDictionary:(NSString *)strChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        
        
        NSString * teamId=[resDict objectForKey:@"MessageID"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@",@"MessageID",@"tbl_voice",@"MessageID",[NSString stringWithFormat:@"'%@'",teamId]];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_voice" keyValueDic:[self getVoiceDicForDBTask:resDict]  whereFieldName:@"MessageID" whereFieldValue:teamId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_voice" keyValueDic:[self getVoiceDicForDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetVoiceFromDB:(NSString*)ChildID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_voice where %@=%@ ORDER BY MessageID DESC",@"ChildID",ChildID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}

//School ExamTestSection Details
+ (NSMutableArray *)ExamTestSectionDetailArray
{
    static NSMutableArray *ExamTestSectionDetailArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExamTestSectionDetailArray = [[NSMutableArray alloc] initWithObjects:
                                        @"ID",@"ExamId",@"ExamDate",@"ExamSession",@"Subname",@"maxMark",@"ChildID",nil
                                        ];
        
        
    });
    return ExamTestSectionDetailArray;
}


+ (NSDictionary *)ExamTestSectionDetailArrayDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self ExamTestSectionDetailArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self ExamTestSectionDetailArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self ExamTestSectionDetailArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}
+(void)saveExamTestSectionDetail:(NSArray *)responeDictionary:(NSString *)strChildID:(NSString *)strExamID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
       
        [resDict setObject:strChildID forKey:@"ChildID"];
        [resDict setObject:strExamID forKey:@"ExamId"];
        NSString *strcount =[NSString stringWithFormat:@"%d",iCoun];
         [resDict setObject:strcount forKey:@"ID"];
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId = [resDict objectForKey:@"ID"];
        NSLog(@"%@", DateId);
        NSString * examId = [resDict objectForKey:@"ExamId"];
        NSLog(@"%@", examId);
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ AND %@=%@ ",@"ChildID",@"tbl_ExamTest_SectionDetail",@"ChildID",teamId,@"ID",DateId,@"ExamId",examId];
        
       //NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ ",@"ChildID",@"tbl_ExamTest_SectionDetail",@"ChildID",teamId,@"ID",DateId];
        
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        NSLog(@"%d", userCount);
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_ExamTest_SectionDetail" keyValueDic:[self ExamTestSectionDetailArrayDBTask:resDict]  whereFieldName:@"ID" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_ExamTest_SectionDetail" keyValueDic:[self ExamTestSectionDetailArrayDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetExamTestSectionDetailFromDB:(NSString*)ChildID getExamId :(NSString *)strexamID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    
    // NSString *strQry = [NSString stringWithFormat:@"select * from tbl_ExamTest_SectionDetail"];
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_ExamTest_SectionDetail where %@=%@ AND %@=%@",@"ChildID",ChildID,@"ExamId",strexamID];
    
    // strQry = @"SELECT * FROM tbl_Events where ChildID=%@ ";
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
    
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}


+(void)deleteTables{
    
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    [modelManagerInstance deleteData:@"delete from tbl_HomeworkVoiceDetail"];
    [modelManagerInstance deleteData:@"delete from tbl_ExamTest_SectionDetail"];
    [modelManagerInstance deleteData:@"delete from tbl_FeeMonthly"];
    
    [modelManagerInstance deleteData:@"delete from tbl_FeeUpcoming"];
    
    [modelManagerInstance deleteData:@"delete from tbl_AttendanceReport"];
    
    [modelManagerInstance deleteData:@"delete from tbl_Events"];
    
    [modelManagerInstance deleteData:@"delete from tbl_ExamMarkDetail"];
    
    [modelManagerInstance deleteData:@"delete from tbl_ExamMarkList"];
    
    [modelManagerInstance deleteData:@"delete from tbl_ExamTest"];
    
    [modelManagerInstance deleteData:@"delete from tbl_FeeInvoice"];
    
    [modelManagerInstance deleteData:@"delete from tbl_FeePast"];
    
    [modelManagerInstance deleteData:@"delete from tbl_HomeWorkList"];
    
    [modelManagerInstance deleteData:@"delete from tbl_HomeWorkTextDetail"];
    
    [modelManagerInstance deleteData:@"delete from tbl_Library"];
    
    [modelManagerInstance deleteData:@"delete from tbl_NormalVoiceDateWiseDetail"];
    
    [modelManagerInstance deleteData:@"delete from tbl_NormalVoiceList"];
    
    [modelManagerInstance deleteData:@"delete from tbl_NoticeBoard"];
    
    [modelManagerInstance deleteData:@"delete from tbl_TextDateWiseMsg"];
    
    [modelManagerInstance deleteData:@"delete from tbl_child"];
    
    [modelManagerInstance deleteData:@"delete from tbl_textdatelist"];
    
    [modelManagerInstance deleteData:@"delete from tbl_voice"];
    
    
}
//School HomeWorkVoiceDetail

+ (NSMutableArray *)SchoolHomeWorkVoiceDetailArray
{
    static NSMutableArray *SchoolHomeWorkVoiceDetailArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SchoolHomeWorkVoiceDetailArray = [[NSMutableArray alloc] initWithObjects:
                                         @"HomeworkDate",@"ID",@"HomeworkContent",@"HomeworkID",@"HomeworkSubject",@"HomeworkTitle",@"ChildID",nil
                                         ];
        
        
    });
    return SchoolHomeWorkVoiceDetailArray;
}


+ (NSDictionary *)SchoolHomeWorkVoiceDetailDBTask:(NSDictionary*)dicFromApiResponse
{
    NSMutableDictionary *childDicForDBTask = [NSMutableDictionary new];
    for(int dbColumnIndex=0; dbColumnIndex<[[self SchoolHomeWorkVoiceDetailArray] count];dbColumnIndex++){
        
        
        NSString *identifier = [dicFromApiResponse objectForKey:[[self SchoolHomeWorkVoiceDetailArray] objectAtIndex:dbColumnIndex]];
        
        [childDicForDBTask setObject:identifier  forKey:[[self SchoolHomeWorkVoiceDetailArray] objectAtIndex:dbColumnIndex]];
        
    }
    
    return childDicForDBTask;
}

+(void)saveHomeWorkVoiceDetail:(NSArray *)responeDictionary : (NSString *)strChildID getDateId :(NSString *)strDateID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    //@"ChildID",@"ChildName",@"ChildName",@"RollNumber",@"SchoolCity",@"SchoolID",@"SchoolLogoUrl",@"SchoolName",@"SectionName",@"StandardName",@"isBooksEnabled",nil
    
    
    for(int iCoun = 0; iCoun<responeDictionary.count;iCoun++)
    {
        
        NSDictionary *resDict1 = [responeDictionary objectAtIndex:iCoun];
        
        NSMutableDictionary *resDict= [NSMutableDictionary dictionaryWithDictionary:resDict1];
        
        [resDict setObject:strChildID forKey:@"ChildID"];
        [resDict setObject:strDateID forKey:@"HomeworkDate"];
        
        NSString * teamId=[resDict objectForKey:@"ChildID"];
        NSString * DateId=[resDict objectForKey:@"ID"];
        NSString* selectQuerySql = [NSString stringWithFormat:@"select count(%@) from %@ where %@=%@ AND %@=%@ AND %@=%@",@"ChildID",@"tbl_HomeworkVoiceDetail",@"ChildID",teamId,@"HomeworkDate",[NSString stringWithFormat:@"'%@'",strDateID],@"ID",DateId];
        
        int userCount=[modelManagerInstance getTableRecordCount:selectQuerySql];
        NSLog(@"%d", userCount);
        if(userCount>0)
        {
            [modelManagerInstance updateDataInDb:@"tbl_HomeworkVoiceDetail" keyValueDic:[self SchoolHomeWorkVoiceDetailDBTask:resDict]  whereFieldName:@"ID" whereFieldValue:DateId];
        }
        else
        {
            [modelManagerInstance insertDataInDb:@"tbl_HomeworkVoiceDetail" keyValueDic:[self SchoolHomeWorkVoiceDetailDBTask:resDict]];
        }
    }
    //[refreshControl endRefreshing];x
    
}

+(NSMutableArray *)GetHomeWorkVoiceDetailFromDB:(NSString*)ChildID getDateId:(NSString *)DateID
{
    ModelManager *modelManagerInstance = [ModelManager getInstance];
    
    
    NSMutableArray  *arrChild = [[NSMutableArray alloc] init];
    //select * from tbl_HomeWorkTextDetail where ChildID=1298951 AND HomeworkDate='13-06-2018'
    
    //NSString *strQry = [NSString stringWithFormat:@"select * from tbl_HomeWorkTextDetail where %@=%@ AND %@=%@" ,@"ChildID",ChildID,@"HomeworkDate",[NSString stringWithFormat:@"'%@'",DateID]];
    
    NSString *strQry = [NSString stringWithFormat:@"select * from tbl_HomeworkVoiceDetail where %@=%@ AND %@=%@" ,@"ChildID",ChildID,@"HomeworkDate",[NSString stringWithFormat:@"'%@'",DateID]];
    
    NSMutableArray  *arrSelectedTeams = [modelManagerInstance selectData:strQry];
    
    [arrSelectedTeams enumerateObjectsUsingBlock:^(id teamItem,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
        
        
        
    }];
    
  
    
    arrChild = arrSelectedTeams;
    
    
    return arrChild;
    
}
@end
