//
//  ContentsViewController.m
//  TeamProject
//
//  Created by hongik on 2014. 1. 16..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "ContentsViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "DetailtouchViewController.h"
#import "DetailCell.h"

//#define IMAGE_NUM 5
#define SCREEN_FRAME [[UIScreen mainScreen] applicationFrame]

@interface ContentsViewController () <UIActionSheetDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>{
    UIPageControl *pageControl;
    int loadedPageCount;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scorll;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *test;
@property (weak, nonatomic) IBOutlet UILabel *shortAddr;
@property (weak, nonatomic) IBOutlet UILabel *likeCnt;
@property (weak, nonatomic) IBOutlet UILabel *comCnt;
@property (weak, nonatomic) IBOutlet UITextView *message;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *detailAddr;

@end

@implementation ContentsViewController{
    NSInteger allCount;
    NSMutableArray *data;
    NSString *URL;
    NSInteger liked;
    NSInteger likeCnt;
    NSInteger followed;
    NSString *comment;
    NSInteger comCnt;
    NSDictionary *place;
    NSArray *coordinate;
    NSString *detailAddr;
    NSString *shortAddr;
    NSString *message;
    NSString *date;
    NSDictionary *picture;
    NSMutableArray *oriPic;
    NSMutableArray *newPic;
    NSMutableArray *timePic;
    NSMutableArray *listPic;
    NSMutableArray *picId;
    NSString *nickName;
    NSString *proPic;
    
}
//좋아요 서버로 날려
//- (IBAction)likeBtn:(id)sender {
//}

- (void)loadContentsPage:(int)pageNo{
    if(pageNo <0 || pageNo < loadedPageCount || pageNo >= allCount)
        return;
    float width = self.scrollView.frame.size.width;
    float height = self.scrollView.frame.size.height;
    
//    NSString *fileName = [NSString stringWithFormat:@"photo%d",pageNo];
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"jpg"];
//    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    NSURL *picUrl = [NSURL URLWithString:[timePic objectAtIndex:pageNo]];
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setImageWithURL:picUrl];
    
    imageView.frame = CGRectMake(width * pageNo, 0, width, height);
