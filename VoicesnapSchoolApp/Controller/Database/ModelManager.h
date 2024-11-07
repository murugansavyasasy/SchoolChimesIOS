//
//  ModelManager.h
//  DataBaseDemo
//
//  Created by Shenll on 22/02/14.
//  Copyright (c) 2014 Shenll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
//#import "AppConstants_OBJC.h"
#import "Constants.h"
@interface ModelManager : NSObject

@property (nonatomic,strong) FMDatabase *database;

+(ModelManager *) getInstance;



-(void)insertData:(NSString *)strInsertQuery;
-(void)updateData:(NSString *)strUpdateQuery;
-(void)deleteData:(NSString *)strDeleteQuery;
-(NSString *)selectColumn:(NSString *)strSelectQuery andColumnName:(NSString *)strColumnName;
-(NSMutableArray *)selectData:(NSString *)strSelectQuery;
-(int)getTableRecordCount:(NSString *)countQuery;
-(void)insertDataInDb:(NSString *)insertTableName keyValueDic:(NSDictionary *)insertKeyValueDic;
-(void)updateDataInDb:(NSString *)updateTableName keyValueDic:(NSDictionary *)updateKeyValueDic whereFieldName:(NSString *)whereField whereFieldValue:(NSString *)whereValue;
-(void)updateAllData:(NSString *)updateTableName keyAllValueDic:(NSDictionary *)updateKeyValueDic;

-(void)insertDataInDbMethod1:(NSString *)insertTableName keyValueDic:(NSDictionary *)insertKeyValueDic;

-(void)updateMoreConditionDataInDb:(NSString *)updateTableName keyValueDic:(NSDictionary *)updateKeyValueDic whereFieldName:(NSDictionary *)updateWherKeyValueDic ;

- (BOOL)executeBatchQuery:(NSString *)sql;
@end
