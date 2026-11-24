//
//  AdjustableTextLayer.h
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/17/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface AdjustableTextLayer : CATextLayer

- (void)setFontSizeWithEnclosingFrame:(CGSize)frameSize startingFrom:(CGFloat)fontSize;

@end
