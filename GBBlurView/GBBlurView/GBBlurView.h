//
//  GBBlurView.h
//  GBBlurView
//
//  Created by Gerardo Blanco García on 13/11/13.
//  Copyright (c) 2013 Gerardo Blanco García. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

// Blur view styles.
typedef NS_ENUM(NSInteger, GBBlurViewStyle) {
    GBBlurViewStyleEmpty,
    GBBlurViewStyleTitle,
    GBBlurViewStyleSubtitle,
    GBBlurViewStyleImage
};

// Blur effects.
typedef NS_ENUM(NSInteger, GBBlurViewBlurEffect) {
    GBBlurViewBlurEffectLight,
    GBBlurViewBlurEffectExtraLight,
    GBBlurViewBlurEffectDark,
    GBBlurViewBlurEffectSubtle,
    GBBlurViewBlurEffectTint
};

// The GBBlurView class takes advantage of the new iOS 7 snapshot API to create a blur view.
// It is based on Apple sample code from “Implementing Engaging UI on iOS” WWDC 2013 session.

@interface GBBlurView : UIView

// Title to display.
@property (nonatomic, strong) NSString *title;

// Subtitle to display.
@property (nonatomic, strong) NSString *subtitle;

// Text color.
@property (nonatomic, strong) UIColor *textColor;

// Image to display.
@property (nonatomic, strong) UIImage *image;

// Blur effect.
@property (nonatomic) GBBlurViewBlurEffect blurEffect;

// Tint color.
@property (nonatomic, strong) UIColor *tintColor;

// Determines whether is masked.
@property (nonatomic, getter = isMasked) BOOL masked;

// Blur effect mask.
@property (nonatomic) GBBlurViewBlurEffect blurEffectMask;

// Default initializer.
- (id)initWithFrame:(CGRect)frame;

// A convenience initializer that initializes the GBBlurView with the frame and the style.
- (id)initWithFrame:(CGRect)frame style:(GBBlurViewStyle)style;

// Designated initializer that initializes the GBBlurView with the frame, the style and the offset.
- (id)initWithFrame:(CGRect)frame style:(GBBlurViewStyle)style offset:(CGFloat)offset;

// Resets the preferred content size.
- (void)resetPreferredContentSize;

// Applies the blur effect from the view.
- (void)applyBlurEffectFromView:(UIView *)view;

@end