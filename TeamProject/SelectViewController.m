//
//  SelectViewController.m
//  TeamProject
//
//  Created by hongik on 2014. 1. 16..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation SelectViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *list = [NSArray arrayWithObjects:@"PICPLE",@"User Name",@"뉴스피드",@"좋아요",@"설정",nil];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SELECT_CELL"];
    
    cell.textLabel.text = [list objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        
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
