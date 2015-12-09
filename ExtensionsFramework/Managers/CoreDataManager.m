//
//  CoreDataManager.m
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 05.02.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;
@synthesize persistentStoreName;
@synthesize persistentStoreConfiguration;
@synthesize persistentStoreOptions;

- (id)initWithStoreName:(NSString*)storeName configuartion:(NSString*)configuration options:(NSDictionary*)options {
  if (self = [super init]) {
    persistentStoreName = storeName;
    persistentStoreOptions = options;
    persistentStoreConfiguration = configuration;
  }
  return self;
}

- (id)initWithStoreName:(NSString*)storeName {
  NSDictionary *options = @{
    NSMigratePersistentStoresAutomaticallyOption : @YES,
    NSInferMappingModelAutomaticallyOption : @YES
  };
  return [self initWithStoreName:storeName configuartion:nil options:options];
}

- (void)save {
  NSError *error = nil;
  if (managedObjectContext != nil) {
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
  if (managedObjectContext != nil) {
    return managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
  }
  return managedObjectContext;
}

- (NSManagedObjectContext *)createManagedObjectContext {
  NSManagedObjectContext * context = [[NSManagedObjectContext alloc] init];
  [context setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
  context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
  return context;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
  if (managedObjectModel != nil) {
    return managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:persistentStoreName withExtension:@"momd"];
  managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
  if (persistentStoreCoordinator != nil) {
    return persistentStoreCoordinator;
  }
  
  NSURL *storeURL = [[self class] storePath:persistentStoreName];
  
  persistentStoreCoordinator = [self createPersistentStoreCoordinator:storeURL];
  
  return persistentStoreCoordinator;
}

- (NSPersistentStoreCoordinator *)createPersistentStoreCoordinator:(NSURL*)storeURL {
  @throw @"Use a subclass";
}

+ (NSURL*)storePath:(NSString*)name {
  NSString * applicationSupportDirectory = [[NSFileManager defaultManager] ce_applicationSupportDirectory];
  NSURL * applicationSupportDirectoryURL = [NSURL fileURLWithPath:applicationSupportDirectory];
  return [applicationSupportDirectoryURL URLByAppendingPathComponent:[name stringByAppendingString:@".sqlite"]];
}

@end
