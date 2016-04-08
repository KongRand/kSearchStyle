//
//  kSearchTransitioningAnimation.h
//  kSearchStyle
//
//  Created by Kong on 16/4/7.
//  Copyright © 2016年 lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KSearchTransitioningAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval transitioningDuration;

@property (nonatomic, assign) BOOL isPresent;

@end
