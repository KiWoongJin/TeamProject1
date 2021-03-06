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
#import "UIButton+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "ThumbDelegate.h"


#define CELL_WIDTH 160
//#define CELL_COUNT 8
#define CELL_IDENTIFIER @"TEST_CELL"
#define URL @"http://picple.pws12321.cloulu.com/newsFeed/new/0/10/"

@interface NewspeedViewController ()<ThumbDelegate>
@property (nonatomic, strong) NSMutableArray *cellHeights;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *container2;


@end

@implementation NewspeedViewController
{
    NSArray *pictureName1;
    NSDictionary *tempDic;
    
    NSMutableArray *postId;
    NSMutableArray *postImg;
    NSMutableArray *proImg;
    NSMutableArray *nickname;
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
- (void)moveDetail:(id)sender{
    NSLog(@"%@",sender);
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    NSLog(@"%d", indexPath.row);
   
    ContentsViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentVC"];
    NSString *temp = [postId objectAtIndex:indexPath.row];
    NSString *temp2 = @"http://picple.pws12321.cloulu.com/post/";
    
    nextVC.nextURL = [temp2 stringByAppendingString:temp];
    NSLog(@"%@",[postId objectAtIndex:indexPath.row]);
 
    [self.navigationController pushViewController: (UIViewController *)nextVC animated:YES];
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
            NSLog(@"cell height log");
            NSLog(@"cell height postImg%@",[postImg objectAtIndex:i]);

            NSURL *postUrl = [NSURL URLWithString:[postImg objectAtIndex:i]];
            NSData *temp = [NSData dataWithContentsOfURL:postUrl];
            
            UIImage *tmp = [UIImage imageWithData:temp];
            
            NSLog(@"cell height / uiimage : %@", tmp);
            if (tmp == NULL) {
                UIImage *instead = [UIImage imageNamed:@"photo3.jpg"];
                _cellHeights[i] =@(((instead.size.height*160)/instead.size.width)+50) ;

            }
            //[temp seti]
           // UIImage *tmp = [UIImage imageNamed:@"photo1.jpg"];
            else{
            _cellHeights[i] =@(((tmp.size.height*160)/tmp.size.width)+50) ;
            }
           // _cellHeights[i] =@(30) ;
        }
    }
    
    return _cellHeights;
    
}

- (IBAction)ChooseButton:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    if (control.selectedSegmentIndex == 0) {

        [self.container setHidden:YES];
        [self.container2 setHidden:YES];
        [self.collectionView setHidden:NO];
        
    }
    else if(control.selectedSegmentIndex ==1){

        [self.container setHidden:NO];
        [self.container2 setHidden:YES];
        [self.collectionView setHidden:YES];
    }
    else if (control.selectedSegmentIndex == 2){
        [self.container setHidden:YES];
        [self.container2 setHidden:NO];
        [self.collectionView setHidden:YES];
    }
  
    //[self.collectionView reloadData];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView reloadData];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%ld",tempDic.count);
    return tempDic.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
    NSLog(@"cell draw");
    cell.delegate = self;
  //  NSURL *userImage = [NSURL URLWithString:[feedData objectAtIndex:indexPath.row]];
    
   // NSLog(@"%@",[postImg objectAtIndex:indexPath.row]);
    NSURL *postUrl = [NSURL URLWithString:[postImg objectAtIndex:indexPath.row]];
    NSURL *proUrl = [NSURL URLWithString:[proImg objectAtIndex:indexPath.row]];
    
    [cell.imgBtn setImageForState:UIControlStateNormal withURL:postUrl];
    [cell.proImage1 setImageWithURL:proUrl];
    
   NSLog(@"22");
    cell.nickName.text = [nickname objectAtIndex:indexPath.row];
    NSLog(@"%@",cell.nickName.text);
    cell.placeLabel.text = [place objectAtIndex:indexPath.row];
    NSLog(@"%@",cell.placeLabel.text);
    cell.likeCnt.text = [NSString stringWithFormat:@"%@",[likeCnt objectAtIndex:indexPath.row]];
    NSLog(@"%@",cell.likeCnt.text);
    cell.comCnt.text = [NSString stringWithFormat:@"%@",[comCnt objectAtIndex:indexPath.row]];
    
    NSLog(@"%@",cell.comCnt.text);
   
  
//    UIImage *btnImage = [UIImage imageNamed:[pictureName1 objectAtIndex:indexPath.row]];
//    [cell.imgBtn setImage:btnImage forState:UIControlStateNormal];

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

    pictureName1 = @[@"photo1.jpg", @"photo2.jpg",@"photo3.jpg",@"photo4.jpg",@"photo5.jpg",@"photo6.jpg" ,@"photo7.jpg", @"photo8.jpg"];
    
 //   NSLog(@"123");
  //  NSLog(@"%ld", allCount);
  //  [self communication];
  //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(feedInfoUpdate:) name:@"FEED_INFO_UPDATE" object:nil];
  //  [self.collectionView reloadData];
    [self communication];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(feedInfoUpdate:) name:@"FEED_INFO_UPDATE" object:nil];
    
    [self.view addSubview:self.collectionView];
    [self updateLayout];
    [self.view addSubview:self.button];
    
}
- (void)communication{
    
    
    postId = [[NSMutableArray alloc]init];
    postImg = [[NSMutableArray alloc]init];
    proImg = [[NSMutableArray alloc]init];
    nickname = [[NSMutableArray alloc]init];
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
            NSLog(@"i = %d",i);

            self.totalDic=[[NSMutableDictionary alloc]init];
            
            self.totalDic = [responseObject objectForKey:@"posts"][i];
            
            [postId addObject:[self.totalDic objectForKey:@"post_id"]];
            NSLog(@"communication picture : %@", [self.totalDic objectForKey:@"picture"]);
            [postImg addObject:[self.totalDic objectForKey:@"picture"]];
            [proImg addObject:[self.totalDic objectForKey:@"profile_picture"]];
            [nickname addObject:[self.totalDic objectForKey:@"nickname"]];
            [time addObject:[self.totalDic objectForKey:@"created_time"]];
            [place addObject:[self.totalDic objectForKey:@"place_name"]];
            [likeCnt addObject:[self.totalDic objectForKey:@"like_cnt"]];
            [comCnt addObject:[self.totalDic objectForKey:@"comment_cnt"]];
           

        }
        NSLog(@"%@", postId);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"FEED_INFO_UPDATE" object:Nil];
        
    }failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error:%@",error);
     }];
   
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    

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
