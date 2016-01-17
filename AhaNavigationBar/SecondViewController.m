//
//  SecondViewController.m
//  AhaNavigationBar
//
//  Created by haiwei on 16/1/17.
//  Copyright © 2016年 vvli. All rights reserved.
//

#import "SecondViewController.h"
#import "UINavigationBar+Aha.h"
#import "AhaHeaderView.h"

#define Screen_Height [UIScreen mainScreen].bounds.size.height//获取屏幕高度
#define Screen_Width [UIScreen mainScreen].bounds.size.width //获取屏幕宽度

#define NAVBAR_CHANGE_POINT 50

@interface SecondViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) AhaHeaderView * headerView;
@property (nonatomic, weak) IBOutlet UITableView * tableView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"222";

    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.navigationController.navigationBar aha_setBackgroundColor:[UIColor whiteColor]];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        if (offsetY >= 44) {
            [self setNavigationBarTransformProgress:1];
        } else {
            [self setNavigationBarTransformProgress:(offsetY / 44)];
        }
    } else {
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
        [self.headerView setupOffsetY:offsetY];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress {
    
    [self.navigationController.navigationBar aha_setTranslationY:(-44 * progress)];
    [self.navigationController.navigationBar aha_setElementsAlpha:(1-progress)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
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
