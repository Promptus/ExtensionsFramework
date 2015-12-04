//
//  UIStoryboard+Extensions.h
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 19.06.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Extensions)

+ (id)ce_instantiateViewControllerWithIdentifier:(NSString *)identifier fromStoryboard:(NSString*)storyboardName;

@end
