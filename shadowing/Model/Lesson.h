//
//  Lesson.h
//  shadowing
//
//  Created by silvon on 12-12-20.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Sentence;

@interface Lesson : NSManagedObject

@property (nonatomic, retain) NSData * mp3;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * translation;
@property (nonatomic, retain) NSData * img;
@property (nonatomic, retain) NSSet *sentences;
@end

@interface Lesson (CoreDataGeneratedAccessors)

- (void)addSentencesObject:(Sentence *)value;
- (void)removeSentencesObject:(Sentence *)value;
- (void)addSentences:(NSSet *)values;
- (void)removeSentences:(NSSet *)values;

- (NSMutableAttributedString *) getAttributedTitle;
- (NSMutableAttributedString *) getAttributedSentences;
- (NSMutableAttributedString *) getAttributedNotes;
- (NSMutableAttributedString *) getAttributedTranslation;
- (NSMutableAttributedString *) getAttributedString;
- (void) setSelectedSentence: (NSInteger) index;
- (NSNumber*)getSelectedSentencesBeginTime;
- (NSNumber*)getSelectedSentencesEndTime;

@end
