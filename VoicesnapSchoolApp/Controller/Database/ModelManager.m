//
//  ModelManager.m
//  DataBaseDemo
//
//  Created by TheAppGuruz-New-6 on 22/02/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

#import "ModelManager.h"


@implementation ModelManager


static ModelManager *instance=nil;

@synthesize database=_database;

+(ModelManager *) getInstance
{
    
    if(!instance)
    {
        instance=[[ModelManager alloc]init];
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [libraryPath stringByAppendingPathComponent:DB_FOLDER];
        NSURL *pathURL = [NSURL fileURLWithPath:path];
        NSString *dbPath = [[pathURL relativePath] stringByAppendingPathComponent:FULL_DB_NAME];
        instance.database=[FMDatabase databaseWithPath:dbPath];
    }
    return instance;
}

-(void)insertData:(NSString *)strInsertQuery
{
    [Constants printLogKey:@"Insert Query" printValue:strInsertQuery];
    [instance.database open];
    //!WARNING, Please use/uncomment the below line only if you need to encrypt your database.
    // [instance.database setKey:@"1234"];
    BOOL isInserted=[instance.database executeUpdate:strInsertQuery];
    [instance.database close];
    
    if(isInserted)
        [Constants printLogKey:@"Insert" printValue:@"Success"];
    else
        [Constants printLogKey:@"Insert" printValue:@"Error"];
}

-(void)insertDataWithParameter:(NSString *)strInsertQueryWithParameter arrayParams:(NSDictionary *)insertParams
{
   [Constants printLogKey:@"InsertQueryParamQuery" printValue:strInsertQueryWithParameter];
    [instance.database open];
    //!WARNING, Please use/uncomment the below line only if you need to encrypt your database.
    // [instance.database setKey:@"1234"];
    BOOL isInserted=[instance.database executeUpdate:strInsertQueryWithParameter withParameterDictionary:insertParams];
    [instance.database close];
    
    if(isInserted)
       [Constants printLogKey:@"Insert Param method" printValue:@"Success"];
    else
        [Constants printLogKey:@"Insert Param method" printValue:@"Error"];
}

-(void)updateData:(NSString *)strUpdateQuery
{
    [Constants printLogKey:@"Update Query" printValue:strUpdateQuery];
    [instance.database open];
    BOOL isUpdated=[instance.database executeUpdate:strUpdateQuery];
    [instance.database close];
    
    if(isUpdated)
       [Constants printLogKey:@"Update" printValue:@"Success"];
    else
       [Constants printLogKey:@"Update" printValue:@"Error"];
}

-(void)deleteData:(NSString *)strDeleteQuery
{
    [Constants printLogKey:@"Delete Query" printValue:strDeleteQuery];
    [instance.database open];
    BOOL isDeleted=[instance.database executeUpdate:strDeleteQuery];
    [instance.database close];
    
    if(isDeleted)
        [Constants printLogKey:@"Delete" printValue:@"Success"];
    else
        [Constants printLogKey:@"Delete" printValue:@"Error"];
}

-(NSString *)selectColumn:(NSString *)strSelectQuery andColumnName:(NSString *)strColumnName
{
    [Constants printLogKey:@"Select Column Query" printValue:strSelectQuery];
    [instance.database open];
    NSString * resultValue=@"";
    FMResultSet *resultSet=[instance.database executeQuery:strSelectQuery];
    if([resultSet next])
    {
        resultValue = [resultSet stringForColumn:strColumnName];
    }
    [instance.database close];
    return resultValue;
}

-(NSMutableArray *)selectData:(NSString *)strSelectQuery
{
    [Constants printLogKey:@"Select Query" printValue:strSelectQuery];
    NSMutableArray *results = [NSMutableArray array];
    [instance.database open];
    FMResultSet *resultSet=[instance.database executeQuery:strSelectQuery];
    if(resultSet)
    {
        while([resultSet next])
            [results addObject:[resultSet resultDictionary]];
    }
    [instance.database close];
    return results;
    
}

