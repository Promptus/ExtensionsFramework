//
//  UIImageView+Extensions.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/17/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extensions)

#pragma mark Badges

//adds the badge layer with all its sublayers to the imageview (to be called only when the imageview appears on screen "awakeFromNib")
- (void)addBadgeLayer;

//should be used when there are a lot items so that the "flickering effect" won't appear while scrolling
- (void)removeBadgeLayer;

//customizes the badge layer appearence (be sure to call "addVariantBadgeLayer" first)
- (void)customizeBadgeLayerWithText:(NSString *)text
                    backgroundColor:(UIColor *)backgroundColor
                    foregroundColor:(UIColor *)foregroundColor
                 andInitialFontSize:(CGFloat)fontSize;


@end
