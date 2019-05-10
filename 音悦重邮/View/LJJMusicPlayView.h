//
//  LJJMusicPlayView.h
//  音悦重邮
//
//  Created by J J on 2019/5/6.
//  Copyright © 2019 J J. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJJMusicPlayView : UIView
@property (retain,nonatomic)UIImageView *imageView;
@property (retain,nonatomic)UIButton *buttonPlay;
@property (retain,nonatomic)UIButton *buttonPause;
@property (retain,nonatomic)UIButton *buttonStop;
@property (strong,nonatomic)UIButton *buttonBack;
@property (retain,nonatomic)UIProgressView *musicProgress;
@end

NS_ASSUME_NONNULL_END
