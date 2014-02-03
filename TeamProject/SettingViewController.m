//
//  SettingViewController.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 1. 23..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SettingViewController{
      NSArray *arr;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return 1;
    }
    else if (1 == section){
        return 3;
    }
    else
        return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (0 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PRO_CELL"];
        cell.textLabel.text = @"프로필 설정";
    }
    else if (1 == indexPath.section){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ALRAM_CELL"];
        cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    }
    else if (2 == indexPath.section){
        cell = [tableView dequeueReusableCellWithIdentifier:@"LOGOUT_CELL"];
        cell.textLabel.text = @"로그아웃";
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return [NSString stringWithFormat:@"내 정보"];
    }
    if (1 == section){
        return [NSString stringWithFormat:@"알림설정"];
    }
    else
        return [NSString stringWithFormat:@"로그아웃"];
;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
     arr = @[@"푸시 알림", @"좋아요 알림", @"댓글 알림"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
