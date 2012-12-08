//
//  LessonViewController.h
//  shadowing
//
//  Created by silvon on 12-12-2.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTView.h"
#import "LessonListTableViewController.h"
#import "Lesson.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface LessonViewController : UIViewController <LessonListTableViewControllerDelegate>
{
    NSTimer * _timer;
}

@property (nonatomic, weak  ) IBOutlet CTView *currenLessonView;
@property (nonatomic, strong) UIPopoverController *lessonsPopover;
@property (nonatomic, strong) Lesson* currenLesson;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end
