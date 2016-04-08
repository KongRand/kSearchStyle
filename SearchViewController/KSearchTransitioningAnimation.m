//
//  kSearchTransitioningAnimation.m
//  kSearchStyle
//
//  Created by Kong on 16/4/7.
//  Copyright © 2016年 ;. All rights reserved.
//

#import "KSearchTransitioningAnimation.h"
#import "SearchView.h"

@interface KSearchTransitioningAnimation()

@property (nonatomic, strong) SearchView *searchView;

@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation KSearchTransitioningAnimation


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitioningDuration?self.transitioningDuration:0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresent) {
        [self presentViewControllerWithTransitionContext:transitionContext];
    }else{
        [self dismissViewControllerWithTransitionContext:transitionContext];
    }
}


- (void)presentViewControllerWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView                = [transitionContext containerView];
    [containerView addSubview:toViewController.view];
    
    __weak typeof(self) weakSelf = self;
    [toViewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[SearchView class]]) {
            weakSelf.searchView = obj;
        }
    }];
    [fromViewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            weakSelf.searchButton = obj;
        }
    }];
    /**
     *  ShapeLayer Path Use BezierPath
     */
    CGFloat searchButtonWidth    = self.searchButton.frame.size.width;
    CGFloat searchButtonHeight   = self.searchButton.frame.size.height;
    CGFloat dValueButtonWH       = searchButtonWidth - searchButtonHeight/2;
    CGRect centerRect = CGRectMake(dValueButtonWH, self.searchButton.frame.origin.y, searchButtonHeight, searchButtonHeight);
    
    UIBezierPath *fromBezierPath = [UIBezierPath bezierPathWithOvalInRect:centerRect];
    
    CGFloat radiusWidth = [UIScreen mainScreen].bounds.size.width - dValueButtonWH;
    CGFloat radiusHeight = self.searchButton.frame.origin.y + searchButtonHeight/2;
    CGFloat radius = sqrt(radiusWidth * radiusWidth + radiusHeight * radiusWidth);
    UIBezierPath *toBezierPath   = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(centerRect, -radius, -radius)];
    
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.path          = toBezierPath.CGPath;
    self.searchView.layer.mask = shaperLayer;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.fromValue         = (__bridge id _Nullable)(fromBezierPath.CGPath);
    basicAnimation.toValue           = (__bridge id _Nullable)(toBezierPath.CGPath);
    basicAnimation.duration          = [self transitionDuration:transitionContext];
    [shaperLayer addAnimation:basicAnimation forKey:@"presentpath"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([self transitionDuration:transitionContext] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    });
}

- (void)dismissViewControllerWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [fromViewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[SearchView class]]) {
            weakSelf.searchView = obj;
        }
    }];
    [toViewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
        if ([obj isKindOfClass:[UIButton class]]) {
            weakSelf.searchButton = obj;
        }
    }];
    /**
     *  ShapeLayer Path Use BezierPath
     */
    CGFloat searchButtonWidth    = self.searchButton.frame.size.width;
    CGFloat searchButtonHeight   = self.searchButton.frame.size.height;
    CGFloat dValueButtonWH       = searchButtonWidth - searchButtonHeight/2;
    CGRect centerRect = CGRectMake(searchButtonWidth - searchButtonHeight, self.searchButton.frame.origin.y, searchButtonHeight, searchButtonHeight);
    
    UIBezierPath *fromBezierPath = [UIBezierPath bezierPathWithOvalInRect:centerRect];
    
    CGFloat radiusWidth = [UIScreen mainScreen].bounds.size.width - dValueButtonWH;
    CGFloat radiusHeight = self.searchButton.frame.origin.y + searchButtonHeight/2;
    CGFloat radius = sqrt(radiusWidth * radiusWidth + radiusHeight * radiusWidth);
    UIBezierPath *toBezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(centerRect, -radius, -radius)];

    CAShapeLayer *shapeLayer   = [CAShapeLayer layer];
    shapeLayer.path            = fromBezierPath.CGPath;
    self.searchView.layer.mask = shapeLayer;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.fromValue   =  (__bridge id _Nullable)(toBezierPath.CGPath);
    basicAnimation.toValue = (__bridge id _Nullable)(fromBezierPath.CGPath);
    basicAnimation.duration = [self transitionDuration:transitionContext];
    [shapeLayer addAnimation:basicAnimation forKey:@"dismisspath"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    });
    
}

@end
