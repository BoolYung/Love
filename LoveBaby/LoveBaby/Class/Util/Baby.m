//
//  Baby.m
//  LoveBaby
//
//  Created by YUNG on 15-4-26.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import "Baby.h"

@implementation Baby
@synthesize userid = _userid,money = _money,washdishNum = _washdishNum,cookNum = _cookNum,cleanNum = _cleanNum,washingNum = _washingNum;
+ (Baby*)babyWithResult:(FMResultSet*)result
{
    Baby *bb = [[Baby alloc] init];
    bb.userid = [result intForColumn:@"userid"];
    bb.money = [result intForColumn:@"money"];
    bb.washingNum = [result intForColumn:@"washingNum"];
    bb.cookNum = [result intForColumn:@"cookNum"];
    bb.cleanNum = [result intForColumn:@"cleanNum"];
    bb.washdishNum = [result intForColumn:@"washdishNum"];
    return bb;
}
- (id)initWithUserid:(NSInteger)userid Money:(NSInteger)money washingNum:(NSInteger)washingNum cookNum:(NSInteger)cookNum cleanNum:(NSInteger)cleanNum washdishNum:(NSInteger)washdishNum
{
    if (self = [super init]) {
        self.userid = userid;
        self.money = money;
        self.washingNum = washingNum;
        self.cookNum = cookNum;
        self.cleanNum = cleanNum;
        self.washdishNum = washdishNum;
    }
    return self;
}
@end
