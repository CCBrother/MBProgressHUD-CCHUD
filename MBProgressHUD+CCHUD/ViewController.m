//
//  ViewController.m
//  MBProgressHUD+CCHUD
//
//  Created by ZhangCc on 2017/11/7.
//  Copyright © 2017年 ZhangCc. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+CCHUD.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ViewController

- (NSArray *)titleArray {
        return @[@"window显示文字",@"window加载弹窗",@"window自定义图片",@"view显示文字",@"view加载弹窗",@"view自定义图片",@"成功展示弹窗",@"错误展示弹窗",@"警告展示弹窗",@"信息展示弹窗"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [MBProgressHUD showInWindowMessage:@"window文字"];
            break;
        case 1:
            [MBProgressHUD showInWindowActivityWithMessage:nil];
            break;
        case 2:
            [MBProgressHUD showInWindowCustomImage:@"custom" message:@"这是window自定义图片"];
            break;
        case 3:
            [MBProgressHUD showInViewMessage:@"view文字"];
            break;
        case 4:
            [MBProgressHUD showInViewActivityWithMessage:nil];
            break;
        case 5:
            [MBProgressHUD showInViewCustomImage:@"custom" message:@"这是view自定义图片"];
            break;
        case 6:
            [MBProgressHUD showSuccessMessage:@"成功!"];
            break;
        case 7:
            [MBProgressHUD showFailMessage:@"失败!"];
            break;
        case 8:
            [MBProgressHUD showWarnMessage:@"警告!"];
            break;
        case 9:
            [MBProgressHUD showInfoMessage:@"信息!"];
            break;
            
        default:
            break;
    }
//    [self performSelector:@selector(hide) withObject:nil afterDelay:3];
}

- (void)hide {
    [MBProgressHUD hideHUD];
}

@end
