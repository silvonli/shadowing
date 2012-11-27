//
//  Lesson.h
//  shadowing
//
//  Created by silvon on 12-11-26.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Sentence;

@interface Lesson : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSData * mp3;
@property (nonatomic, retain) NSSet *sentences;
@end

@interface Lesson (CoreDataGeneratedAccessors)

- (void)addSentencesObject:(Sentence *)value;
- (void)removeSentencesObject:(Sentence *)value;
- (void)addSentences:(NSSet *)values;
- (void)removeSentences:(NSSet *)values;

@end
