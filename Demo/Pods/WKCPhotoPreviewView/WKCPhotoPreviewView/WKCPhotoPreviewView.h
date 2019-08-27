//
//  WKCPhotoPreviewView.h
//  BBC
//
//  Created by wkcloveYang on 2019/8/27.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCPhotoPreviewView : UIScrollView

/**
 是否需要图片与视图比例一样
 保持比例的话, 裁剪出来的图跟imageView比例一样, 空白部分用透明色补充
 不保持比例,空白部分不要
 默认NO
 */
@property (nonatomic, assign) BOOL needKeepScale;

/**
  拖动后,超出部分是否需要裁剪掉.
  NO, 只预览, 不对原图做更改
  YES, 超出部分将会裁剪掉
  默认YES
 */
@property (nonatomic, assign) BOOL shouldCropOut;

/**
  最小比例, 默认0.95
 */
@property (nonatomic, assign) CGFloat minScale;

/**
  最大比例, 默认3.0
 */
@property (nonatomic, assign) CGFloat maxScale;

/**
  内容图片
 */
@property (nonatomic, strong) UIImage * image;

@end

