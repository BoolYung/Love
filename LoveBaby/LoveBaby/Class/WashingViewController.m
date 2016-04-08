//
//  WashingViewController.m
//  LoveBaby
//
//  Created by YUNG on 15-4-25.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import "WashingViewController.h"
#import "FMDBManager.h"
@interface WashingViewController ()

@end

@implementation WashingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([[FMDBManager shareInstance] updateBabyInfoInDB:233 byType:@"money" withNewNum:8888]) {
        NSLog(@"db 成功");
    } else {
        NSLog(@"db 失败");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
