//
//  UINavigationBar+Aha.m
//  AhaNavigationBar
//
//  Created by haiwei on 16/1/17.
//  Copyright © 2016年 vvli. All rights reserved.
//

#import "UINavigationBar+Aha.h"
#import <objc/runtime.h>


@interface UINavigationBar ()

@property (nonatomic, strong) UIView *ahaOverlayView;

@end


@implementation UINavigationBar (Aha)


- (void)aha_setBackgroundColor:(UIColor *)backgroundColor {
    
    if (!self.ahaOverlayView) {
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        self.ahaOverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.ahaOverlayView.userInteractionEnabled = NO;
        self.ahaOverlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.ahaOverlayView atIndex:0];
    }
    self.ahaOverlayView.backgroundColor = backgroundColor;
}

- (void)aha_setTranslationY:(CGFloat)translationY {
    
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)aha_setElementsAlpha:(CGFloat)alpha {
    
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)aha_reset {
    
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.ahaOverlayView removeFromSuperview];
    self.ahaOverlayView = nil;
}


#pragma mark - getters

- (UIView *)ahaOverlayView {
    return objc_getAssociatedObject(self, @selector(ahaOverlayView));
}

- (void)setAhaOverlayView:(UIView *)ahaOverlayView {
    objc_setAssociatedObject(self, @selector(ahaOverlayView), ahaOverlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
