//
//  MainViewController.m
//  LoveBaby
//
//  Created by 梅阳阳 on 15/4/23.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import "MainViewController.h"
#import "SaveViewController.h"
#import "TextUtil.h"
#import "AchieveViewController.h"
#import "CookingViewController.h"
#import "CleanViewController.h"
#import "WashingViewController.h"
#import "WashViewController.h"
#import "FMDBManager.h"
#import "Baby.h"


#define SNOW_IMAGENAME         @"snow"
#define IMAGE_X                arc4random()%(int)[[UIScreen mainScreen] bounds].size.width
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%20 + 10
#define PLUS_HEIGHT            Main_Screen_Height/25

@interface MainViewController ()
{
    NSMutableArray *_imagesArray;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //延迟启动图片
    [NSThread sleepForTimeInterval:3.0];
    self.navigationItem.title = @"First";
    UIFont *suitFont;
    if ([[TextUtil getCurrentLanguage] isEqualToString:@"en"]){
        suitFont = [UIFont fontWithName:@"Helvetica" size:10];
    } else {
        suitFont = [UIFont fontWithName:@"Helvetica" size:15];
    }
    _washingLable.text = [TextUtil getTextWithTag:@"tag_Washing"];
    _washingLable.font = suitFont;
    _saveLable.text = [TextUtil getTextWithTag:@"tag_Save"];
    _saveLable.font = suitFont;
    _achiveLable.text = [TextUtil getTextWithTag:@"tag_Achieve"];
    _achiveLable.font = suitFont;
    _washLable.text = [TextUtil getTextWithTag:@"tag_Wash"];
    _washLable.font = suitFont;
    _cookLable.text = [TextUtil getTextWithTag:@"tag_Cook"];
    _cookLable.font = suitFont;
    _cleanLable.text = [TextUtil getTextWithTag:@"tag_Clean"];
    _cleanLable.font = suitFont;
    
    if ([[FMDBManager shareInstance] createDB]) {
        NSLog(@"db 创建成功");
    } else {
        NSLog(@"db 创建失败");
    }
    
    [self initSnow];
}
-(void)initSnow{
    
    _imagesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; ++ i) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"snow.png"]];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
        imageView.alpha = IMAGE_ALPHA;
        [self.view addSubview:imageView];
        [_imagesArray addObject:imageView];
    }
    [NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(makeSnow) userInfo:nil repeats:YES];
}

static int i = 0;
- (void)makeSnow
{
    i = i + 1;
    if ([_imagesArray count] > 0) {
        UIImageView *imageView = [_imagesArray objectAtIndex:0];
        imageView.tag = i;
        [_imagesArray removeObjectAtIndex:0];
        [self snowFall:imageView];
    }
    
}

- (void)snowFall:(UIImageView *)aImageView
{
    [UIView beginAnimations:[NSString stringWithFormat:@"%ld",aImageView.tag] context:nil];
    [UIView setAnimationDuration:10];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake(aImageView.frame.origin.x, [[UIScreen mainScreen] bounds].size.height, aImageView.frame.size.width, aImageView.frame.size.height);
    NSLog(@"%@",aImageView);
    [UIView commitAnimations];
}

- (void)addImage
{
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:[animationID intValue]];
    float x = IMAGE_WIDTH;
    imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
    [_imagesArray addObject:imageView];
}


- (IBAction)ClickCleanBt:(UIButton *)sender {
    //打扫
    CleanViewController *CleanVC = [[CleanViewController alloc] init];
    CleanVC.title = [TextUtil getTextWithTag:@"tag_Clean"];
    [self.navigationController pushViewController:CleanVC animated:YES];
}
- (IBAction)ClickCookBt:(UIButton *)sender {
    //做饭
    CookingViewController * CookVC = [[CookingViewController alloc] init];
    CookVC.title = [TextUtil getTextWithTag:@"tag_Cook"];
    [self.navigationController pushViewController:CookVC animated:YES];
}
- (IBAction)ClickAchieveMentBt:(UIButton *)sender {
    //成就
    AchieveViewController *AchieveVC = [[AchieveViewController alloc] init];
    AchieveVC.title = [TextUtil getTextWithTag:@"tag_Achieve"];
    [self.navigationController pushViewController:AchieveVC animated:YES];
}
- (IBAction)ClickSaveBt:(UIButton *)sender {
    //存钱
    SaveViewController *SaveVc = [[SaveViewController alloc] init];
    SaveVc.title = [TextUtil getTextWithTag:@"tag_Save"];
    [self.navigationController pushViewController:SaveVc animated:YES];
}
- (IBAction)ClickWashBt:(UIButton *)sender {
    //洗碗
    WashViewController *WashVC = [[WashViewController alloc] init];
    WashVC.title = [TextUtil getTextWithTag:@"tag_Wash"];
    [self.navigationController pushViewController:WashVC animated:YES];
}
- (IBAction)ClickWashingBt:(UIButton *)sender {
    //洗衣服
    WashingViewController *WashingVC = [[WashingViewController alloc] init];
    WashingVC.title = [TextUtil getTextWithTag:@"tag_Washing"];
    [self.navigationController pushViewController:WashingVC animated:YES];
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
