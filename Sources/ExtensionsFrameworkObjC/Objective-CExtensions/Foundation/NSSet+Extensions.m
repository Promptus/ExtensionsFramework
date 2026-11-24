//
//  NSSet+Extensions.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "NSSet+Extensions.h"

@implementation NSSet (Extensions)

+ (NSMutableSet*)ce_setWithEnumerable:(id <NSFastEnumeration>)enumerable creationBlock:(NSObject*(^)(NSDictionary * data))creationBlock {
    NSMutableSet * set = [NSMutableSet set];
    for (NSDictionary * dict in enumerable) {
        NSObject * object = creationBlock(dict);
        if (object)
            [set addObject:object];
    }
    return set;
}

@end
