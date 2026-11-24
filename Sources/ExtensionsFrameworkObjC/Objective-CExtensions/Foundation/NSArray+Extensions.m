//
//  NSArray+Extensions.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "NSArray+Extensions.h"

@implementation NSArray (Extensions)

- (void)ce_each:(void (^)(id item))block {
    NSParameterAssert(block != nil);
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void)ce_eachWithIndex:(void (^)(id item, NSUInteger index))block {
    NSParameterAssert(block != nil);
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}

- (NSArray *)ce_select:(BOOL (^)(id item))block {
    NSParameterAssert(block != nil);
    return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return block(obj);
    }]];
}

- (NSArray *)ce_reject:(BOOL (^)(id item))block {
    return [self ce_select:^BOOL(id obj) {
        return !block(obj);
    }];
}

- (NSArray *)ce_map:(id (^)(id item))block {
    NSParameterAssert(block != nil);
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = block(obj);
        [result addObject:(value ? value : [NSNull null])];
    }];
    return result;
}

@end
