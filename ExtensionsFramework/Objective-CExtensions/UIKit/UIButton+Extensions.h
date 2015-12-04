//
//  UIButton+Extensions.h
//  ExtensionsFramework
//
//  Created by Lars Kuhnt on 06.03.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIButton (Extensions)

- (void)ce_setBackgroundColor:(UIColor *)color forState:(UIControlState)state;
- (void)ce_addButtonImage:(NSString *)imageName withContentMode:(UIViewContentMode)contentMode andInsets:(UIEdgeInsets)insets;


@end
