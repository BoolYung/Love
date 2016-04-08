//
//  CleanViewController.m
//  LoveBaby
//
//  Created by YUNG on 15-4-25.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import "CleanViewController.h"
#import "FMDBManager.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface CleanViewController ()
{
    UIImage *iamgeed; //选择的图片
    UIView *colocrView; //制作滤镜视图
}
@end

@implementation CleanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([[FMDBManager shareInstance] updateBabyInfoInDB:233 byType:@"money" withNewNum:777]) {
        NSLog(@"db 成功");
    } else {
        NSLog(@"db 失败");
    }
    UIView *tulvView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 50, 500)];//颜色视图
    [self.view addSubview:tulvView];
    
    //选择滤镜颜色的按钮
    for (int i = 0; i < 10; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [button setBackgroundColor:[UIColor grayColor]];
        button.backgroundColor = [UIColor colorWithRed:rand()%10*0.1 green:rand()%10*0.1 blue:rand()%10*0.1  alpha:1];
        button.frame = CGRectMake(0, i * 50, 50, 50);
        [button addTarget:self action:@selector(butttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [tulvView addSubview:button];
        
    }
    
    //添加捏合手势
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
    [self.view addGestureRecognizer:pinch];
    
}

//捏合手势方法
- (void)pinAction:(UIPinchGestureRecognizer *)pin{
    
    NSLog(@"%f",pin.velocity);
    if(pin.velocity > 0){
        
        if(colocrView.alpha < 1){
            
            colocrView.alpha = colocrView.alpha + 0.01;
            
        }
        
        
    }else if(pin.velocity < 0){
        
        if(colocrView.alpha > 0){
            
            colocrView.alpha = colocrView.alpha - 0.01;
        }
        
    }
    
    
}

//选择滤镜颜色的按钮方法
- (void)butttonAction:(UIButton *)button{
    
    if (colocrView == nil) {
        
        colocrView = [[UIView alloc] initWithFrame:_imageView.bounds];
        colocrView.alpha = 0.2;
        [_imageView addSubview:colocrView];
        
    }
    colocrView.backgroundColor = button.backgroundColor;
    
    
}

//把UIView 转换成图片
-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectPhoto:(id)sender {
    //选择相片的控制器(导航控制器)
    UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
    
    //图片来源的类型
    //PhotoLibrary  系统所有的文件夹(默认)
    //SavedPhotosAlbum 系统相册文件夹
    //Camera 相机
    pickerCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    pickerCtrl.delegate = self;
    
    [self presentViewController:pickerCtrl animated:YES completion:nil];
}

- (IBAction)camerPhoto:(id)sender {
    //判断是否有摄像头
    //rear 后置
    //front 前置
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return;
    }
    
    UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
    
    pickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    pickerCtrl.delegate = self;
    
    [self presentViewController:pickerCtrl animated:YES completion:nil];
}

- (IBAction)selectViedo:(id)sender {
    UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
    
    pickerCtrl.delegate = self;
    
    //多媒体资源的类型
    pickerCtrl.mediaTypes = @[@"public.movie"];
    
    [self presentViewController:pickerCtrl animated:YES completion:nil];
}

- (IBAction)makeViedo:(id)sender {
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return;
    }
    
    UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
    
    pickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    pickerCtrl.mediaTypes = @[@"public.movie"];
    
    pickerCtrl.delegate = self;
    
    [self presentViewController:pickerCtrl animated:YES completion:nil];
}

- (IBAction)saveImage:(id)sender {
    [self saveImage];
}

- (IBAction)shareImage:(id)sender {
    return;
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"snow.png"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           case SSDKResponseStateCancel:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享取消"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    iamgeed = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = iamgeed;
    
    //picker image ctrl返回需要自己手动dismiss
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        //保存拍摄的图片到系统相册
        
        UIImageWriteToSavedPhotosAlbum(iamgeed, self, @selector(saveImage), NULL);
    }else if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        NSLog(@"UIImagePickerControllerSourceTypePhotoLibrary");
    }else if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum){
        NSLog(@"UIImagePickerControllerSourceTypeSavedPhotosAlbum");
    }
    
    
    
    
}

//把UIImageView保存为图片格式
- (void)saveImage
{
    
    UIGraphicsBeginImageContext(_imageView.bounds.size);
    [_imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    
    
    /*
    NSString *mainPath = NSHomeDirectory();
    NSLog(@"%@",NSHomeDirectory());
    NSDate *date = [NSDate date];
    NSLog(@"%@",date);
    NSString *namepng = [NSString stringWithFormat:@"Documents/%@.png",date];
    NSString *namejpg = [NSString stringWithFormat:@"Documents/%@.jpg",date];
    
    NSString *pathpng = [mainPath stringByAppendingPathComponent:namepng];
    NSString *pathjpg = [mainPath stringByAppendingPathComponent:namejpg];
    
    [UIImageJPEGRepresentation(viewImage, 1.0) writeToFile:pathjpg atomically:YES];
    [UIImagePNGRepresentation(viewImage)writeToFile:pathpng atomically:YES];
    */
    
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"呵呵";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertview show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
