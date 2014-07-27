//
//  LessonViewController.m
//  shadowing
//
//  Created by silvon on 12-12-2.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import "LessonViewController.h"
#import "AppDelegate.h"

@interface LessonViewController ()

@end

@implementation LessonViewController

@synthesize lessonsPopover  = _lessonsPopover;
@synthesize sentencesPopover= _sentencesPopover;
@synthesize currenLesson    = _currenLesson;
@synthesize audioPlayer     = _audioPlayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // 当前课 初始化
    NSFetchRequest *fetchRequest = [[ NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Lesson" inManagedObjectContext: appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray * lensons = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    self.currenLesson = [lensons objectAtIndex:0];
 
    // 显示
    [self lessonViewDisplay];
}

// 课文列表getter,延迟初始化
- (UIPopoverController *)lessonsPopover
{
    if (_lessonsPopover == nil)
    {
        LessonListTableViewController *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"list"];
        lvc.selectedLesson = self.currenLesson;
        lvc.delegate  = self;
        
        UINavigationController *nar = [[UINavigationController alloc] initWithRootViewController:lvc];
        _lessonsPopover = [[UIPopoverController alloc] initWithContentViewController:nar];
    }
    return _lessonsPopover;
}

// 句子列表getter,延迟初始化
- (UIPopoverController *) sentencesPopover
{
    SenCollectionViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"sentenceCollection"];
    svc.currentLesson = self.currenLesson;
    svc.delegate  = self;
    _sentencesPopover = [[UIPopoverController alloc] initWithContentViewController:svc];

    return _sentencesPopover;
}

// 当前课程setter,
- (void)setCurrenLesson:(Lesson *)len
{
    _currenLesson = len;
    
    // 设置stepper
    self.sentenceStepper.minimumValue = 0;
    self.sentenceStepper.maximumValue = _currenLesson.sentences.count;
    self.sentenceStepper.wraps = YES;
 
    // 设置播放器
    [self.audioPlayer stop];
    self.audioPlayer = [ [AVAudioPlayer alloc] initWithData: _currenLesson.mp3 error:NULL];
    [self.audioPlayer prepareToPlay];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lessonsListButton:(id)sender
{
    [self.lessonsPopover dismissPopoverAnimated:NO];
    [self.lessonsPopover presentPopoverFromBarButtonItem:sender
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                         animated:YES];
}

- (IBAction)sentenceChange:(id)sender
{
    int nR = self.sentenceStepper.value-1;
    NSMethodSignature *sgt = [ [self.audioPlayer class] instanceMethodSignatureForSelector:@selector(setCurrentTime:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: sgt];
    [invocation setTarget: self.audioPlayer];
    [invocation setSelector:@selector(setCurrentTime:)];
    
    NSNumber *beg = [self.currenLesson getSelectedSentencesBeginTime:nR];
    NSNumber *end = [self.currenLesson getSelectedSentencesEndTime:nR];
    NSTimeInterval argument = [beg floatValue];
    [invocation setArgument:&argument atIndex:2];
    
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval: [end floatValue]-[beg floatValue]
                                          invocation: invocation
                                             repeats: YES];
    [_timer fire];
    if (self.audioPlayer.playing == NO)
    {
        [self.audioPlayer play];
    }
    
    // 刷新显示
    if (nR<0 || nR>self.currenLesson.sortedSens.count-1)
    {
        [self.currenLessonView refreshWithArrstring:[self.currenLesson getAttributedStringWithSelSens:nil]];
    }
    else
    {
        NSArray *selSens = [NSArray arrayWithObject:[self.currenLesson.sortedSens objectAtIndex:nR]];
        [self.currenLessonView refreshWithArrstring:[self.currenLesson getAttributedStringWithSelSens:selSens]];
    }
    
}

- (IBAction)play:(id)sender
{
    //int nR = arc4random_uniform(19);
    //[self.currenLesson setSelectedSentence:nR];
}

- (IBAction)test:(id)sender
{ 
    [self.sentencesPopover dismissPopoverAnimated:NO];
    [self.sentencesPopover presentPopoverFromBarButtonItem:sender
                            permittedArrowDirections:UIPopoverArrowDirectionAny
                                            animated:YES];
}

- (void) lessonListController:(LessonListTableViewController*)lvc didSelectLensson:(Lesson*)selectedLesson
{
    self.currenLesson = selectedLesson;
    [self.lessonsPopover dismissPopoverAnimated:YES];
    [self lessonViewDisplay];
}

- (void) senCollectionViewController:(SenCollectionViewController*)svc didSelectSentence:(NSArray*)selectedSens
{
    // 刷新显示
   [self.currenLessonView refreshWithArrstring:[self.currenLesson getAttributedStringWithSelSens:selectedSens]];
}

- (void) lessonViewDisplay
{
    NSMutableAttributedString* attString = [self.currenLesson getAttributedStringWithSelSens:nil];
    UIImage *img = [UIImage imageWithData:self.currenLesson.img];
    
    [self.currenLessonView refreshWithArrstring:attString andImage:img];
 }

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait ||
           toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
}

- (void)viewDidUnload
{
    [self setCurrenLessonView:nil];
    [self setCurrenLesson:nil];
    [self setLessonsPopover:nil];
    [self setSentenceStepper:nil];
    [super viewDidUnload];
}
@end
