//
//  NSObject+AssociatedObjects.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/17/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "NSObject+AssociatedObjects.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObjects)

- (void)associateValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (id)associatedValueForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

@end
