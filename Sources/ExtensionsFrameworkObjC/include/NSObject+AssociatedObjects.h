//
//  NSObject+AssociatedObjects.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/17/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociatedObjects)

- (void)associateValue:(id)value withKey:(void *)key;
- (id)associatedValueForKey:(void *)key;

@end
