//
//  AppDelegate.m
//  shadowing
//
//  Created by silvon on 12-11-23.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import "AppDelegate.h"
#import "Sentence.h"
#import "Lesson.h"
#import "LessonListTableViewController.h"
@implementation AppDelegate

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //[self createDataFile];

    LessonListTableViewController *lessonListView = (LessonListTableViewController*)self.window.rootViewController;
    lessonListView.managedObjectContext = self.managedObjectContext;
    return YES;
}
	

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
	
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [NSManagedObjectContext new];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel
{
	
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *storePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
                           stringByAppendingPathComponent: @"data.sqlite3"];
    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
    
    // Put down default db if it doesn't already exist
    if (![fileManager fileExistsAtPath:storePath])
    {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite3"];
        if (defaultStorePath)
        {
            [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
        }
    }
    
	NSError *error;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error])
    {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
    
    return _persistentStoreCoordinator;
}
- (void) createDataFile
{
    NSError *error;
    NSURL* sqliteURL= [NSURL fileURLWithPath:@"/Users/sumomoxiaowen/Dev/MyCode/shadowing/shadowing/data.sqlite3"];
  
    NSManagedObjectModel * ModelTem = [self managedObjectModel];
    
    NSPersistentStoreCoordinator *coordinatorTem = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: ModelTem];
    [coordinatorTem addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteURL options:nil error:&error];
    
    NSManagedObjectContext *contextTem = [NSManagedObjectContext new];
    [contextTem setPersistentStoreCoordinator: coordinatorTem];
   
   
    
    Lesson *len = [NSEntityDescription insertNewObjectForEntityForName:@"Lesson" inManagedObjectContext:contextTem];
    len.title   = @"lenson one";
    len.order   = [NSNumber numberWithInt:1];
    
    Sentence *sen = [NSEntityDescription insertNewObjectForEntityForName:@"Sentence" inManagedObjectContext:contextTem];
    sen.beginTime = [NSNumber numberWithFloat:0];
    sen.endTime   = [NSNumber numberWithFloat:10];
    sen.order     = [NSNumber numberWithInt:1];
    sen.textContent   = @"fucking ";
    sen.witchOfLesson = len;
    
    len.sentences = [NSSet setWithObjects: sen, nil];
 
    if (![contextTem save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

}

@end
