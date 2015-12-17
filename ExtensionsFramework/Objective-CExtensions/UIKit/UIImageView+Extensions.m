//
//  UIImageView+Extensions.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 12/17/15.
//  Copyright © 2015 Razvan Benga. All rights reserved.
//

#import "UIImageView+Extensions.h"
#import "AdjustableTextLayer.h"
#import "NSObject+AssociatedObjects.h"

@interface UIImageView ()

@property (strong, nonatomic) AdjustableTextLayer *textLayer;

@end

@implementation UIImageView (Extensions)

- (void)addBadgeLayer {
    
    float min = MIN(self.bounds.size.width, self.bounds.size.height);
    
    //Adjust the size of the drawing by tempering with the "1.5" value
    CGFloat squareSide = min / ((min / 200) + 1.5);
    
    CALayer *squareLayer = [CALayer layer];
    squareLayer.frame = CGRectMake(self.bounds.origin.x,
                                   self.bounds.origin.y,
                                   squareSide,
                                   squareSide);
    squareLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    self.textLayer = [AdjustableTextLayer layer];
    self.textLayer.contentsScale = [[UIScreen mainScreen] scale];
    self.textLayer.frame = CGRectMake(squareLayer.bounds.origin.x - 15,
                                      squareLayer.bounds.origin.y + 10,
                                      squareLayer.bounds.size.width + 30,
                                      squareLayer.bounds.size.height / 3);
    
    self.textLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.textLayer.alignmentMode = kCAAlignmentCenter;
    [self.textLayer setFontSizeWithEnclosingFrame:CGSizeMake(self.textLayer.frame.size.width - 28, self.textLayer.frame.size.height) startingFrom:16];
    
    [squareLayer addSublayer:self.textLayer];
    squareLayer.transform = CATransform3DMakeRotation((45.0 / 180.0 * -M_PI), 0.0, 0.0, 1.0);
    
    [self.layer addSublayer:squareLayer];
    
}

- (void)customizeBadgeLayerWithText:(NSString *)text
                    backgroundColor:(UIColor *)backgroundColor
                    foregroundColor:(UIColor *)foregroundColor
                 andInitialFontSize:(CGFloat)fontSize {
    
    if (self.textLayer) {
        self.textLayer.string = text;
        self.textLayer.backgroundColor = backgroundColor.CGColor;
        self.textLayer.foregroundColor = foregroundColor.CGColor;
        [self.textLayer setFontSizeWithEnclosingFrame:CGSizeMake(self.textLayer.frame.size.width - 28, self.textLayer.frame.size.height)                     startingFrom:fontSize];
    }
    
}

- (void)setTextLayer:(AdjustableTextLayer *)textLayer {
    [self associateValue:textLayer withKey:@selector(textLayer)];
}

- (AdjustableTextLayer *)textLayer {
    return [self associatedValueForKey:@selector(textLayer)];
}


@end
