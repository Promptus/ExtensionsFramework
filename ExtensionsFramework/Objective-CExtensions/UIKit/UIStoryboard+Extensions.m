//
//  UIStoryboard+Extensions.m
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 19.06.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "UIStoryboard+Extensions.h"

@implementation UIStoryboard (Extensions)

+ (id)ce_instantiateViewControllerWithIdentifier:(NSString *)identifier fromStoryboard:(NSString *)storyboardName {
  UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
  return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

@end
