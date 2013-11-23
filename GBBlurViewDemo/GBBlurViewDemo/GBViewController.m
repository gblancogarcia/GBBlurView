//
//  GBViewController.m
//  GBBlurViewDemo
//
//  Created by Gerardo Blanco García on 14/11/13.
//  Copyright (c) 2013 Gerardo Blanco García. All rights reserved.
//

#import "GBViewController.h"

#import "GBGradientView.h"
#import <GBBlurView/GBBlurView.h>

@interface GBViewController ()

@property (nonatomic, strong) GBGradientView *gradientView;
@property (nonatomic, strong) UIButton *lightButton;
@property (nonatomic, strong) UIButton *extraLightButton;
@property (nonatomic, strong) UIButton *darkButton;
@property (nonatomic, strong) UIButton *tintButton;
@property (nonatomic, strong) GBBlurView *lightBlurView;
@property (nonatomic, strong) GBBlurView *extraLightBlurView;
@property (nonatomic, strong) GBBlurView *darkBlurView;
@property (nonatomic, strong) GBBlurView *tintBlurView;

@end

@implementation GBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupSubviews
{
    [self setupGradientView];
    [self setupButtons];
    [self setupLightBlurView];
    [self setupExtraLightBlurView];
    [self setupDarkBlurView];
    [self setupTintBlurView];
}

- (void)setupGradientView
{
    if (!self.gradientView) {
        self.gradientView = [[GBGradientView alloc] initWithFrame:self.view.bounds];
        
        UIColor *highColor = [UIColor colorWithRed:25/255.0f green:168/255.0f blue:217/255.0f alpha:1.0f];
        UIColor *lowColor = [UIColor colorWithRed:153/255.0f green:238/255.0f blue:174/255.0f alpha:1.0f];
        
        self.gradientView.layer.colors = @[(__bridge id)highColor.CGColor, (__bridge id)lowColor.CGColor];
        self.gradientView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:self.gradientView];
    }
}

- (void)setupButtons
{
    if (!self.lightButton) {
        self.lightButton = [[UIButton alloc] init];
        
        NSString *title = [NSString stringWithFormat:NSLocalizedString(@"Light Button", nil)];
        [self.lightButton setTitle:title forState:UIControlStateNormal];
        [self.lightButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.view addSubview:self.lightButton];
        
        [self.lightButton addTarget:self
                             action:@selector(showLightBlurView)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!self.extraLightButton) {
        self.extraLightButton = [[UIButton alloc] init];
        
        NSString *title = [NSString stringWithFormat:NSLocalizedString(@"Extra Light Button", nil)];
        [self.extraLightButton setTitle:title forState:UIControlStateNormal];
        [self.extraLightButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.view addSubview:self.extraLightButton];
        
        [self.extraLightButton addTarget:self
                                  action:@selector(showExtraLightBlurView)
                        forControlEvents:UIControlEventTouchUpInside];
    }

    if (!self.darkButton) {
        self.darkButton = [[UIButton alloc] init];
        
        NSString *title = [NSString stringWithFormat:NSLocalizedString(@"Dark Button", nil)];
        [self.darkButton setTitle:title forState:UIControlStateNormal];
        [self.darkButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.view addSubview:self.darkButton];
        
        [self.darkButton addTarget:self
                            action:@selector(showDarkBlurView)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!self.tintButton) {
        self.tintButton = [[UIButton alloc] init];
        
        NSString *title = [NSString stringWithFormat:NSLocalizedString(@"Tint Button", nil)];
        [self.tintButton setTitle:title forState:UIControlStateNormal];        
        [self.tintButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.view addSubview:self.tintButton];
        
        [self.tintButton addTarget:self
                            action:@selector(showTintBlurView)
                  forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setupLightBlurView
{
    if (!self.lightBlurView) {
        self.lightBlurView = [[GBBlurView alloc] initWithFrame:self.view.bounds
                                                          style:GBBlurViewStyleImage];
        
        [self.lightBlurView setTitle:[NSString stringWithFormat:NSLocalizedString(@"Title Light", nil)]];
        [self.lightBlurView setSubtitle:[NSString stringWithFormat:NSLocalizedString(@"Subtitle", nil)]];
        [self.lightBlurView setImage:[UIImage imageNamed:@"Info"]];
        
        self.lightBlurView.blurEffect = GBBlurViewBlurEffectLight;
        self.lightBlurView.blurEffectMask = GBBlurViewBlurEffectDark;
        self.lightBlurView.masked = YES;
        
        self.lightBlurView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:self.lightBlurView];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(hideLightBlurView)];
        
        [self.lightBlurView addGestureRecognizer:gestureRecognizer];
        
        self.lightBlurView.hidden = YES;
    }
}

- (void)setupExtraLightBlurView
{
    if (!self.extraLightBlurView) {
        self.extraLightBlurView = [[GBBlurView alloc] initWithFrame:self.view.bounds
                                                         style:GBBlurViewStyleImage];
        
        [self.extraLightBlurView setTitle:[NSString stringWithFormat:NSLocalizedString(@"Title Extra Light", nil)]];
        [self.extraLightBlurView setSubtitle:[NSString stringWithFormat:NSLocalizedString(@"Subtitle", nil)]];
        [self.extraLightBlurView setImage:[UIImage imageNamed:@"Info"]];
        
        self.extraLightBlurView.blurEffect = GBBlurViewBlurEffectExtraLight;
        self.extraLightBlurView.blurEffectMask = GBBlurViewBlurEffectDark;
        self.extraLightBlurView.masked = YES;
        
        self.extraLightBlurView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:self.extraLightBlurView];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(hideExtraLightBlurView)];
        
        [self.extraLightBlurView addGestureRecognizer:gestureRecognizer];
        
        self.extraLightBlurView.hidden = YES;
    }
}

- (void)setupDarkBlurView
{
    if (!self.darkBlurView) {
        self.darkBlurView = [[GBBlurView alloc] initWithFrame:self.view.bounds
                                                        style:GBBlurViewStyleImage];
        
        [self.darkBlurView setTitle:[NSString stringWithFormat:NSLocalizedString(@"Title Dark", nil)]];
        [self.darkBlurView setSubtitle:[NSString stringWithFormat:NSLocalizedString(@"Subtitle", nil)]];
        [self.darkBlurView setImage:[UIImage imageNamed:@"Info"]];
        
        self.darkBlurView.blurEffect = GBBlurViewBlurEffectDark;
        self.darkBlurView.blurEffectMask = GBBlurViewBlurEffectLight;
        self.darkBlurView.masked = YES;
        
        self.darkBlurView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:self.darkBlurView];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(hideDarkBlurView)];
        
        [self.darkBlurView addGestureRecognizer:gestureRecognizer];
        
        self.darkBlurView.hidden = YES;
    }
}

