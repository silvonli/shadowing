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
- (void) didSelectLenssonInLessonList:(LessonListTableViewController*)listTVCtler;
@end

@interface LessonListTableViewController : UITableViewController

@property(nonatomic, weak) id<LessonListTableViewControllerDelegate> delegate;
@property(nonatomic, strong, readonly) NSManagedObjectContext * managedObjectContext;
@property(nonatomic, strong, readonly) NSArray * lessonsArray;
@property(nonatomic, strong) Lesson* selLesson;
@end
