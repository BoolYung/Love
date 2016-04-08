//
//  FMDBManager.m
//  LoveBaby
//
//  Created by 梅阳阳 on 15/4/26.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import "FMDBManager.h"
#import "Baby.h"
//需要保存的数据：用户：id；总钱数：money；洗衣次数：washingNum;做饭次数：cookNum;打扫次数：cleanNum;
//               洗碗次数：washdishNum
#define CREATE_TABLE_babyList @"CREATE TABLE IF NOT EXISTS babyList(id integer primary key autoincrement , userid INTEGER , money INTEGER , washingNum INTEGER, cookNum INTEGER, cleanNum INTEGER, washdishNum INTEGER)"
@implementation FMDBManager

+ (FMDBManager*)shareInstance
{
    static FMDBManager * manager = nil;
    //dispach_once函数中的代码块只会被执行一次，而且还是线程安全的。
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] initWithDB];
    });
    return manager;
}

- (id)initWithDB
{
    if (self = [super init]) {
        [self createDB];
    }
    return self;
}

- (BOOL)createDB
{
    //通过指定SQLite数据库文件路径来创建FMDatabase对象
    _db = [FMDatabase databaseWithPath:[self dbPath]];
    if ([_db open]) {
        if ([_db executeUpdate:CREATE_TABLE_babyList])
        {
            NSLog(@"create table successed");
            return YES;
        }
        {
            NSLog(@"create table faild");
        }
    }else{
        NSLog(@"db open faild");
    }
    return NO;
}

//获取db的路径
- (NSString *)dbPath
{
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDic = [arr objectAtIndex:0];
    NSString *daPath = [documentDic stringByAppendingString:@"/databse.db"];
    NSLog(@"###%@",daPath);
    return daPath;
}

#pragma mark - use DB 使用dataBase
//添加
- (BOOL)insertBabyInfoInDB:(Baby*)bb
{
    NSString* sql = @"INSERT INTO babyList(userid, money, washingNum , cookNum, cleanNum, washdishNum) VALUES(?,?,?,?,?,?)";
    if ([_db executeUpdate:sql,
         [NSNumber numberWithInteger:bb.userid],
         [NSNumber numberWithInteger:bb.money],
         [NSNumber numberWithInteger:bb.washingNum],
         [NSNumber numberWithInteger:bb.cookNum],
         [NSNumber numberWithInteger:bb.cleanNum],
         [NSNumber numberWithInteger:bb.washdishNum]])
    {
        NSLog(@"save bb successed");
        return YES;
    }else
    {
        NSLog(@"save bb faild");
        return NO;
    }
}

//更新单个数据
- (BOOL)updateBabyInfoInDB:(NSInteger)userid byType:(NSString*)type withNewNum:(NSInteger)newNums
{
    NSString *sql1 = [NSString stringWithFormat:@"UPDATE babyList SET %@ = ?  WHERE userid = ?",type];
    
    if ([_db executeUpdate:sql1,
         [NSNumber numberWithInteger:newNums],
         [NSNumber numberWithInteger:userid]]) {
        return YES;
    } else {
        return NO;
    }
}
//查找
- (NSMutableArray *)getBabyFromDBByUserid:(int)userid
{
    NSMutableArray *arr = [NSMutableArray array];
    NSString* sql = @"SELECT * FROM babyList WHERE userid = ?";
    FMResultSet* result = [_db executeQuery:sql,[NSNumber numberWithInteger:userid]];
    while ([result next])
    {
        Baby * bb = [Baby babyWithResult:result];
        [arr addObject:bb];
    }
    return arr;
}

- (BOOL)deletBabyInfoDBbyUserid:(NSInteger)userid
{
    NSString* sql = @"DELETE FROM student WHERE userid = ?";
    if ([_db executeUpdate:sql,[NSNumber numberWithInteger:userid]])
    {
        NSLog(@"delete successed");
        return YES;
    }else
    {
        NSLog(@"delete faild");
        return NO;
    }
}

- (void)closeDB
{
    [_db close];
}
@end
