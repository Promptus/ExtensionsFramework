//
//  NSManagedObject+Extensions.h
//  kemmler
//
//  Created by Lars Kuhnt on 28.10.13.
//  Copyright (c) 2013 Coeus Solutions GmbH. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NSManagedObjectContext+Extensions.h"

@interface NSManagedObject (Extensions)

+ (instancetype)ce_create:(NSManagedObjectContext*)context;
+ (instancetype)ce_create:(NSDictionary *)dict inContext:(NSManagedObjectContext*)context;
+ (instancetype)ce_find:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (instancetype)ce_find:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context;
+ (NSArray*)ce_all:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (NSArray*)ce_all:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context;
+ (NSUInteger)ce_count:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)contex;
+ (NSString *)ce_entityName;
+ (NSError*)ce_deleteAll:(NSManagedObjectContext*)context;

@end
