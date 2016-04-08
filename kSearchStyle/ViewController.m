//
//  ViewController.m
//  kSearchStyle
//
//  Created by Kong on 16/4/7.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "ViewController.h"
#import "KSearchViewController.h"
#import "KSearchTransitioningAnimation.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate,KSearchViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self buildSearchButton];
}

- (void)buildSearchButton
{
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64 - 32, 64, 32)];
    searchButton.backgroundColor = [UIColor orangeColor];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.view addSubview:searchButton];
    [searchButton addTarget:self action:@selector(searchOperation) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonLayerMaskWithButton:searchButton];
}

- (void)setButtonLayerMaskWithButton:(UIButton *)searchButton
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    CGFloat arcCenterX = searchButton.frame.size.width - searchButton.frame.size.height;
    CGFloat arcCenterY = searchButton.frame.size.height * 0.5;
    [path addLineToPoint:CGPointMake(arcCenterX, 0)];
    [path addArcWithCenter:CGPointMake(arcCenterX , arcCenterY) radius:arcCenterY startAngle: 3 * M_PI_2 endAngle: M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(0, searchButton.frame.size.width)];
    shapeLayer.path = path.CGPath;
    searchButton.layer.mask = shapeLayer;

}

#pragma mark - SearchButtonAction
- (void)searchOperation
{
    KSearchViewController *searchVC = [[KSearchViewController alloc] init];
    searchVC.transitioningDelegate  = self;
    searchVC.delegate               = self;
    [self presentViewController:searchVC animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
/**
 *  PresentAction
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    KSearchTransitioningAnimation *searchTransitionAnimation = [[KSearchTransitioningAnimation alloc] init];
    searchTransitionAnimation.isPresent                      = YES;
    return searchTransitionAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    KSearchTransitioningAnimation *searchTransitionAnimation = [[KSearchTransitioningAnimation alloc] init];
    searchTransitionAnimation.isPresent                      = NO;
    return searchTransitionAnimation;
}

#pragma mark - CancelButtonActionDelegate
- (void)ksearchViewCancelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
