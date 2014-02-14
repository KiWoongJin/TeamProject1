//
//  MypageCollectionViewController.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "MypageCollectionViewController.h"
#import "MypageCollectionCell.h"
#import "AFNetworking.h"
#import "UIButton+AFNetworking.h"
#define URL @"http://picple.pws12321.cloulu.com/mypage/1/list/0/10"
@interface MypageCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MypageCollectionViewController{

    NSInteger allCount;
    NSDictionary *tempDic;
    NSMutableArray *picture;
    NSMutableArray *postId;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return allCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MypageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    NSURL *img = [NSURL URLWithString:[picture objectAtIndex:indexPath.row]];

    [cell.colImg setImageForState:UIControlStateNormal withURL:img];
    
    return cell;
}
- (void)communication{
    
    picture = [[NSMutableArray alloc]init];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"123");
        
        tempDic = [responseObject objectForKey:@"pictures"];
        allCount= tempDic.count;
        
        for(int i = 0; i < allCount; i++)
        {
            NSLog(@"i = %d",i);
            
            self.totalDic=[[NSMutableDictionary alloc]init];
            
            self.totalDic = [responseObject objectForKey:@"pictures"][i];
            
            [picture addObject:[self.totalDic objectForKey:@"picture"]];
            [postId addObject:[self.totalDic objectForKey:@"post_id"]];
            
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
 
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self communication];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(feedInfoUpdate:) name:@"FEED_INFO_UPDATE" object:nil];
}
-(void)feedInfoUpdate:(NSNotification *)notification
{
    // NSLog(@"135");
    
    [self.collectionView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
