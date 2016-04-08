//
//  KSearchViewController.h
//  kSearchStyle
//
//  Created by Kong on 16/4/7.
//  Copyright © 2016年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KSearchViewDelegate <NSObject>

@required
- (void)ksearchViewCancelAction;

@end

@interface KSearchViewController : UIViewController

@property (nonatomic, weak)id <KSearchViewDelegate>delegate;

@end