-(int)getTableRecordCount:(NSString *)countQuery{
    [Constants printLogKey:@"Count Query" printValue:countQuery];
    [instance.database open];
    FMResultSet *resultSetRecord = [instance.database executeQuery:countQuery];
    int totalCount=0;
    if ([resultSetRecord next]) {
        totalCount = [resultSetRecord intForColumnIndex:0];
    }
    [instance.database close];
    [Constants printLogKey:@"Table Record count" printValue:[NSString stringWithFormat:@"%d",totalCount]];
    return totalCount;
}

# pragma InsertQuery Formatting Function

-(void)insertDataInDb:(NSString *)insertTableName keyValueDic:(NSDictionary *)insertKeyValueDic{
    
    NSMutableArray* cols = [[NSMutableArray alloc] init];
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    for (id key in insertKeyValueDic) {
        [cols addObject:key];
        [vals addObject:[insertKeyValueDic objectForKey:key]];
    }
    NSMutableArray* newCols = [[NSMutableArray alloc] init];
    NSMutableArray* newVals = [[NSMutableArray alloc] init];
    for (int i = 0; i<[cols count]; i++) {
        
        [newCols addObject:[NSString stringWithFormat:@"'%@'", [cols objectAtIndex:i]]];
        
        if (![[vals objectAtIndex:i] isKindOfClass:[NSNull class]]){
            NSString * valueToString=[NSString stringWithFormat:@"%@", [vals objectAtIndex:i]];
            NSString * strReplaceSingleQuote=[valueToString stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
//        
            NSString * strWithoutSingleQuote=[NSString stringWithFormat:@"'%@'", strReplaceSingleQuote];
            [newVals addObject:strWithoutSingleQuote];
        }
        else{
            [newVals addObject:@""];
        }
    }
    NSString* insertQuerySql = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)", insertTableName,[newCols componentsJoinedByString:@", "], [newVals componentsJoinedByString:@", "]];
    
    [self insertData:insertQuerySql];
    
}


-(void)insertDataInDbMethod1:(NSString *)insertTableName keyValueDic:(NSDictionary *)insertKeyValueDic{
    
    NSArray* keys = [insertKeyValueDic allKeys];
    NSMutableArray *prefixedKeys = [NSMutableArray array];
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [prefixedKeys addObject:[NSString stringWithFormat:@":%@",obj]];
    }];
    //NSLog(@"",prefixedKeys);
    NSString *addAircraftQuery = [NSString stringWithFormat: @"INSERT INTO %@ (%@) VALUES (%@)",insertTableName,[keys componentsJoinedByString:@","],[prefixedKeys componentsJoinedByString:@","]];
    [self insertDataWithParameter:addAircraftQuery arrayParams:insertKeyValueDic];
    
}

