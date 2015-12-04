// UIImage+Extensions.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

#import <UIKit/UIKit.h>

// Helper methods for adding an alpha layer to an image
@interface UIImage (Extensions)

#pragma mark Alpha

- (BOOL)ce_hasAlpha;
- (UIImage *)ce_imageWithAlpha;
- (UIImage *)ce_transparentBorderImage:(NSUInteger)borderSize;

#pragma mark Resize

- (UIImage *)ce_croppedImage:(CGRect)bounds;
- (UIImage *)ce_thumbnailImage:(NSInteger)thumbnailSize
             transparentBorder:(NSUInteger)borderSize
                  cornerRadius:(NSUInteger)cornerRadius
          interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)ce_resizedImage:(CGSize)newSize
        interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)ce_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                     bounds:(CGSize)bounds
                       interpolationQuality:(CGInterpolationQuality)quality;

#pragma mark RoundedCorner

- (UIImage *)ce_roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

- (BOOL)ce_isLandscape;

- (UIImage *)ce_tintedImageWithColor:(UIColor *)tintColor;

+ (UIImage *)ce_imageWithColor:(UIColor *)color andSize:(CGSize) size;

@end
