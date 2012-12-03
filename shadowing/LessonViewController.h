//
//  LessonViewController.h
//  shadowing
//
//  Created by silvon on 12-12-2.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lesson.h"
#import "Sentence.h"
#import "LessonListTableViewController.h"
#import "CTView.h"

@interface LessonViewController : UIViewController <LessonListTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet CTView *currenLessonView;

@property(nonatomic, strong) UIPopoverController *lessonsPopover;
@property(nonatomic, strong) Lesson* currenLesson;
@end
