//
//  MyPageViewController.m
//  TeamProject
//
//  Created by hongik on 2014. 1. 16..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "MyPageViewController.h"
#import "MypageCell.h"

@interface MyPageViewController () <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MyPageViewController{
    NSArray *arr;
}
- (IBAction)showAction:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"취 소" destructiveButtonTitle:@"삭 제" otherButtonTitles:nil, nil];
    sheet.tag = 1;
    [sheet showInView:self.view];
}
- (IBAction)timeLine:(id)sender {
    [self.container setHidden:YES];
    [self.table setHidden:NO];
}
- (IBAction)collection:(id)sender {
    [self.container setHidden:NO];
    [self.table setHidden:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MypageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MY_CELL"];
    //UIImage *image = [UIImage imageWithContentsOfFile:[arr objectAtIndex:indexPath.row]];
    cell.imgView.image = [UIImage imageNamed:[arr objectAtIndex:indexPath.row]];
    return cell;
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
    arr = @[@"photo1.jpg", @"photo2.jpg",@"photo3.jpg",@"photo4.jpg",@"photo5.jpg",@"photo6.jpg" ,@"photo7.jpg", @"photo8.jpg"];
    [self.container setHidden:YES];
   
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = CGSizeMake(320, 3500);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
