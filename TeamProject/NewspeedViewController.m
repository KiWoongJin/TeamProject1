//
//  NewspeedViewController.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 1. 23..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "NewspeedViewController.h"
#import "ContentsViewController.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "AFNetworking.h"
#import "Newspeed.h"

#define CELL_WIDTH 160
#define CELL_COUNT 8
#define CELL_IDENTIFIER @"TEST_CELL"
#define URL @"http://192.168.211.96:8080/mainrecent.json"

@interface NewspeedViewController ()
@property (nonatomic, strong) NSMutableArray *cellHeights;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *container;
@end

@implementation NewspeedViewController
{
    NSArray *pictureName1;
    NSMutableArray *feedData;
    NSDictionary *tempDic;
    
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
        _cellHeights = [NSMutableArray arrayWithCapacity:CELL_COUNT];
        for (NSInteger i = 0; i < CELL_COUNT; i++) {
            //            _cellHeights[i] = @(arc4random() % 100 * 2 + 100);
            //   NSString *str = [heights objectAtIndex:i];
            //@([str integerValue]);
            UIImage *tmp = [UIImage imageNamed:[pictureName1 objectAtIndex:i]];
            
            _cellHeights[i] =@(((tmp.size.height*160)/tmp.size.width)+50) ;
        }
    }
    return _cellHeights;
}

- (IBAction)ChooseButton:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    if (control.selectedSegmentIndex == 0) {

        [self.container setHidden:YES];
        [self.collectionView setHidden:NO];
        
    }
    else if(control.selectedSegmentIndex ==1){

        [self.container setHidden:NO];
        [self.collectionView setHidden:YES];
    }
  
    //[self.collectionView reloadData];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView reloadData];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return feedData.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
  //  NSURL *userImage = [NSURL URLWithString:[feedData objectAtIndex:indexPath.row]];
    
  
   // [self.petImageView setImageWithURL:postUrl];
    UIImage *btnImage = [UIImage imageNamed:[pictureName1 objectAtIndex:indexPath.row]];
    [cell.imgBtn setImage:btnImage forState:UIControlStateNormal];
    //cell.imgView.image =[UIImage imageNamed:[pictureName1 objectAtIndex:indexPath.row]];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
        ContentsViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentVC"];
        [UIApplication sharedApplication].keyWindow.rootViewController = nextVC;
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

    pictureName1 = @[@"photo1.jpg", @"photo2.jpg",@"photo3.jpg",@"photo4.jpg",@"photo5.jpg",@"photo6.jpg" ,@"photo7.jpg", @"photo8.jpg"];
    
    feedData = [[NSMutableArray alloc]init];
    
    
    //[feedData addObject:item];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //NSDictionary *parameters = @{@"fam_id":@"aaa"};
    
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
       
        NSInteger allCount;
        NSInteger postId;
        NSString *image;
        NSString *proImage;
        NSString *nickName;
        NSDate *time;
        NSString *place;
        NSInteger likeCnt;
        NSInteger comCnt;
        Newspeed *item;
        
        tempDic = [responseObject objectForKey:@"post"];
        allCount= tempDic.count;
        
        for(int i = 0; i < allCount; i++)
        {
            NSLog(@"i = %d",i);
            self.totalDic=[[NSMutableDictionary alloc]init];
            
            self.totalDic = [responseObject objectForKey:@"post"][i];
            
            postId = [[self.totalDic objectForKey:@"post_id"]intValue];
            image = [self.totalDic objectForKey:@"picture"];
            proImage =[self.totalDic objectForKey:@"profile_picture"];
            nickName = [self.totalDic objectForKey:@"nickname"];
            
            time = [self.totalDic objectForKey:@"create_date"];
            
            place = [self.totalDic objectForKey:@"place_name"];
            likeCnt = [[self.totalDic objectForKey:@"like_cnt"]intValue];
            comCnt = [[self.totalDic objectForKey:@"comment_cnt"]intValue];
            
            item = [Newspeed ptId:postId postImg:image proImg:proImage nickName:nickName date:time place:place likeCnt:likeCnt comCnt:comCnt];
            
            
            [feedData addObject:item];
            
        }
        
        
        NSLog(@"%ld",allCount);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"FEED_INFO_UPDATE" object:Nil];
        
    }failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error:%@",error);
     }];
    [self.view addSubview:self.collectionView];
    [self updateLayout];
    [self.view addSubview:self.button];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
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
