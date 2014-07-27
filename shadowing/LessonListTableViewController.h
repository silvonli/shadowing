//
//  LessonListTableViewController.h
//  shadowing
//
//  Created by silvon on 12-11-23.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sentence.h"
#import "Lesson.h"

@class LessonListTableViewController;

@protocol LessonListTableViewControllerDelegate <NSObject>
- (void) lessonListController:(LessonListTableViewController*)lvc didSelectLensson:(Lesson*)selectedLesson;
@end

@interface LessonListTableViewController : UITableViewController

@property(nonatomic, weak) id<LessonListTableViewControllerDelegate> delegate;
@property(nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property(nonatomic, strong) NSArray * lessonsArray;
@property(nonatomic, strong) Lesson* selectedLesson;
@end
