//
//  NSManagedObjectContext+Extensions.h
//
//  Created by Wess Cope on 9/23/11.
//  Copyright 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSFetchRequest+Extensions.h"
#import "NSArray+Extensions.h"

typedef void (^ContextCallback)(NSManagedObjectContext *context);
typedef void (^ContextObjectCallback)(NSManagedObjectContext *context, id object);
typedef void (^ContextObjectsCallback)(NSManagedObjectContext *context, NSArray *objects);


@interface NSManagedObjectContext(Extensions)

#pragma mark - Conveince Property
@property (nonatomic, readonly) NSManagedObjectModel *objectModel;

#pragma mark - Sync methods
- (NSArray *)ce_fetchObjectsForEntity:(NSString *)entity;
- (NSArray *)ce_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate;
- (NSArray *)ce_fetchObjectsForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors;
- (NSArray *)ce_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
- (NSArray *)ce_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors fetchLimit:(NSUInteger)limit;
- (id)ce_fetchObjectForEntity:(NSString *)entity;
- (id)ce_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate;
- (id)ce_fetchObjectForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors;
- (id)ce_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;

#pragma mark - Async Methods
- (void)ce_fetchObjectsForEntity:(NSString *)entity callback:(FetchObjectsCallback)callback;
- (void)ce_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate callback:(FetchObjectsCallback)callback;
- (void)ce_fetchObjectsForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectsCallback)callback;
- (void)ce_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectsCallback)callback;

- (void)ce_fetchObjectForEntity:(NSString *)entity callback:(FetchObjectCallback)callback;
- (void)ce_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate callback:(FetchObjectCallback)callback;
- (void)ce_fetchObjectForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectCallback)callback;
- (void)ce_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectCallback)callback;

- (void)ce_fetchRequest:(NSFetchRequest *)fetchRequest withCallback:(FetchObjectsCallback)callback;

#pragma mark - Insert New Entity
- (id)ce_insertEntity:(NSString *)entity;
- (void)ce_deleteEntity:(NSString *)entity withPredicate:(NSPredicate *)predicate;
@end