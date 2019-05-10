//
//  LJJLoginedVC.m
//  音悦重邮
//
//  Created by J J on 2019/5/5.
//  Copyright © 2019 J J. All rights reserved.
//

#import "LJJLoginedVC.h"
#import "LJJLoginedView.h"
#import "LJJMusicPlayVC.h"
@interface LJJLoginedVC ()

@property (nonatomic, strong) LJJLoginedView *loginedView;
@property (nonatomic, strong) NSArray *array;

@end

@implementation LJJLoginedVC

#define HEIGHT UIScreen.mainScreen.bounds.size.height
#define WIDTH UIScreen.mainScreen.bounds.size.width

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _loginedView = [[LJJLoginedView alloc] init];
    _loginedView.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    _loginedView.imageView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [self.view addSubview:_loginedView.imageView];
    [self setLabel];
    [self creatTableView];
}

- (void)setLabel
{
    _loginedView.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT / 8.0)];
    _loginedView.label.text = @"Slave to the Rhythm Rock with you";
    _loginedView.label.textColor = [UIColor whiteColor];
    _loginedView.label.font = [UIFont fontWithName:@"Chalkduster" size:25];
    _loginedView.label.numberOfLines = 0;
    _loginedView.label.textAlignment = NSTextAlignmentCenter;
    [_loginedView.imageView addSubview:_loginedView.label];
}

- (void)creatTableView
{
    _array = @[@"林俊杰-不为谁而作的歌",@"林俊杰-剪云者",@"林俊杰-圣所",@"林俊杰-修炼爱情",@"林俊杰-我继续",@"林俊杰-一眼万年",@"林俊杰-伟大的渺小"];
    for (int a = 0; a < 7; a ++)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn.frame = CGRectMake(20, 100 + a * 66, WIDTH - 80, 60);
        _btn.backgroundColor = [UIColor clearColor];
        _btn.tag = a;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, WIDTH - 100, 60)];
        label.text = [NSString stringWithFormat:@"%@",_array[a]];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:17];
        [_btn addSubview:label];
        
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"JJ-%d.JPG",a]]];
        view.clipsToBounds = YES;
        view.layer.cornerRadius = 27.5;
        view.frame = CGRectMake(0, 0, 55, 55);
        [_btn addSubview:view];
        [_btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btn];
    }
}

- (void)pressBtn:(UIButton *)btn
{
    LJJMusicPlayVC *playVc = [[LJJMusicPlayVC alloc] init];
    playVc.integer = btn.tag;
    playVc.musicName = _array[btn.tag];
    [self presentViewController:playVc animated:YES completion:nil];
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
