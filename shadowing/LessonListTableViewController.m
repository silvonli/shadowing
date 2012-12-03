//
//  LessonListTableViewController.m
//  shadowing
//
//  Created by silvon on 12-11-23.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import "LessonListTableViewController.h"

#import "AppDelegate.h"
@interface LessonListTableViewController ()

@end

@implementation LessonListTableViewController

@synthesize delegate = _delegate;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize lessonsArray = _lessonsArray;
@synthesize selLesson = _selLesson;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"跟读材料";
}

- (NSManagedObjectContext*) managedObjectContext
{
    if (_managedObjectContext == nil)
    {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        _managedObjectContext = appDelegate.managedObjectContext;
    }
     return _managedObjectContext;
}

- (NSArray *) lessonsArray
{
    if (_lessonsArray == nil)
    {
        NSFetchRequest *fetchRequest = [[ NSFetchRequest alloc] init];
        NSEntityDescription *entity  = [NSEntityDescription entityForName:@"Lesson"
                                                   inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        _lessonsArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    }
    
    return _lessonsArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.lessonsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    Lesson *len = [self.lessonsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d: %@", indexPath.row+1, len.title];
    
    if ([self.selLesson isEqual:len])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    self.selLesson = [self.lessonsArray objectAtIndex:indexPath.row];
    [self.delegate didSelectLenssonInLessonList:self];
}

@end
