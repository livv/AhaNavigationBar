//
//  FirstViewController.m
//  AhaNavigationBar
//
//  Created by haiwei on 16/1/17.
//  Copyright © 2016年 vvli. All rights reserved.
//

#import "FirstViewController.h"
#import "UINavigationBar+Aha.h"
#import "AhaHeaderView.h"

#define Screen_Height [UIScreen mainScreen].bounds.size.height//获取屏幕高度
#define Screen_Width [UIScreen mainScreen].bounds.size.width //获取屏幕宽度

#define NAVBAR_CHANGE_POINT 50

@interface FirstViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) AhaHeaderView * headerView;
@property (nonatomic, weak) IBOutlet UITableView * tableView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"111";

    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableHeaderView = self.headerView;
    [self.navigationController.navigationBar aha_setBackgroundColor:[UIColor redColor]];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    UIColor * color = [UIColor colorWithRed:100/255.0 green:175/255.0 blue:140/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar aha_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar aha_setBackgroundColor:[color colorWithAlphaComponent:0]];
        [self.headerView setupOffsetY:offsetY];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar aha_reset];
}


#pragma mark - getters

- (AhaHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[AhaHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 222)];
        _headerView.backgroundColor = [UIColor darkGrayColor];
        [_headerView setupImage:[UIImage imageNamed:@"bg.jpg"]];
    }
    return _headerView;
}


#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"message";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}



@end
