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

@synthesize lessonsPopover = _lessonsPopover;
@synthesize currenLesson   = _currenLesson;

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
   
    NSFetchRequest *fetchRequest = [[ NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Lesson" inManagedObjectContext: appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray * arrLensons = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    self.currenLesson = [arrLensons objectAtIndex:0];
    
    [self textLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lessonsListButton:(id)sender
{
    LessonListTableViewController *listTVCtler = [self.storyboard instantiateViewControllerWithIdentifier:@"list"];
    listTVCtler.contentSizeForViewInPopover = CGSizeMake(200, 400);
    listTVCtler.selLesson = self.currenLesson;
    listTVCtler.delegate  = self;
    
    self.lessonsPopover = [[UIPopoverController alloc] initWithContentViewController:listTVCtler];
    [self.lessonsPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void) didSelectLensson
{
    [self.lessonsPopover dismissPopoverAnimated:YES];
    self.currenLesson = [(LessonListTableViewController*)self.lessonsPopover.contentViewController selLesson];
    [self textLayout];
}

- (void) textLayout
{
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] init];
    // 句子按时间排序
    NSSortDescriptor *titleSort = [NSSortDescriptor sortDescriptorWithKey:@"beginTime" ascending:YES];
    NSArray *sortedSens = [self.currenLesson.sentences sortedArrayUsingDescriptors:[NSArray arrayWithObject:titleSort]];
    // 取句子文本内容
    for (Sentence* sen in sortedSens)
    {
        NSAttributedString *sub = [[NSAttributedString alloc] initWithString:sen.textContent];
        [attString appendAttributedString:sub];
    }
    
    self.currenLessonView.attString = attString;
    
    [self.currenLessonView setNeedsDisplay];
}
- (void)viewDidUnload
{
    [self setCurrenLessonView:nil];
    [self setCurrenLesson:nil];
    [self setLessonsPopover:nil];
    [super viewDidUnload];
}
@end
