//
//  NSSet+Extensions.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/4/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (Extensions)

+ (NSMutableSet*)ce_setWithEnumerable:(id <NSFastEnumeration>)enumerable creationBlock:(NSObject*(^)(NSDictionary * data))creationBlock;

@end
