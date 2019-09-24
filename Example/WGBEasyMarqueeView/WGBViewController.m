//
//  WGBViewController.m
//  WGBEasyMarqueeView
//
//  Created by Wangguibin on 09/24/2019.
//  Copyright (c) 2019 Wangguibin. All rights reserved.
//

#import "WGBViewController.h"
#import "WGBDemoViewController.h"
#import "HPAutoScorllTextLabel.h"


@interface WGBViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray<NSString*> *titles;

@end

@implementation WGBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        // Fallback on earlier versions
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    CGFloat screenW = UIScreen.mainScreen.bounds.size.width;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 35)];
    if (@available(iOS 13.0, *)) {
        footer.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        // Fallback on earlier versions
        footer.backgroundColor = [UIColor cyanColor];
    }
    HPAutoScorllTextLabel *label = [[HPAutoScorllTextLabel alloc] initWithFrame:CGRectMake(15, 0, screenW - 30, 35)];
    [footer addSubview: label];
    label.style = HPTextCycleStyleAlways;
    if (@available(iOS 13.0, *)) {
        label.textColor = [UIColor labelColor];
    } else {
        // Fallback on earlier versions
        label.textColor = [UIColor orangeColor];
    }
    label.text = @"`HPAutoScorllTextLabel`这个组件感觉不够优雅(需要手动管理定时器的生命周期)，所以才决定重写了`JXMarqueeView`的OC版";
    label.font = [UIFont systemFontOfSize:18];
    [label start];
    
    self.tableView.tableFooterView = footer;
    [self.tableView reloadData];
}


- (NSArray<NSString *> *)titles{
    return @[
        @"WGBEasyMarqueeTypeLeft",
        @"WGBEasyMarqueeTypeRight",
        @"WGBEasyMarqueeTypeReverse",
        @"自定义View",
    ];
}


#pragma mark -  UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:  NSStringFromClass([UITableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WGBDemoViewController *demoVC = [[WGBDemoViewController alloc] init];
    demoVC.marqueeType = indexPath.row;
    demoVC.title = self.titles[indexPath.row];
    [self.navigationController presentViewController:demoVC animated:YES completion:^{
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



@end
