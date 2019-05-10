//
//  LJJMusicPlayVC.m
//  音悦重邮
//
//  Created by J J on 2019/5/6.
//  Copyright © 2019 J J. All rights reserved.
//

#import "LJJMusicPlayVC.h"
#import "LJJMusicPlayView.h"
#import "LJJLoginedVC.h"
@interface LJJMusicPlayVC ()
@property(nonatomic, strong) LJJMusicPlayView *playView;
@property(nonatomic, strong) NSArray *arrayMusic;

@end
@implementation LJJMusicPlayVC
#define HEIGHT UIScreen.mainScreen.bounds.size.height
#define WIDTH UIScreen.mainScreen.bounds.size.width

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrayMusic = @[@"林俊杰-不为谁而作的歌",@"林俊杰-剪云者",@"林俊杰-圣所",@"林俊杰-修炼爱情",@"林俊杰-我继续",@"林俊杰-一眼万年",@"林俊杰-伟大的渺小"];
    _playView = [[LJJMusicPlayView alloc] init];
    NSString *str = [[NSString alloc] initWithFormat:@"JJLin%lu",(unsigned long)_integer];
    _playView.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:str]];
    _playView.imageView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [self.view addSubview:_playView.imageView];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeBackImage) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view.
    
    NSLog(@"the music name is %@",_arrayMusic[(unsigned long)_integer]);
    [self setButtons];
    [self creatAVPlayer:_integer];
}

- (void)creatAVPlayer:(NSUInteger )a
{
    NSLog(@"%lu",(unsigned long)a);
    NSString *nameCopy = [[NSBundle mainBundle] pathForResource:_arrayMusic[a] ofType:@"mp3"];
    NSURL *urlMusic = [NSURL fileURLWithPath:nameCopy];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlMusic error:nil];
    [_player prepareToPlay];
    _player.numberOfLoops = 1;
    _player.volume = 0.5;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    _player.delegate = self;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [_timer invalidate];
}

- (void)updateTimer
{
    _playView.musicProgress.progress = _player.currentTime / _player.duration;
}

- (void)setButtons
{
    _playView.buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playView.buttonBack setImage:[UIImage imageNamed:@"BackBtn"] forState:UIControlStateNormal];
    _playView.buttonBack.frame = CGRectMake(17, 25, 40, 20);
    [_playView.buttonBack addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playView.buttonBack];
    
    _playView.buttonPause = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playView.buttonPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [_playView.buttonPause addTarget:self action:@selector(pauseMusic) forControlEvents:UIControlEventTouchUpInside];
    _playView.buttonPause.frame = CGRectMake(WIDTH * 0.5 - 20, HEIGHT * 0.77, 40, 40);
    [self.view addSubview:_playView.buttonPause];
    
    _playView.buttonPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playView.buttonPlay setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_playView.buttonPlay addTarget:self action:@selector(playMusic) forControlEvents:UIControlEventTouchUpInside];
    _playView.buttonPlay.frame = CGRectMake(WIDTH * 0.5 + 40, HEIGHT * 0.77, 40, 40);
    [self.view addSubview:_playView.buttonPlay];
    
    _playView.buttonStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playView.buttonStop setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [_playView.buttonStop addTarget:self action:@selector(stopMusic) forControlEvents:UIControlEventTouchUpInside];
    _playView.buttonStop.frame = CGRectMake(WIDTH * 0.5 - 80, HEIGHT * 0.77, 40, 40);
    [self.view addSubview:_playView.buttonStop];
    
    _playView.buttonStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playView.buttonStop setImage:[UIImage imageNamed:@"leftBtn"] forState:UIControlStateNormal];
    [_playView.buttonStop addTarget:self action:@selector(leftMusic) forControlEvents:UIControlEventTouchUpInside];
    _playView.buttonStop.frame = CGRectMake(WIDTH * 0.5 - 140, HEIGHT * 0.77, 40, 40);
    [self.view addSubview:_playView.buttonStop];
    
    _playView.buttonStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playView.buttonStop setImage:[UIImage imageNamed:@"rightBtn"] forState:UIControlStateNormal];
    [_playView.buttonStop addTarget:self action:@selector(rightMusic) forControlEvents:UIControlEventTouchUpInside];
    _playView.buttonStop.frame = CGRectMake(WIDTH * 0.5 + 100, HEIGHT * 0.77, 40, 40);
    [self.view addSubview:_playView.buttonStop];
    
    _playView.musicProgress = [[UIProgressView alloc] init];
    _playView.musicProgress.frame = CGRectMake(30, HEIGHT * 0.9, WIDTH - 60, 10);
    _playView.musicProgress.progress = 0;
    [self.view addSubview:_playView.musicProgress];
}

- (void)stopMusic
{
    [_player stop];
    _player.currentTime = 0;
    NSLog(@"stop");
}

- (void)playMusic
{
    [_player play];
    NSLog(@"play");
}

- (void)pauseMusic
{
    [_player pause];
    NSLog(@"pause");
}

- (void)leftMusic
{
    if ((unsigned long)_integer == 0)
        _integer = 7;
    unsigned long a = _integer - 1;
    _integer --;
    [self creatAVPlayer:a];
    [self playMusic];
    NSLog(@"left");
}

- (void)rightMusic
{
    if ((unsigned long)_integer == 6)
        _integer = -1;
    unsigned long a = (unsigned long)_integer + 1;
    _integer ++;
    [self creatAVPlayer:a];
    [self playMusic];
    NSLog(@"right");
}

- (void)pressBtn
{
    [_player stop];
    LJJLoginedVC *backView = [[LJJLoginedVC alloc] init];
    [self presentViewController:backView animated:YES completion:nil];
}

- (void)changeBackImage
{
    NSUInteger value = arc4random() % 7;
    NSString *str = [[NSString alloc] initWithFormat:@"JJLin%lu",(unsigned long)value];
    CATransition *animation = [CATransition animation];
    animation.duration = 3;
    animation.type = @"fade";
    animation.subtype = kCATransitionFromLeft;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_playView.imageView.layer addAnimation:animation forKey:nil];
    _playView.imageView.image = [UIImage imageNamed:str];
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
