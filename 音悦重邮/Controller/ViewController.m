//
//  ViewController.m
//  音悦重邮
//
//  Created by J J on 2019/5/5.
//  Copyright © 2019 J J. All rights reserved.
//

#import "ViewController.h"
#import "LJJLoginView.h"
#import "HttpClient.h"
#import "LJJLoginedVC.h"
@interface ViewController ()

@property (strong, nonatomic) LJJLoginView *loginView;

@end
@implementation ViewController

#define HEIGHT UIScreen.mainScreen.bounds.size.height
#define WIDTH UIScreen.mainScreen.bounds.size.width

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _loginView = [[LJJLoginView alloc] init];
    [self initImage];
}

- (void)initImage
{
    _loginView.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover"]];
    _loginView.image.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [self.view addSubview:_loginView.image];
    [self beginRemove];
}

- (void)beginRemove
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(remove) userInfo:nil repeats:YES];
}

- (void)remove
{
    [_timer invalidate];
    CATransition *animation = [CATransition animation];
    animation.duration = 3;
    animation.type = @"rippleEffect";
    
    animation.subtype = kCATransitionFromLeft;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.view.layer addAnimation:animation forKey:nil];
    _loginView.image.image = [UIImage imageNamed:@"BBB"];
    [self setHead];
}

- (void)setHead
{
    _loginView.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"JJ"]];
    _loginView.imageView.clipsToBounds = YES;
    _loginView.imageView.layer.cornerRadius = 50;
    _loginView.imageView.frame = CGRectMake(WIDTH / 2 - 50, 100, 100, 100);
    [self.view addSubview:_loginView.imageView];
    [self creatAction];
}

- (void)creatAction
{
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    _btn.frame = CGRectMake(WIDTH / 2 - 100, HEIGHT * 3.0 / 4, 200, 25);
    [_btn addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 25)];
    label.text = @"登陆";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [_btn addSubview:label];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cqupt"]];
    image.frame = CGRectMake(WIDTH * 0.1, HEIGHT * 0.1, WIDTH * 0.8, WIDTH * 0.8);
    image.alpha = 0.1;
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"音悦重邮" message:@"请进行身份验证后登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [UIView animateWithDuration:1.0 animations:^{
            self->_loginView.imageView.alpha = 0;
            self->_loginView.imageView.frame = CGRectMake(0, HEIGHT / 3 - 160, WIDTH, WIDTH);
            [self creatText];
            [self.view addSubview:self->_btn];
            [self.view addSubview:image];
        } completion:nil];
    }];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)creatText
{
    _loginView.label = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT * 0.4, WIDTH, HEIGHT * 0.15)];
    _loginView.label.text = @"Rock CQUPT.";
    _loginView.label.textColor = [UIColor whiteColor];
    _loginView.label.textAlignment = NSTextAlignmentCenter;
    _loginView.label.font = [UIFont fontWithName:@"Chalkduster" size:35];
    [self.view addSubview:_loginView.label];
    
    _loginView.name = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH * 0.2, HEIGHT * 4.6 / 8, WIDTH * 0.6, 25)];
    _loginView.name.borderStyle = UITextBorderStyleRoundedRect;
    _loginView.name.placeholder = @"请输入学号";
    [self.view addSubview:_loginView.name];
    
    _loginView.secret = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH * 0.2, HEIGHT * 5.2 / 8, WIDTH * 0.6, 25)];
    _loginView.secret.borderStyle = UITextBorderStyleRoundedRect;
    _loginView.secret.placeholder = @"请输入身份证后六位";
    _loginView.secret.secureTextEntry = YES;
    [self.view addSubview:_loginView.secret];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_loginView.secret resignFirstResponder];
    [_loginView.name resignFirstResponder];
}

- (void)Login
{
    NSLog(@"%@%@",_loginView.name.text,_loginView.label.text);
    NSDictionary *parameter = @{@"stuNum":_loginView.name.text,@"idNum":_loginView.secret.text};
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:@"https://wx.idsbllp.cn/api/verify" method:HttpRequestPost parameters:parameter prepareExecute:^{
        //
    } progress:^(NSProgress *progress) {
        //
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"status"] isEqual:@801]) {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"输入有误 请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [controller addAction:action];
            [self presentViewController:controller animated:YES completion:nil];
        }
        else
        {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"登录成功" message:@"欢迎使用音悦重邮" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //
                LJJLoginedVC *vc = [[LJJLoginedVC alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            }];
            [controller addAction:action];
            [self presentViewController:controller animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"请检查网络设置" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
        NSLog(@"%@",error);
    }];

}

@end
