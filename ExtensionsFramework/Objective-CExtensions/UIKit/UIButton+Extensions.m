//
//  UIButton+Extensions.m
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 06.03.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "UIButton+Extensions.h"

@implementation UIButton (Extensions)

- (void)ce_setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
  UIView *colorView = [[UIView alloc] initWithFrame:self.frame];
  colorView.backgroundColor = color;
  
  UIGraphicsBeginImageContext(colorView.bounds.size);
  [colorView.layer renderInContext:UIGraphicsGetCurrentContext()];
  
  UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  [self setBackgroundImage:colorImage forState:state];
}

- (void)ce_addButtonImage:(NSString *)imageName withContentMode:(UIViewContentMode)contentMode andInsets:(UIEdgeInsets)insets {
    self.imageView.contentMode = contentMode;
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.imageEdgeInsets = insets;
}


@end
