//
//  Newspeed3ViewController.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 2. 12..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "Newspeed3ViewController.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "UIImageView+AFNetworking.h"

#define CELL_WIDTH 160
//#define CELL_COUNT 8
#define CELL_IDENTIFIER @"TEST3_CELL"
#define URL @"http://picple.pws12321.cloulu.com/newsFeed/new/0/10/"

@interface Newspeed3ViewController ()
@property (nonatomic, strong) NSMutableArray *cellHeights;

@end

@implementation Newspeed3ViewController
{
 
    NSDictionary *tempDic;
    
    NSMutableArray *postId;
    NSMutableArray *postImg;
    NSMutableArray *proImg;
    NSMutableArray *nickName;
    NSMutableArray *time;
    NSMutableArray *place;
    NSMutableArray *likeCnt;
    NSMutableArray *comCnt;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.cellWidth = CELL_WIDTH;        // Default if not setting runtime attribute
    }
    return self;
}

#pragma mark - Accessors
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(9, 9, 9, 9);
        layout.delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER];
        
    }
    return _collectionView;
}

- (NSMutableArray *)cellHeights {
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray arrayWithCapacity:tempDic.count];
        for (NSInteger i = 0; i < tempDic.count; i++) {
            //            _cellHeights[i] = @(arc4random() % 100 * 2 + 100);
            //   NSString *str = [heights objectAtIndex:i];
            //@([str integerValue]);
            NSURL *postUrl = [NSURL URLWithString:[postImg objectAtIndex:i]];
            NSData *temp = [NSData dataWithContentsOfURL:postUrl];
            
            UIImage *tmp = [UIImage imageWithData:temp];
            NSLog(@"13");
            if (tmp == NULL) {
                UIImage *instead = [UIImage imageNamed:@"photo3.jpg"];
                _cellHeights[i] =@(((instead.size.height*160)/instead.size.width)+50) ;
                
            }else{
            _cellHeights[i] =@(((tmp.size.height*160)/tmp.size.width)+50) ;
            }
        }
    }
    return _cellHeights;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return tempDic.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
    
    //  UIImage *btnImage = [UIImage imageNamed:[pictureName1 objectAtIndex:indexPath.row]];
    // [cell.imgBtn3 setImage:btnImage forState:UIControlStateNormal];
    //cell.imgView.image =[UIImage imageNamed:[pictureName1 objectAtIndex:indexPath.row]];
    NSURL *postUrl = [NSURL URLWithString:[postImg objectAtIndex:indexPath.row]];
    NSURL *proUrl = [NSURL URLWithString:[proImg objectAtIndex:indexPath.row]];
    
    [cell.imgBtn4 setImageForState:UIControlStateNormal withURL:postUrl];
    [cell.proImage3 setImageWithURL:proUrl];
    cell.nickName3.text = [nickName objectAtIndex:indexPath.row];
    cell.placeLabel3.text = [place objectAtIndex:indexPath.row];
    cell.likeCnt3.text = [NSString stringWithFormat:@"%@",[likeCnt objectAtIndex:indexPath.row]];
    cell.comCnt3.text = [NSString stringWithFormat:@"%@",[comCnt objectAtIndex:indexPath.row]];
    return cell;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    
    return reusableView;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
                                            duration:duration];
    [self updateLayout];
}

- (void)updateLayout {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = self.collectionView.bounds.size.width / self.cellWidth;
    layout.itemWidth = self.cellWidth;
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
    NSLog(@"90");
	// Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.collectionView];
    [self updateLayout];
}
- (void)communication{
    
    
    postId = [[NSMutableArray alloc]init];
    postImg = [[NSMutableArray alloc]init];
    proImg = [[NSMutableArray alloc]init];
    nickName = [[NSMutableArray alloc]init];
    time = [[NSMutableArray alloc]init];
    place = [[NSMutableArray alloc]init];
    likeCnt = [[NSMutableArray alloc]init];
    comCnt = [[NSMutableArray alloc]init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSInteger allCount;
        tempDic = [responseObject objectForKey:@"posts"];
        allCount= tempDic.count;
        
        for(int i = 0; i < allCount; i++)
        {
           NSLog(@"70");
            
            self.totalDic=[[NSMutableDictionary alloc]init];
            
            self.totalDic = [responseObject objectForKey:@"posts"][i];
            
            [postId addObject:[self.totalDic objectForKey:@"post_id"]];
            [postImg addObject:[self.totalDic objectForKey:@"picture"]];
            [proImg addObject:[self.totalDic objectForKey:@"profile_picture"]];
            [nickName addObject:[self.totalDic objectForKey:@"nickname"]];
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
#pragma mark - UICollectionViewWaterfallLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(CHTCollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellHeights[indexPath.item] floatValue];
}
@end