-(void)updateDataInDb:(NSString *)updateTableName keyValueDic:(NSDictionary *)updateKeyValueDic whereFieldName:(NSString *)whereField whereFieldValue:(NSString *)whereValue{
    
    NSMutableArray* cols = [[NSMutableArray alloc] init];
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    for (id key in updateKeyValueDic) {
        [cols addObject:key];
        [vals addObject:[updateKeyValueDic objectForKey:key]];
    }
    NSMutableArray* newCols = [[NSMutableArray alloc] init];
    for (int i = 0; i<[cols count]; i++) {
       
        if (![[vals objectAtIndex:i] isKindOfClass:[NSNull class]]){
            NSString * valueToString=[NSString stringWithFormat:@"%@", [vals objectAtIndex:i]];
            NSString * strReplaceSingleQuote=[valueToString stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
//            NSString * strReplaceSingleQuote=[[vals objectAtIndex:i] stringByReplacingOccurrencesOfString:@"'" withString:@"''"];

            [newCols addObject:[NSString stringWithFormat:@"'%@' = '%@'", [cols objectAtIndex:i],strReplaceSingleQuote]];
        }
        else{
             [newCols addObject:[NSString stringWithFormat:@"'%@' = '%@'", [cols objectAtIndex:i],@""]];
        }
    }
    
    NSString * fullUpdateString = [NSString stringWithFormat:@"%@",[newCols componentsJoinedByString:@", "]];
    NSString* updateQuerySql = [NSString stringWithFormat:@"UPDATE %@ SET %@ where %@='%@'", updateTableName,fullUpdateString,whereField,whereValue];
    
    [self updateData:updateQuerySql];
    
}
-(void)updateMoreConditionDataInDb:(NSString *)updateTableName keyValueDic:(NSDictionary *)updateKeyValueDic whereFieldName:(NSDictionary *)updateWherKeyValueDic {
    
    NSMutableArray* cols = [[NSMutableArray alloc] init];
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    for (id key in updateKeyValueDic) {
        [cols addObject:key];
        [vals addObject:[updateKeyValueDic objectForKey:key]];
    }
    NSMutableArray* newCols = [[NSMutableArray alloc] init];
    for (int i = 0; i<[cols count]; i++) {
       
        if (![[vals objectAtIndex:i] isKindOfClass:[NSNull class]]){
            NSString * valueToString=[NSString stringWithFormat:@"%@", [vals objectAtIndex:i]];
            NSString * strReplaceSingleQuote=[valueToString stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
           
            
            [newCols addObject:[NSString stringWithFormat:@"'%@' = '%@'", [cols objectAtIndex:i],strReplaceSingleQuote]];
        }
        else{
            [newCols addObject:[NSString stringWithFormat:@"'%@' = '%@'", [cols objectAtIndex:i],@""]];
        }
    }
    
    NSString * fullUpdateString = [NSString stringWithFormat:@"%@",[newCols componentsJoinedByString:@", "]];
    
    
    [cols removeAllObjects];
    [vals removeAllObjects];
    [newCols removeAllObjects];
    
    for (id key in updateWherKeyValueDic) {
        [cols addObject:key];
        [vals addObject:[updateWherKeyValueDic objectForKey:key]];
    }
    for (int i = 0; i<[cols count]; i++) {
      
        if (![[vals objectAtIndex:i] isKindOfClass:[NSNull class]]){
            NSString * valueToString=[NSString stringWithFormat:@"%@", [vals objectAtIndex:i]];
            NSString * strReplaceSingleQuote=[valueToString stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
           
            [newCols addObject:[NSString stringWithFormat:@"'%@' = '%@'", [cols objectAtIndex:i],strReplaceSingleQuote]];
        }
        else{
            [newCols addObject:[NSString stringWithFormat:@"'%@' = '%@'", [cols objectAtIndex:i],@""]];
        }
    }

    
     NSString *whereField = [NSString stringWithFormat:@"%@",[newCols componentsJoinedByString:@" and "]];
    
    
    NSString* updateQuerySql = [NSString stringWithFormat:@"UPDATE %@ SET %@ where %@", updateTableName,fullUpdateString,whereField];
    
    [self updateData:updateQuerySql];
    
}

-(void)updateAllData:(NSString *)updateTableName keyAllValueDic:(NSDictionary *)updateKeyValueDic {
    
    NSMutableArray* cols = [[NSMutableArray alloc] init];
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    for (id key in updateKeyValueDic) {
        [cols addObject:key];
        [vals addObject:[updateKeyValueDic objectForKey:key]];
    }
    NSMutableArray* newCols = [[NSMutableArray alloc] init];
    for (int i = 0; i<[cols count]; i++) {
        
        if (![[vals objectAtIndex:i] isKindOfClass:[NSNull class]]){
            NSString * valueToString=[NSString stringWithFormat:@"%@", [vals objectAtIndex:i]];
            NSString * strReplaceSingleQuote=[valueToString stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
           

            [newCols addObject:[NSString stringWithFormat:@"'%@' = '%@'", [cols objectAtIndex:i],strReplaceSingleQuote]];
        }
        else{
            [newCols addObject:[NSString stringWithFormat:@"'%@' = '%@'", [cols objectAtIndex:i],@""]];
        }
    }
    
    NSString * fullUpdateString = [NSString stringWithFormat:@"%@",[newCols componentsJoinedByString:@", "]];
    NSString* updateQuerySql = [NSString stringWithFormat:@"UPDATE %@ SET %@", updateTableName,fullUpdateString];
    
    [self updateData:updateQuerySql];
    
}


- (BOOL)executeBatchQuery:(NSString *)sql
{
    BOOL success = false;
    [instance.database open];
    success = [instance.database executeStatements:sql];
    [instance.database close];
    
    if(success)
        [Constants printLogKey:@"Batch Query Execution" printValue:@"Success"];
    else
        [Constants printLogKey:@"Batch Query Execution" printValue:@"Error"];
    
        return true;
}

@end
