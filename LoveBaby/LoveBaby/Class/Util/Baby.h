//
//  Baby.h
//  LoveBaby
//
//  Created by YUNG on 15-4-26.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface Baby : NSObject
@property (nonatomic,assign)NSInteger userid;
@property (nonatomic,assign)NSInteger money;
@property (nonatomic,assign)NSInteger washingNum;
@property (nonatomic,assign)NSInteger cookNum;
@property (nonatomic,assign)NSInteger cleanNum;
@property (nonatomic,assign)NSInteger washdishNum;
+ (Baby*)babyWithResult:(FMResultSet*)result;
- (id)initWithUserid:(NSInteger)userid Money:(NSInteger)money washingNum:(NSInteger)washingNum cookNum:(NSInteger)cookNum cleanNum:(NSInteger)cleanNum washdishNum:(NSInteger)washdishNum;
@end
