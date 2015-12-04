//
//  UIView+Extensions.h
//  BonusCards
//
//  Created by Simon Brückner on 07.06.13.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)
  @property (nonatomic, assign) CGPoint topLeft;
  @property (nonatomic, assign) CGPoint topCenter;
  @property (nonatomic, assign) CGPoint topRight;
  @property (nonatomic, assign) CGPoint middleLeft;
  @property (nonatomic, assign) CGPoint middleRight;
  @property (nonatomic, assign) CGPoint bottomLeft;
  @property (nonatomic, assign) CGPoint bottomCenter;
  @property (nonatomic, assign) CGPoint bottomRight;
  @property (nonatomic, assign) CGFloat height;
  @property (nonatomic, assign) CGFloat width;

-(void)ce_shiftX:(float) offset;
-(void)ce_shiftY:(float) offset;

@end
