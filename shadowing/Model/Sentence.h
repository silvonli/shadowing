//
//  Sentence.h
//  shadowing
//
//  Created by silvon on 12-12-20.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lesson;

@interface Sentence : NSManagedObject

@property (nonatomic, retain) NSNumber * beginTime;
@property (nonatomic, retain) NSNumber * endTime;
@property (nonatomic, retain) NSString * textContent;
@property (nonatomic, retain) NSNumber * bSel;
@property (nonatomic, retain) Lesson *witchOfLesson;

@end
