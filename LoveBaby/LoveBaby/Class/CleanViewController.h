//
//  CleanViewController.h
//  LoveBaby
//
//  Created by YUNG on 15-4-25.
//  Copyright (c) 2015年 KingYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CleanViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)camerPhoto:(id)sender;
- (IBAction)selectViedo:(id)sender;
- (IBAction)makeViedo:(id)sender;

- (IBAction)saveImage:(id)sender;
- (IBAction)shareImage:(id)sender;

@end
