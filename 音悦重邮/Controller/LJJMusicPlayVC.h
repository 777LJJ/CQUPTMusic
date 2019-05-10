//
//  LJJMusicPlayVC.h
//  音悦重邮
//
//  Created by J J on 2019/5/6.
//  Copyright © 2019 J J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface LJJMusicPlayVC : UIViewController<AVAudioPlayerDelegate>
@property (retain,nonatomic)AVAudioPlayer *player;
@property (retain,nonatomic)NSTimer *timer;
@property NSUInteger integer;
@property NSString *musicName;
@end

NS_ASSUME_NONNULL_END