- (void)setupTintBlurView
{
    if (!self.tintBlurView) {
        self.tintBlurView = [[GBBlurView alloc] initWithFrame:self.view.bounds
                                                        style:GBBlurViewStyleImage];
        
        [self.tintBlurView setTitle:[NSString stringWithFormat:NSLocalizedString(@"Title Tint", nil)]];
        [self.tintBlurView setSubtitle:[NSString stringWithFormat:NSLocalizedString(@"Subtitle", nil)]];
        [self.tintBlurView setImage:[UIImage imageNamed:@"Info"]];
        [self.tintBlurView setTintColor:[UIColor colorWithRed:153/255.0f green:238/255.0f blue:174/255.0f alpha:1.0f]];
        
        self.tintBlurView.blurEffect = GBBlurViewBlurEffectTint;
        self.tintBlurView.blurEffectMask = GBBlurViewBlurEffectDark;
        self.tintBlurView.masked = YES;
        
        self.tintBlurView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:self.tintBlurView];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(hideTintBlurView)];
        
        [self.tintBlurView addGestureRecognizer:gestureRecognizer];
        
        self.tintBlurView.hidden = YES;
    }
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    CGFloat offset = 128.0f;
    CGFloat padding = 32.0f;
    
    if (self.view.bounds.size.height < self.view.bounds.size.width) {
        offset = 64.0f;
        padding = 24.0f;
    }
    if (self.view.constraints) {
        [self.view removeConstraints:self.view.constraints];
    }
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    NSDictionary *views = @{@"view" : self.view,
                            @"gradientView" : self.gradientView,
                            @"lightButton" : self.lightButton,
                            @"extraLightButton" : self.extraLightButton,
                            @"darkButton" : self.darkButton,
                            @"tintButton" : self.tintButton,
                            @"lightBlurView" : self.lightBlurView,
                            @"extraLightBlurView" : self.extraLightBlurView,
                            @"darkBlurView" : self.darkBlurView,
                            @"tintBlurView" : self.tintBlurView};
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[gradientView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[gradientView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lightButton]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[extraLightButton]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[darkButton]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tintButton]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lightBlurView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lightBlurView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[extraLightBlurView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[extraLightBlurView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[darkBlurView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[darkBlurView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tintBlurView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tintBlurView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];

    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.lightButton
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1
                                                         constant:0]];

    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.lightButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1
                                                         constant:offset]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.extraLightButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.lightButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1
                                                         constant:padding]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.extraLightButton
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1
                                                         constant:0]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.darkButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.extraLightButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1
                                                         constant:padding]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.darkButton
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1
                                                         constant:0]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.tintButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.darkButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1
                                                         constant:padding]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.tintButton
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1
                                                         constant:0]];
    
    [self.view addConstraints:constraints];
    
    [super updateViewConstraints];
}

- (void)showLightBlurView
{
    [self.lightBlurView applyBlurEffectFromView:self.view];
    self.lightBlurView.hidden = NO;
}

- (void)hideLightBlurView
{
    self.lightBlurView.hidden = YES;
}

- (void)showExtraLightBlurView
{
    [self.extraLightBlurView applyBlurEffectFromView:self.view];
    self.extraLightBlurView.hidden = NO;
}

- (void)hideExtraLightBlurView
{
    self.extraLightBlurView.hidden = YES;
}

- (void)showDarkBlurView
{
    [self.darkBlurView applyBlurEffectFromView:self.view];
    self.darkBlurView.hidden = NO;
}

- (void)hideDarkBlurView
{
    self.darkBlurView.hidden = YES;
}

- (void)showTintBlurView
{
    [self.tintBlurView applyBlurEffectFromView:self.view];
    self.tintBlurView.hidden = NO;
}

- (void)hideTintBlurView
{
    self.tintBlurView.hidden = YES;
}

@end