//
//  AdjustableTextLayer.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/17/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "AdjustableTextLayer.h"
#import "NSString+Extensions.h"

@implementation AdjustableTextLayer

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat height = self.bounds.size.height;
    CGFloat fontSize = self.fontSize;
    CGFloat yDiff = (height - fontSize) / 2 - fontSize / 10;
    
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, 0.0, yDiff);
    [super drawInContext:ctx];
    CGContextRestoreGState(ctx);
}

- (void)setFontSizeWithEnclosingFrame:(CGSize)frameSize startingFrom:(CGFloat)fontSize {    
    self.fontSize = [self.string ce_stringFontSizeInsideSuperviewMargins:CGSizeMake(frameSize.width, frameSize.height) withInitialFontSize:fontSize];
}

@end
