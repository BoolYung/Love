//
//  AchieveViewController.m
//  LoveBaby
//
//  Created by YUNG on 15-4-25.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import "AchieveViewController.h"
#import "Baby.h"
#import "FMDBManager.h"
#import <QuartzCore/QuartzCore.h>
#import "RNSampleCell.h"
@interface AchieveViewController ()
@property (weak, nonatomic) IBOutlet RNRippleTableView *rippleView;

@end

@implementation AchieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    NSLog(@"###%d",(int)[(Baby*)[[[FMDBManager shareInstance] getBabyFromDBByUserid:111] objectAtIndex:0] money]);
    self.rippleView.ripplesOnShake = YES;
    [self.rippleView registerContentViewClass:[RNSampleCell class]];
    self.rippleView.delegate = self;
    self.rippleView.dataSource = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.rippleView becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIColor *)getColorWithIndex:(int)index
{
    UIColor * rightColor = [UIColor yellowColor];
    switch (index) {
        case 0:
            rightColor = [UIColor colorWithRed:238/255.f green:188/255.f blue:67/255.f alpha:1];  //橙色
            break;
        case 1:
            rightColor = [UIColor colorWithRed:226/255.f green:123/255.f blue:123/255.f alpha:1];  //红色
            break;
        case 2:
            rightColor = [UIColor colorWithRed:193/255.f green:224/255.f blue:63/255.f alpha:1];  //绿色
            break;
        case 3:
            rightColor = [UIColor colorWithRed:240/255.f green:229/255.f blue:73/255.f alpha:1];  //黄色
            break;
        case 4:
            rightColor = [UIColor colorWithRed:151/255.f green:199/255.f blue:253/255.f alpha:1];  //蓝色
            break;
        case 5:
            rightColor = [UIColor colorWithRed:211/255.f green:163/255.f blue:252/255.f alpha:1];  //紫色
            break;
        case 6:
            rightColor = [UIColor colorWithRed:199/255.f green:199/255.f blue:199/255.f alpha:1];  //灰色
            break;
        default:
            break;
    }
    return rightColor;
}

#pragma -TableView delegate
- (NSInteger)numberOfItemsInTableView:(RNRippleTableView *)tableView{
    return 12;
}

- (UIView *)viewForTableView:(RNRippleTableView *)tableView atIndex:(NSInteger)index withReuseView:(RNSampleCell *)reuseView{
    
    reuseView.backgroundColor = [self getColorWithIndex:index%7];
    reuseView.titleLabel.text = [NSString stringWithFormat:@"已完成%ld元储蓄",index+1];
    return reuseView;
}

#pragma mark - Tableview DataSource

- (CGFloat)heightForViewInTableView:(RNRippleTableView *)tableView atIndex:(NSInteger)index {
    return 71;
}

- (void)tableView:(RNRippleTableView *)tableView didSelectView:(UIView *)view atIndex:(NSInteger)index {
    NSLog(@"Row %ld tapped",index);
}
@end
