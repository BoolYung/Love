//
//  SaveViewController.m
//  LoveBaby
//
//  Created by YUNG on 15-4-25.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import "SaveViewController.h"
#import "TextUtil.h"
#import "Baby.h"
#import "FMDBManager.h"

#define kCoinCountKey   300         //金币总数
@interface SaveViewController (){
    UIImageView     *_bagView;      //福袋图层
    NSMutableArray  *_coinTagsArr;  //存放生成的所有金币对应的tag值
    int coinCount ;                 //统计金币数量的变量
}

@end

@implementation SaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = [TextUtil getTextWithTag:@"tag_Save"];
//    NSLog(@"###%d",(int)[(Baby*)[[[FMDBManager shareInstance] getBabyFromDBByUserid:111] objectAtIndex:0] money]);
    
    _coinTagsArr = [NSMutableArray new];
    //主福袋层
    _bagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_hongbao_bags"]];
    _bagView.center = CGPointMake(CGRectGetMidX(self.view.frame) + 10, CGRectGetMidY(self.view.frame) - 20);
    [self.view addSubview:_bagView];
    [self getCoinAction];
}


- (void)getCoinAction{
    //初始化金币生成的数量
    coinCount = 0;
    for (int i = 0; i<kCoinCountKey; i++) {
        
        //延迟调用函数
        [self performSelector:@selector(initCoinViewWithInt:) withObject:[NSNumber numberWithInt:i] afterDelay:i * 0.01];
    }

}

- (void)initCoinViewWithInt:(NSNumber *)i
{
    UIImageView *coin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_coin_%d",[i intValue] % 2 + 1]]];
    
    //初始化金币的最终位置
    coin.center = CGPointMake(CGRectGetMidX(self.view.frame) + arc4random()%40 * (arc4random() %3 - 1) - 20, CGRectGetMidY(self.view.frame) - 20);
    coin.tag = [i intValue] + 1;
    //每生产一个金币,就把该金币对应的tag加入到数组中,用于判断当金币结束动画时和福袋交换层次关系,并从视图上移除
    [_coinTagsArr addObject:[NSNumber numberWithInt:(int)coin.tag]];
    
    [self.view addSubview:coin];
    
    [self setAnimationWithLayer:coin];
}

- (void)setAnimationWithLayer:(UIView *)coin
{
    CGFloat duration = 1.6f;
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    //绘制从底部到福袋口之间的抛物线
    CGFloat positionX   = coin.layer.position.x;    //终点x
    CGFloat positionY   = coin.layer.position.y;    //终点y
    CGMutablePathRef path = CGPathCreateMutable();
    int fromX       = arc4random() % 320;     //起始位置:x轴上随机生成一个位置
    int height      = [UIScreen mainScreen].bounds.size.height + coin.frame.size.height; //y轴以屏幕高度为准
    int fromY       = arc4random() % (int)positionY; //起始位置:生成位于福袋上方的随机一个y坐标
    
    CGFloat cpx = positionX + (fromX - positionX)/2;    //x控制点
    CGFloat cpy = fromY / 2 - positionY;                //y控制点,确保抛向的最大高度在屏幕内,并且在福袋上方(负数)
    
    //动画的起始位置
    CGPathMoveToPoint(path, NULL, fromX, height);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, positionX, positionY);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:path];
    CFRelease(path);
    path = nil;
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    //图像由大到小的变化动画
    CGFloat from3DScale = 1 + arc4random() % 10 *0.1;
    CGFloat to3DScale = from3DScale * 0.5;
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(from3DScale, from3DScale, from3DScale)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(to3DScale, to3DScale, to3DScale)]];
    scaleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    //动画组合
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.animations = @[scaleAnimation, animation];
    [coin.layer addAnimation:group forKey:@"position and transform"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        
        //动画完成后把金币和数组对应位置上的tag移除
        UIView *coinView = (UIView *)[self.view viewWithTag:[[_coinTagsArr firstObject] intValue]];
        
        [coinView removeFromSuperview];
        [_coinTagsArr removeObjectAtIndex:0];
        
        //全部金币完成动画后执行的动作
        if (++coinCount == kCoinCountKey) {
            
            [self bagShakeAnimation];
            
//            if (_getBtn) {
//                
//                [self.view addSubview:_getBtn];
//                [_getBtn setTitle:@"再来一次" forState:UIControlStateNormal];
//            }
            NSLog(@"全部金币完成动画后执行的动作");
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 350, 300, 50)];
            label.textColor = [UIColor greenColor];
            label.text = [NSString stringWithFormat:@"too hao you have %d coins",kCoinCountKey];
            [self.view addSubview:label];
            
        }
    }
}

//福袋晃动动画
- (void)bagShakeAnimation
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:- 0.2];
    shake.toValue   = [NSNumber numberWithFloat:+ 0.2];
    shake.duration = 0.1;
    shake.autoreverses = YES;
    shake.repeatCount = 4;
    
    [_bagView.layer addAnimation:shake forKey:@"bagShakeAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
