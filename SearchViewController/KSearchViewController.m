//
//  KSearchViewController.m
//  kSearchStyle
//
//  Created by Kong on 16/4/7.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "KSearchViewController.h"
#import "SearchView.h"

@interface KSearchViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SearchView  *searchView;
@property (nonatomic, strong) UITableView *searchTableView;

@end

@implementation KSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildSearchView];
    [self buildSearchTableView];
}

- (void)buildSearchView
{
    self.searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [self.searchView.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchView];
}

- (void)buildSearchTableView
{
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    self.searchTableView.backgroundColor = [UIColor magentaColor];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    [self.searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchTableViewCellID"];
    [self.view addSubview:self.searchTableView];
}

- (void)cancelButtonAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ksearchViewCancelAction)]) {
        [self.delegate ksearchViewCancelAction];
    }
}

#pragma mark - UITableViewDelegateAndDataSources
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell    = [tableView dequeueReusableCellWithIdentifier:@"searchTableViewCellID"];
    cell.textLabel.text      = @"搜索数据";
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}
@end
