//
//  NSManagedObjectContext+Extensions.m
//
//  Created by Wess Cope on 9/23/11.
//  Copyright 2012. All rights reserved.
//

#import "NSManagedObjectContext+Extensions.h"

@implementation NSManagedObjectContext(Extensions)

- (NSManagedObjectModel *)objectModel
{
  return [[self persistentStoreCoordinator] managedObjectModel];
}

#pragma mark - Sync methods
- (NSArray *)ce_fetchObjectsForEntity:(NSString *)entity
{
  return [self ce_fetchObjectsForEntity:entity predicate:nil sortDescriptors:nil];
}

- (NSArray *)ce_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate
{
  return [self ce_fetchObjectsForEntity:entity predicate:predicate sortDescriptors:nil];
}

- (NSArray *)ce_fetchObjectsForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors
{
  return [self ce_fetchObjectsForEntity:entity predicate:nil sortDescriptors:sortDescriptors];
}

- (NSArray *)ce_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors {
  return [self ce_fetchObjectsForEntity:entity predicate:predicate sortDescriptors:sortDescriptors fetchLimit:0];
}

- (NSArray *)ce_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors fetchLimit:(NSUInteger)limit
{
  NSFetchRequest *request = [NSFetchRequest ce_fetchRequestWithEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:self] predicate:predicate sortDescriptors:sortDescriptors];
  if (limit > 0)
    [request setFetchLimit:limit];
  
  NSError *error = nil;
  @try
  {
    NSArray *results = [self executeFetchRequest:request error:&error];
    
    if(error)
    {
      @throw [NSString stringWithFormat:@"CoreData Fetch error: %@", [error userInfo]];
      return nil;
    }
    
    return results;
    
  }
  @catch (NSException *exception)
  {
    NSLog(@"Fetch Exception: %@", [exception description]);
  }
  
  return nil;
}

- (id)ce_fetchObjectForEntity:(NSString *)entity
{
  return [self ce_fetchObjectForEntity:entity predicate:nil sortDescriptors:nil];
}

- (id)ce_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate
{
  return [self ce_fetchObjectForEntity:entity predicate:predicate sortDescriptors:nil];
}

- (id)ce_fetchObjectForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors
{
  return [self ce_fetchObjectForEntity:entity predicate:nil sortDescriptors:sortDescriptors];
}

- (id)ce_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors
{
  NSArray *results = [self ce_fetchObjectsForEntity:entity predicate:predicate sortDescriptors:sortDescriptors];
  if (results.count < 1)
    return nil;
  
  return [results objectAtIndex:0];
}



#pragma mark - Async Methods
- (void)ce_fetchObjectsForEntity:(NSString *)entity callback:(FetchObjectsCallback)callback
{
  [self ce_fetchObjectsForEntity:entity predicate:nil sortDescriptors:nil callback:callback];
}

- (void)ce_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate callback:(FetchObjectsCallback)callback
{
  [self ce_fetchObjectsForEntity:entity predicate:predicate sortDescriptors:nil callback:callback];
}

- (void)ce_fetchObjectsForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectsCallback)callback
{
  [self ce_fetchObjectsForEntity:entity predicate:nil sortDescriptors:sortDescriptors callback:callback];
}

- (void)ce_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectsCallback)callback
{
  NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:self];
  NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntity:entityDescription predicate:predicate sortDescriptors:sortDescriptors];

  [self ce_fetchRequest:request withCallback:callback];
}

- (void)ce_fetchObjectForEntity:(NSString *)entity callback:(FetchObjectCallback)callback
{
  [self ce_fetchObjectForEntity:entity predicate:nil sortDescriptors:nil callback:callback];
}

- (void)ce_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate callback:(FetchObjectCallback)callback
{
  [self ce_fetchObjectForEntity:entity predicate:predicate sortDescriptors:nil callback:callback];
}

- (void)ce_fetchObjectForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectCallback)callback
{
  [self ce_fetchObjectForEntity:entity predicate:nil sortDescriptors:sortDescriptors callback:callback];
}

- (void)ce_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectCallback)callback
{
  [self ce_fetchObjectsForEntity:entity predicate:predicate sortDescriptors:sortDescriptors callback:^(NSArray *objects, NSError *error) {
    id object = nil;

    if (objects.count > 0)
      object = [objects objectAtIndex:0];

    callback(object, error);
  }];
}


- (void)ce_fetchRequest:(NSFetchRequest *)fetchRequest withCallback:(FetchObjectsCallback)callback
{
  NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
  [context setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *objectIds = [NSMutableArray arrayWithCapacity:objects.count];

    [objects ce_each:^(id item) {
      [objectIds addObject:[(NSManagedObject *) item objectID]];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      NSMutableArray *resultObjects = [NSMutableArray arrayWithCapacity:objectIds.count];

      [objectIds ce_each:^(id item) {
        [resultObjects addObject:[self objectWithID:(NSManagedObjectID *) item]];
      }];
      
      callback([NSArray arrayWithArray:resultObjects], error);
    });
  });
}

#pragma mark - Insert New Entity
- (id)ce_insertEntity:(NSString *)entity
{
  return [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:self];
}

- (void)ce_deleteEntity:(NSString *)entity withPredicate:(NSPredicate *)predicate
{
  NSError __block *error = nil;
  NSFetchRequest *fetchRequest = [NSFetchRequest ce_fetchRequestWithEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:self] predicate:predicate];
  
  NSArray *results = [self executeFetchRequest:fetchRequest error:&error];

  [results ce_each:^(id item) {
    NSManagedObject *object = (NSManagedObject *) item;
    if ([object validateForDelete:&error])
      NSLog(@"CoreData Delete error: %@", [error userInfo]);
    else
      [self deleteObject:object];
  }];
  
  [self save:&error];
}


@end
