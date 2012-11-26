//
//  LessonListTableViewController.h
//  shadowing
//
//  Created by silvon on 12-11-23.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonListTableViewController : UITableViewController

@property(nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property(nonatomic, strong) NSArray * arrLensons;
@end
