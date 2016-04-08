//
//  SearchView.m
//  kSearchStyle
//
//  Created by Kong on 16/4/7.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        [self buildCancelButton];
        [self buildSearchImage];
    }
    return self;
}


- (void)buildCancelButton
{
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, self.frame.size.height - 44, 50, 44);
    [self.cancelButton setTitle:@"取消" forState: UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self addSubview:self.cancelButton];
}
- (void)buildSearchImage
{
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64 - 32, 64, 32)];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self addSubview:searchButton];
}

@end
