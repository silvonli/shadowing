//
//  LessonViewController.m
//  shadowing
//
//  Created by silvon on 12-12-2.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import "LessonViewController.h"
#import "AppDelegate.h"
//#import "stdlib.h"

@interface LessonViewController ()

@end

@implementation LessonViewController

@synthesize lessonsPopover = _lessonsPopover;
@synthesize currenLesson   = _currenLesson;
@synthesize audioPlayer    = _audioPlayer;

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
 
    // 添加句子被选观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(currenLessonSelSentenceDidChange:)
                                                 name:LessonSelSentenceDidChangeNotification
                                               object:nil];
    
       // 显示
    [self lessonViewDisplay];
}

// 重载getter,延迟初始化
- (UIPopoverController *)lessonsPopover
{
    if (_lessonsPopover == nil)
    {
        LessonListTableViewController *listTVCtler = [self.storyboard instantiateViewControllerWithIdentifier:@"list"];
        listTVCtler.selectedLesson = self.currenLesson;
        listTVCtler.delegate  = self;
        
        UINavigationController *nar = [[UINavigationController alloc] initWithRootViewController:listTVCtler];
        _lessonsPopover = [[UIPopoverController alloc] initWithContentViewController:nar];
    }
    return _lessonsPopover;
}

// 重载当前课程setter,
- (void)setCurrenLesson:(Lesson *)len
{
    _currenLesson = len;
    [self.audioPlayer stop];
    self.audioPlayer = [ [AVAudioPlayer alloc] initWithData: self.currenLesson.mp3 error:NULL];
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

-(void)currenLessonSelSentenceDidChange:(NSNotification *) notification
{
    [self.currenLessonView refreshWithArrstring:[self.currenLesson getAttributedString]];
}

- (IBAction)test:(id)sender
{
    int nR = arc4random_uniform(19);
    [self.currenLesson setSelectedSentence:nR];
    
}

- (IBAction)play:(id)sender
{    
    NSMethodSignature *sgt = [ [self.audioPlayer class] instanceMethodSignatureForSelector:@selector(setCurrentTime:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: sgt];
    [invocation setTarget: self.audioPlayer];
    [invocation setSelector:@selector(setCurrentTime:)];
   
    NSNumber *beg = [self.currenLesson getSelectedSentencesBeginTime];
    NSNumber *end = [self.currenLesson getSelectedSentencesEndTime];
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
    
}

- (void) lessonListController:(LessonListTableViewController*)listTVCtler didSelectLensson:(Lesson*)selectedLesson
{
    self.currenLesson = selectedLesson;
    [self.lessonsPopover dismissPopoverAnimated:YES];
    [self lessonViewDisplay];
}

- (void) lessonViewDisplay
{
    NSMutableAttributedString* attString = [self.currenLesson getAttributedString];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LessonSelSentenceDidChangeNotification object:nil];
    [self setCurrenLessonView:nil];
    [self setCurrenLesson:nil];
    [self setLessonsPopover:nil];
    [super viewDidUnload];
}
@end
