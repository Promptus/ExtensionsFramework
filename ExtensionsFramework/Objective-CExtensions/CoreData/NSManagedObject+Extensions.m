//
//  NSManagedObject+Extensions.m
//  kemmler
//
//  Created by Lars Kuhnt on 28.10.13.
//  Copyright (c) 2013 Coeus Solutions GmbH. All rights reserved.
//

#import "NSManagedObject+Extensions.h"

@implementation NSManagedObject (Extensions)

+ (instancetype)ce_create:(NSManagedObjectContext*)context {
  return [NSEntityDescription insertNewObjectForEntityForName:[self ce_entityName] inManagedObjectContext:context];
}

+ (instancetype)ce_create:(NSDictionary *)dict inContext:(NSManagedObjectContext*)context {
  id instance = [self ce_create:context];
  [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [instance setValue:obj forKey:key];
  }];
  return instance;
}

+ (instancetype)ce_find:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
  return [context ce_fetchObjectForEntity:[self ce_entityName] predicate:predicate];
}

+ (instancetype)ce_find:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context {
  return [context ce_fetchObjectForEntity:[self ce_entityName] predicate:predicate sortDescriptors:sortDescriptors];
}

+ (NSArray*)ce_all:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
  return [context ce_fetchObjectsForEntity:[self ce_entityName] predicate:predicate];
}

+ (NSArray *)ce_all:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context {
  return [context ce_fetchObjectsForEntity:[self ce_entityName] predicate:predicate sortDescriptors:sortDescriptors];
}

+ (NSUInteger)ce_count:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:[self ce_entityName] inManagedObjectContext:context];
  [request setPredicate:predicate];
  [request setEntity:entity];
  NSError *error = nil;
  return [context countForFetchRequest:request error:&error];
}

+ (NSString *)ce_entityName {
  return [NSString stringWithCString:object_getClassName(self) encoding:NSASCIIStringEncoding];
}

+ (NSError*)ce_deleteAll:(NSManagedObjectContext*)context {
  NSFetchRequest * req = [[NSFetchRequest alloc] init];
  [req setEntity:[NSEntityDescription entityForName:[self ce_entityName] inManagedObjectContext:context]];
  [req setIncludesPropertyValues:NO]; //only fetch the managedObjectID

  NSError * error = nil;
  NSArray * objects = [context executeFetchRequest:req error:&error];
  //error handling goes here
  for (NSManagedObject * obj in objects) {
    [context deleteObject:obj];
  }
  NSError *saveError = nil;
  [context save:&saveError];
  return error;
}

@end
