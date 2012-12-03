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

@protocol LessonListTableViewControllerDelegate <NSObject>
- (void) didSelectLensson;
@end

@interface LessonListTableViewController : UITableViewController

@property(nonatomic, strong) id<LessonListTableViewControllerDelegate> delegate;
@property(nonatomic, strong, readonly) NSManagedObjectContext * managedObjectContext;
@property(nonatomic, strong, readonly) NSArray * lessonsArray;
@property(nonatomic, strong) Lesson* selLesson;
@end
