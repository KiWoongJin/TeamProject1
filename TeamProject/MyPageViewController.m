//
//  MyPageViewController.m
//  TeamProject
//
//  Created by hongik on 2014. 1. 16..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "MyPageViewController.h"
#import "MypageCell.h"
#import "AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#define URL @"http://picple.pws12321.cloulu.com/mypage/1/timeline/0/10"

@interface MyPageViewController () <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UINavigationItem *navi;
@property (weak, nonatomic) IBOutlet UIImageView *profile;

@end

@implementation MyPageViewController{
    
    NSInteger allCount;
    NSDictionary *tempDic;
    NSString *nickName;
    NSString *intro;
    NSInteger followerCnt;
    NSInteger followingCnt;
    NSInteger picpleId;
    NSString *proImg;
    NSString *mypageImg;
    
    NSMutableArray *postId;
    NSMutableArray *title;
    NSMutableArray *picture;
    NSMutableArray *profileImg;
    NSMutableArray *nickname;
    NSMutableArray *time;
    NSMutableArray *place;
    NSMutableArray *likeCnt;
    NSMutableArray *comCnt;

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
    return allCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MypageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MY_CELL"];
    //UIImage *image = [UIImage imageWithContentsOfFile:[arr objectAtIndex:indexPath.row]];
    NSURL *img = [NSURL URLWithString:[picture objectAtIndex:indexPath.row]];
    NSURL *pro = [NSURL URLWithString:[profileImg objectAtIndex:indexPath.row]];
    
    [cell.timeImg setImageForState:UIControlStateNormal withURL:img];
    [cell.proImg setImageWithURL:pro];
                  
    cell.nick.text = [nickname objectAtIndex:indexPath.row];
    cell.title.text = [title objectAtIndex:indexPath.row];
    cell.place.text = [place objectAtIndex:indexPath.row];
    cell.like.text = [NSString stringWithFormat:@"%@",[likeCnt objectAtIndex:indexPath.row]];
    cell.com.text = [NSString stringWithFormat:@"%@",[comCnt objectAtIndex:indexPath.row]];
    
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
- (void)communication{
    
    postId = [[NSMutableArray alloc]init];
    title =[[NSMutableArray alloc]init];
    picture = [[NSMutableArray alloc]init];
    profileImg = [[NSMutableArray alloc]init];
    nickname = [[NSMutableArray alloc]init];
    time = [[NSMutableArray alloc]init];
    place = [[NSMutableArray alloc]init];
    likeCnt = [[NSMutableArray alloc]init];
    comCnt = [[NSMutableArray alloc]init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"123");
        
        nickName =[responseObject objectForKey:@"nickname"];
        //intro =[responseObject objectForKey:@"introduce"];
        followerCnt =[[responseObject objectForKey:@"follower_cnt"]intValue];
        followingCnt =[[responseObject objectForKey:@"following_cnt"]intValue];
        picpleId =[[responseObject objectForKey:@"picple_id"]intValue];
        proImg =[responseObject objectForKey:@"profile_picture"];
        mypageImg =[responseObject objectForKey:@"mypage_bg_picture"];
        
        
        tempDic = [responseObject objectForKey:@"posts"];
        allCount= tempDic.count;
        
        for(int i = 0; i < allCount; i++)
        {
            NSLog(@"i = %d",i);
            
            self.totalDic=[[NSMutableDictionary alloc]init];
            
            self.totalDic = [responseObject objectForKey:@"posts"][i];
            
            [postId addObject:[self.totalDic objectForKey:@"post_id"]];
            [title addObject:[self.totalDic objectForKey:@"title"]];
            [picture addObject:[self.totalDic objectForKey:@"picture"]];
            [profileImg addObject:[self.totalDic objectForKey:@"profile_picture"]];
            [nickname addObject:[self.totalDic objectForKey:@"nickname"]];
            [time addObject:[self.totalDic objectForKey:@"created_time"]];
            [place addObject:[self.totalDic objectForKey:@"place_name"]];
            [likeCnt addObject:[self.totalDic objectForKey:@"like_cnt"]];
            [comCnt addObject:[self.totalDic objectForKey:@"comment_cnt"]];
            
            
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"FEED_INFO_UPDATE" object:Nil];
        
    }failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error:%@",error);
     }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    [self communication];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(feedInfoUpdate:) name:@"FEED_INFO_UPDATE" object:nil];
    
    [self.container setHidden:YES];
    
    
   
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = CGSizeMake(320, 3500);
}
-(void)feedInfoUpdate:(NSNotification *)notification
{
    // NSLog(@"135");
    self.navi.title = nickName;
    self.name.text = nickName;
    
    NSURL *titleURL = [NSURL URLWithString:mypageImg];
    NSURL *proURL = [NSURL URLWithString:proImg];
    
    [self.titleImg setImageWithURL:titleURL];
    [self.profile setImageWithURL:proURL];
    [self.table reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
