//
//  Lesson.h
//  newCenceptRepeater
//
//  Created by silvon on 12-11-21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Sentence;

@interface Lesson : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet *sentences;
@end

@interface Lesson (CoreDataGeneratedAccessors)

- (void)addSentencesObject:(Sentence *)value;
- (void)removeSentencesObject:(Sentence *)value;
- (void)addSentences:(NSSet *)values;
- (void)removeSentences:(NSSet *)values;

@end
