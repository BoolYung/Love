//
//  FMDBManager.h
//  LoveBaby
//
//  Created by 梅阳阳 on 15/4/26.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Baby.h"
enum{
    kMoneyNum = 111111,
    kCookNum  = 222222,
    kCleanNum = 333333,
    kWashingNum = 444444,
    
}userID;
@interface FMDBManager : NSObject
{
    FMDatabase *_db;
}

+ (FMDBManager*)shareInstance;
- (BOOL)createDB;
- (BOOL)insertBabyInfoInDB:(Baby*)bb;
- (NSMutableArray *)getBabyFromDBByUserid:(int)userid;
- (BOOL)deletBabyInfoDBbyUserid:(NSInteger)userid;
- (BOOL)updateBabyInfoInDB:(NSInteger)userid byType:(NSString*)type withNewNum:(NSInteger)newNums;
- (void)closeDB;
@end
