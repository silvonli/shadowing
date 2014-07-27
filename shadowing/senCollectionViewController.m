//
//  SenCollectionViewController.m
//  shadowing
//
//  Created by silvon on 12-12-27.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import "SenCollectionViewController.h"
#import "SenCollectionViewCell.h"

#define THUMB_V_PADDING 10
#define THUMB_H_PADDING 10
#define SENCOLLECTION_VIEW_HEIGHT 55
@interface SenCollectionViewController ()

@end

@implementation SenCollectionViewController

@synthesize delegate = _delegate;
@synthesize currentLesson = _currentLesson;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.contentSizeForViewInPopover = CGSizeMake([UIScreen mainScreen].bounds.size.width, SENCOLLECTION_VIEW_HEIGHT);
    

    
    float xPosition = THUMB_H_PADDING;
    for (Sentence *sen in self.currentLesson.sortedSens)
    {
        
            SenCollectionViewCell *cell = [[SenCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];

            CGRect frame = [cell frame];
            frame.origin.y = THUMB_V_PADDING;
            frame.origin.x = xPosition;
            [cell setFrame:frame];
            //[cell setAlpha:0.75];
            [self.thumbScrollView addSubview:cell];
            xPosition += (frame.size.width + THUMB_H_PADDING);
        
    }
    [self.thumbScrollView setContentSize:CGSizeMake(xPosition, SENCOLLECTION_VIEW_HEIGHT)];
    //[self.thumbScrollView setBackgroundColor:[UIColor grayColor]];
    //[self.view setOpaque:NO];
    //[self.thumbScrollView setAlpha:0.75];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
//
//- (void) setSelectedSentence: (NSInteger) index
//{
//    if (index<0 || index>self.sentences.count-1)
//    {
//        return;
//    }
//
//    Sentence* sen = [self.sortedSens objectAtIndex:index];
//    Sentence* senPre = index > 0 ? [self.sortedSens objectAtIndex:index-1] : nil;
//    Sentence* senNext= index < self.sentences.count-1 ? [self.sortedSens objectAtIndex:index+1] : nil;
//
//    if (sen.bSel.boolValue == YES)
//    {
//        // 前后句子都已被选中，则全取消
//        if (senPre.bSel.boolValue == YES && senNext.bSel.boolValue == YES)
//        {
//            for (Sentence* senTem in self.sortedSens)
//            {
//                senTem.bSel = [NSNumber numberWithBool:NO];
//            }
//        }
//
//        sen.bSel = [NSNumber numberWithBool:NO];
//    }
//    else
//    {
//        // 前后句子都没被选中，则先全取消
//        if (senPre.bSel.boolValue == NO && senNext.bSel.boolValue == NO)
//        {
//            for (Sentence* senTem in self.sortedSens)
//            {
//                senTem.bSel = [NSNumber numberWithBool:NO];
//            }
//        }
//
//        sen.bSel = [NSNumber numberWithBool:YES];
//    }
//}

- (void)viewDidUnload
{
    [self setThumbScrollView:nil];
    [super viewDidUnload];
}
@end
