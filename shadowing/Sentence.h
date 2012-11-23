//
//  Sentence.h
//  newCenceptRepeater
//
//  Created by silvon on 12-11-21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lesson;

@interface Sentence : NSManagedObject

@property (nonatomic, retain) NSNumber * beginTime;
@property (nonatomic, retain) NSNumber * endTime;
@property (nonatomic, retain) NSString * textContent;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) Lesson *witchOfLesson;

@end
