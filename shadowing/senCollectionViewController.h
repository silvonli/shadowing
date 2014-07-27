//
//  SenCollectionViewController.h
//  shadowing
//
//  Created by silvon on 12-12-27.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/Sentence.h"
#import "Model/Lesson.h"
@class SenCollectionViewController;

@protocol SenCollectionViewControllerDelegate <NSObject>
- (void) senCollectionViewController:(SenCollectionViewController*)svc didSelectSentence:(NSArray*)selectedSens;
@end

@interface SenCollectionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *thumbScrollView;

@property(nonatomic, weak) id<SenCollectionViewControllerDelegate> delegate;

@property(nonatomic, strong) Lesson* currentLesson;
@end
