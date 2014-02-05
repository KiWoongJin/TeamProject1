//
//  SettingViewController.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 1. 23..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "SettingViewController.h"
#import "LikeCell.h"
#import "CommentCell.h"
#import "FollowCell.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate>
//@property (weak, nonatomic) IBOutlet UISwitch *likeOnOff;
//@property (weak, nonatomic) IBOutlet UISwitch *commentOnOff;
//@property (weak, nonatomic) IBOutlet UISwitch *followOnOff;
@property (weak, nonatomic) IBOutlet UITableView *table;


@end

@implementation SettingViewController{
    UISwitch *like;
    UISwitch *comment;
    UISwitch *follow;
}

- (IBAction)alramOnOff:(id)sender {
   
    BOOL isOn = ((UISwitch *)sender).on;
   
    
    if(isOn){
        [like setOn:isOn animated:YES];
        [comment setOn:isOn animated:YES];
        [follow setOn:isOn animated:YES];
        like.enabled = YES;
        comment.enabled = YES;
        follow.enabled = YES;
    }
    else{
        [like setOn:isOn animated:YES];
        [comment setOn:isOn animated:YES];
        [follow setOn:isOn animated:YES];
        like.enabled = NO;
        comment.enabled = NO;
        follow.enabled = NO;
    }
 
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
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return 1;
    }
    else if (1 == section){
        return 1;
    }
    else if (2 == section){
        return 1;
    }
    else if (3 == section){
        return 1;
    }
    else if (4 == section){
        return 1;
    }
    else
        return 1;
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    if (0 == indexPath.section) {
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"PRO_CELL"];
        cell.textLabel.text = @"프로필 설정";
        return cell;
    }
    else if (1 == indexPath.section){
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"ALRAM_CELL"];
        cell.textLabel.text = @"알림 기능";
        return cell;
    }
    else if (2 == indexPath.section){
        LikeCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"LIKE_CELL"];
        cell.textLabel.text = @"좋아요 알림";
        like = cell.likeOnOff;
      
        return cell;
    }
    else if (3 == indexPath.section){
        CommentCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"COMMENT_CELL"];
        cell.textLabel.text = @"댓글 알림";
        comment = cell.commentOnOff;
        return cell;
    }
    else if (4 == indexPath.section){
        FollowCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"FOLLOW_CELL"];
        cell.textLabel.text = @"팔로우 알림";
        follow = cell.followOnOff;
        return cell;
    }
    else {
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"LOGOUT_CELL"];
        cell.textLabel.text = @"로그 아웃";
        return cell;
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return [NSString stringWithFormat:@"내 정보"];
    }
    if (1 == section){
        return [NSString stringWithFormat:@"알림설정"];
    }
    if (2 == section) {
        return [NSString stringWithFormat:@" "];
    }
    if (3 == section) {
        return nil;
    }
    if (4 == section) {
        return nil;
    }
    else
        return [NSString stringWithFormat:@"로그아웃"];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
