//
//  SelectViewController.m
//  TeamProject
//
//  Created by hongik on 2014. 1. 16..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "SelectViewController.h"
#import "MyPageViewController.h"
#import "NewspeedViewController.h"
#import "SettingViewController.h"
#import "LikeViewController.h"

@interface SelectViewController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation SelectViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *list = [NSArray arrayWithObjects:@"User Name",@"뉴스피드",@"좋아요",@"설정",nil];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SELECT_CELL"];
    
    cell.textLabel.text = [list objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MyPageViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPageVC"];
        [UIApplication sharedApplication].keyWindow.rootViewController = nextVC;
    }
    else if(indexPath.row == 1){
        NewspeedViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NewSpeedVC"];
        [UIApplication sharedApplication].keyWindow.rootViewController = nextVC;
    }
    else if (indexPath.row == 2){
        LikeViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LikeVC"];
        [UIApplication sharedApplication].keyWindow.rootViewController = nextVC;
    }
    else if(indexPath.row == 3){
        SettingViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingVC"];
        [UIApplication sharedApplication].keyWindow.rootViewController = nextVC;
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
