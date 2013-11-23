//
//  GBBlurView.m
//  GBBlurView
//
//  Created by Gerardo Blanco García on 13/11/13.
//  Copyright (c) 2013 Gerardo Blanco García. All rights reserved.
//

#import "GBBlurView.h"

#import "UIImage+ImageEffects.h"

#import <QuartzCore/QuartzCore.h>

CGFloat const GBBlurViewMargin = 16.0f;
CGFloat const GBBlurViewSpacing = 16.0f;

@interface GBBlurView ()

@property (nonatomic) GBBlurViewStyle style;

@property (nonatomic) CGFloat offset;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIImageView *maskedBackgroundView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subtitleLabel;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *blurredBackgroundView;

@end

@implementation GBBlurView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupDefaultValues];
        [self setupSubviews];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(GBBlurViewStyle)style
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupDefaultValues];
        [self setStyle:style];
        [self setupSubviews];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(GBBlurViewStyle)style offset:(CGFloat)offset
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupDefaultValues];
        self.style = style;
        self.offset = offset;
        [self setupSubviews];
    }
    
    return self;
}

#pragma mark - Setup

- (void)setupDefaultValues
{
    self.blurEffect = GBBlurViewBlurEffectLight;
    self.blurEffectMask = GBBlurViewBlurEffectLight;
    self.offset = 0.0f;
    self.tintColor = [UIColor clearColor];
    self.style = GBBlurViewStyleEmpty;
}

- (void)setupSubviews
{
    [self setupBlurredBackgroundView];
    [self setupMaskedBackgroundView];
    [self setupContainerView];
    
    switch (self.style) {
        case GBBlurViewStyleTitle:
            [self setupTitleLabel];
            break;
        case GBBlurViewStyleSubtitle:
            [self setupTitleLabel];
            [self setupSubtitleLabel];
            break;
        case GBBlurViewStyleImage:
            [self setupTitleLabel];
            [self setupSubtitleLabel];
            [self setupImageView];
            break;
        default:
            break;
    }
}

- (void)setupBlurredBackgroundView
{
    if (!self.blurredBackgroundView) {
        self.blurredBackgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.blurredBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.blurredBackgroundView];
        
        NSDictionary *views = @{@"blurredBackgroundView" : self.blurredBackgroundView};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blurredBackgroundView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurredBackgroundView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
    }
}

- (void)setupMaskedBackgroundView
{
    if (!self.maskedBackgroundView) {
        self.maskedBackgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.maskedBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.maskedBackgroundView];
        
        NSDictionary *views = @{@"maskedBackgroundView" : self.maskedBackgroundView};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[maskedBackgroundView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[maskedBackgroundView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
    }
}

- (void)setupContainerView
{
    if (!self.containerView) {
        self.containerView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.containerView];
        
        NSDictionary *views = @{@"containerView" : self.containerView};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
    }
}

- (void)setupTitleLabel
{
    if (!self.titleLabel) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.containerView addSubview:self.titleLabel];
        
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.containerView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0f
                                                                 constant:GBBlurViewMargin];
        
        [self.containerView addConstraint:left];
        
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.containerView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0f
                                                                  constant:GBBlurViewMargin * -1];
        
        [self.containerView addConstraint:right];
        
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.containerView
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.0f
                                                                    constant:self.offset];
        
        [self.containerView addConstraint:centerY];
    }
}

- (void)setupSubtitleLabel
{
    if (!self.subtitleLabel) {
        self.subtitleLabel = [[UILabel alloc] init];
        self.subtitleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
        self.subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.subtitleLabel.numberOfLines = 0;
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.containerView addSubview:self.subtitleLabel];
        
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.titleLabel
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0f
                                                                constant:GBBlurViewSpacing];
        
        [self.containerView addConstraint:top];
        
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.containerView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0f
                                                                 constant:GBBlurViewMargin];
        
        [self.containerView addConstraint:left];
        
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.containerView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0f
                                                                  constant:GBBlurViewMargin * -1];
        
        [self.containerView addConstraint:right];
    }
}

- (void)setupImageView
{
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.containerView addSubview:self.imageView];
        
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.titleLabel
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0f
                                                                    constant:0.0f];
        
        [self.containerView addConstraint:centerX];
        
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.titleLabel
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:GBBlurViewSpacing * -1];
        
        [self.containerView addConstraint:bottom];
        
    }
}

#pragma mark - Public methods

- (void)setTitle:(NSString *)title
{
    if (self.titleLabel) {
        self.titleLabel.text = title;
    }
}

- (void)setSubtitle:(NSString *)subtitle
{
    if (self.subtitleLabel) {
        self.subtitleLabel.text = subtitle;
    }
}

- (void)setTextColor:(UIColor *)color
{
    if (self.titleLabel) {
        self.titleLabel.textColor = color;
    }
    
    if (self.subtitleLabel) {
        self.subtitleLabel.textColor = color;
    }
}

- (void)setImage:(UIImage *)image
{
    if (self.imageView) {
        self.imageView.image = image;
    }
}

- (void)resetPreferredContentSize
{
    self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];;
    self.subtitleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
}

- (void)applyBlurEffectFromView:(UIView *)view
{
    self.blurredBackgroundView.image = [self blurredSnapshotFromView:view withBlurEffect:self.blurEffect];;
    
    if (self.isMasked) {
        self.maskedBackgroundView.image = [self blurredSnapshotFromView:view withBlurEffect:self.blurEffectMask];;

        CALayer *layer = [CALayer layer];
        layer.frame = self.containerView.bounds;
        [layer addSublayer:self.containerView.layer];
        
        self.maskedBackgroundView.layer.masksToBounds = YES;
        self.maskedBackgroundView.layer.mask = layer;
    }
    
    [self.blurredBackgroundView setNeedsDisplay];
}

- (UIImage *)blurredSnapshotFromView:(UIView *)view
{
    return [self blurredSnapshotFromView:view withBlurEffect:self.blurEffect];
}

- (UIImage *)blurredSnapshotFromView:(UIView *)view withBlurEffect:(GBBlurViewBlurEffect)blurEffect
{
    UIImage *blurredSnapshotImage;
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, self.window.screen.scale);
    [view drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    switch (blurEffect) {
        case GBBlurViewBlurEffectLight:
            blurredSnapshotImage = [snapshotImage applyLightEffect];
            break;
        case GBBlurViewBlurEffectExtraLight:
            blurredSnapshotImage = [snapshotImage applyExtraLightEffect];
            break;
        case GBBlurViewBlurEffectDark:
            blurredSnapshotImage = [snapshotImage applyDarkEffect];
            break;
        case GBBlurViewBlurEffectSubtle:
            blurredSnapshotImage = [snapshotImage applySubtleEffect];
            break;
        case GBBlurViewBlurEffectTint:
            blurredSnapshotImage = [snapshotImage applyTintEffectWithColor:self.tintColor];
            break;
    }
    
    UIGraphicsEndImageContext();
    
    return blurredSnapshotImage;
}

@end