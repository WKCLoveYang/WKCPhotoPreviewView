//
//  WKCPhotoPreviewView.m
//  BBC
//
//  Created by wkcloveYang on 2019/8/27.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import "WKCPhotoPreviewView.h"

@interface WKCPhotoPreviewView()
<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation WKCPhotoPreviewView

@synthesize image = _image;

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.imageView.frame = self.bounds;
        [self addSubview:self.imageView];
        
        self.delegate = self;
        self.maximumZoomScale = 3.0;
        self.minimumZoomScale = 0.95;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = UIColor.blackColor;
        
        _shouldCropOut = YES;
    }
    return self;
}


#pragma mark -Lazy
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

#pragma mark - Setter、Getter
- (void)setImage:(UIImage *)image
{
    _image = image;
    if (self.contentMode == UIViewContentModeScaleAspectFill) {
        CGFloat scale = 0.0;
        if (image.size.height / image.size.width > self.frame.size.height / self.frame.size.width) {
           CGFloat width = self.frame.size.height * (image.size.width / image.size.height);
            scale = self.frame.size.width / width;
        } else {
           CGFloat height = self.frame.size.width * (image.size.height / image.size.width);
            scale = self.frame.size.height / height;
        }
        self.zoomScale = scale;
    } else {
        self.zoomScale = 1.0;
    }
    self.imageView.image = image;
}

- (UIImage *)image
{
    if (_shouldCropOut) {
        return [self cropViewSize:self.bounds.size image:_image];
    }
    
    return _image;
}

- (void)centerScrollViewContents
{
    CGSize boundsSize = self.frame.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    }
    else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    }
    else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

- (void)setMinScale:(CGFloat)minScale
{
    _minScale = minScale;
    self.minimumZoomScale = minScale;
}

- (void)setMaxScale:(CGFloat)maxScale
{
    _maxScale = maxScale;
    self.maximumZoomScale = maxScale;
}

# pragma mark - UIScrollViewDelegate
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerScrollViewContents];
}

- (void)zoomInZoomOut:(CGPoint)point
{
    CGFloat newZoomScale = self.zoomScale > (self.maximumZoomScale/2) ? self.minimumZoomScale :  self.maximumZoomScale;
    
    CGSize scrollViewSize = self.bounds.size;
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = point.x - (w / 2.0f);
    CGFloat y = point.y - (h / 2.0f);
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [self zoomToRect:rectToZoomTo animated:YES];
}

- (UIImage *)cropViewSize:(CGSize)viewSize image:(UIImage *)image
{
    CGSize imageViewSize = self.imageView.frame.size;
    
    CGFloat zoomScale = 0.0;
    CGFloat widthOffset = 0.0;
    CGFloat heightOffset = 0.0;
    
    CGFloat widthScale = _image.size.width / imageViewSize.width;
    CGFloat heightScale = _image.size.height / imageViewSize.height;
    
    if (heightScale > widthScale) {
        zoomScale = imageViewSize.height / _image.size.height;
        widthOffset = (_image.size.width * zoomScale - imageViewSize.width) / 2.0;
    } else {
        zoomScale = imageViewSize.width / _image.size.width;
        heightOffset = (_image.size.height * zoomScale - imageViewSize.height) / 2.0;
    }
    
    CGRect rect = CGRectMake(self.contentOffset.x + widthOffset, self.contentOffset.y + heightOffset, self.frame.size.width, self.frame.size.height);
    rect.size.width  /= zoomScale;
    rect.size.height /= zoomScale;
    rect.origin.x    /= zoomScale;
    rect.origin.y    /= zoomScale;
    
    if (!self.needKeepScale) {
        if (rect.origin.y <= 0) {
            rect.size.height += rect.origin.y;
            rect.size.height = rect.size.height > _image.size.height ? _image.size.height : rect.size.height;
            rect.origin.y = rect.origin.y <= 0 ? 0 : rect.origin.y;
        }
        
        if (rect.origin.x <= 0) {
            rect.size.width += rect.origin.x;
            rect.size.width = rect.size.width > _image.size.width ? _image.size.width : rect.size.width;
            rect.origin.x = rect.origin.x <= 0 ? 0 : rect.origin.x;
        }
    }
    
    CGPoint origin = CGPointMake(-rect.origin.x, -rect.origin.y);
    UIImage *img = nil;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    [image drawAtPoint:origin];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