//    CGImageSourceRef source = CGImageSourceCreateWithURL( (CFURLRef) aUrl, NULL);
//    CGImageSourceRef source = CGImageSourceCreateWithData( (CFDataRef) theData, NULL);
//    NSDictionary *metadata = (NSDictionary *)CGImageSourceCopyPropertiesAtIndex(source,0,NULL);
    [self.scrollView addSubview:imageView];
   // self.test.text = fileName;
    loadedPageCount++;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float width = scrollView.frame.size.width;
    float offsetX = scrollView.contentOffset.x;
    int pageNo = floor(offsetX/width);
    pageControl.currentPage = pageNo;
    
    [self loadContentsPage:pageNo-1];
    [self loadContentsPage:pageNo];
    [self loadContentsPage:pageNo+1];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return comCnt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COMMENT_CELL"];
   // cell.nickName.text =
    cell.comment.text = [data objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [data removeObjectAtIndex:indexPath.row];
        NSArray *rows = [NSArray arrayWithObject:indexPath];
        [self.table deleteRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (IBAction)addCom:(id)sender {
    NSString *inputStr = self.userInput.text;
    if ([inputStr length]>0) {
        [data addObject:inputStr];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(comCnt-1) inSection:0];
        NSArray *row = [NSArray arrayWithObject:indexPath];
        [self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
        
        self.userInput.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self addCom:nil];
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)showAction:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"취 소" destructiveButtonTitle:@"삭 제" otherButtonTitles:nil, nil];
    sheet.tag = 1;
    [sheet showInView:self.view];
}
- (void)communication{
    
//    NSInteger liked;
//    NSInteger likeCnt;
//    NSInteger followed;
//    NSString *comment;
//    NSInteger comCnt;
//    NSDictionary *place;
//    NSArray *coordinate;
//    NSString *detailAddr;
//    NSString *shortAddr;
//    NSString *message;
//    NSString *date;
//    NSDictionary *picture;
//    NSString *oriPic;
//    NSString *newPic;
//    NSString *timePic;
//    NSString *listPic;
//    NSString *picId;
//    NSString *nickName;
//    NSString *proPic;
//    postId = [[NSMutableArray alloc]init];
//    postImg = [[NSMutableArray alloc]init];
//    proImg = [[NSMutableArray alloc]init];
//    nickName = [[NSMutableArray alloc]init];
//    time = [[NSMutableArray alloc]init];
//    place = [[NSMutableArray alloc]init];
//    likeCnt = [[NSMutableArray alloc]init];
//    likeCnt = [[NSMutableArray alloc]init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:self.nextURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){

        liked = [[responseObject objectForKey:@"liked"]intValue];
        likeCnt = [[responseObject objectForKey:@"like_cnt"]intValue];
        comment = [responseObject objectForKey:@"comment"];
        comCnt = [[responseObject objectForKey:@"comment_cnt"]intValue];
        place = [responseObject objectForKey:@"place"];
        coordinate = [place objectForKey:@"coordinate"];
        detailAddr = [place objectForKey:@"detail.addr"];
        shortAddr = [place objectForKey:@"short_addr"];
        message = [responseObject objectForKey:@"message"];
        date = [responseObject objectForKey:@"created_tiem"];
        picture = [responseObject objectForKey:@"picture"];
        
        nickName =[responseObject objectForKey:@"nickname"];
        proPic = [responseObject objectForKey:@"profile_picture"];
        
        //tempDic = [responseObject objectForKey:@"posts"];
        allCount= picture.count;
        
        for(int i = 0; i < allCount; i++)
        {
            NSLog(@"i = %d",i);
            
            self.pictureDic=[[NSMutableDictionary alloc]init];
            self.pictureDic = [responseObject objectForKey:@"picture"][i];
            
            [oriPic addObject:[self.pictureDic objectForKey:@"original_picture"]];
            [listPic addObject:[self.pictureDic objectForKey:@"list_thumb_picture"]];
            [newPic addObject:[self.pictureDic objectForKey:@"newsfeed_thumb_picture"]];
            [timePic addObject:[self.pictureDic objectForKey:@"timeline_thumb_picture"]];
            [picId addObject:[self.pictureDic objectForKey:@"_id"]];
        
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"FEED_INFO_UPDATE" object:Nil];
        
    }failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error:%@",error);
     }];
    
}
- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    DetailtouchViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailTouch"];
    NSLog(@"%ld", gesture.accessibilityElementCount);
    //nextVC.detailImg= gesture.view;
    [self.navigationController pushViewController: (UIViewController *)nextVC animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   // NSLog(@"%@", self.imgName);
    data = [[NSMutableArray alloc]init];
    NSURL *pro = [NSURL URLWithString:proPic];
    [self.profileImg setImageWithURL:pro];
    self.userName.text = nickName;
    self.date.text = date;
    self.shortAddr.text = shortAddr;
    self.detailAddr.text = detailAddr;
    self.likeCnt.text = [NSString stringWithFormat:@"%ld",likeCnt];
    self.comCnt.text = [NSString stringWithFormat:@"%ld", comCnt];
    self.message.text = message;
    
    float width = self.scrollView.bounds.size.width;
    float height = self.scrollView.bounds.size.height;
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(width * allCount, height);
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(130, 400, 60, 40)];
    [self.view addSubview:pageControl];
    pageControl.numberOfPages = allCount;
    
    loadedPageCount = 0;
    [self loadContentsPage:0];
    [self loadContentsPage:1];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.scrollView addGestureRecognizer:singleTap];
//    self.toolBar.frame = CGRectMake(0,SCREEN_FRAME.size.height-self.toolBar.frame.size.height,SCREEN_FRAME.size.width,self.toolBar.frame.size.height);
//    self.toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.scorll.contentSize = CGSizeMake(320, 1000);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
