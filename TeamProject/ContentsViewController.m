//
//  ContentsViewController.m
//  TeamProject
//
//  Created by hongik on 2014. 1. 16..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "ContentsViewController.h"
#define IMAGE_NUM 5

@interface ContentsViewController () <UIActionSheetDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>{
    UIPageControl *pageControl;
    int loadedPageCount;
}

@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ContentsViewController{
    NSMutableArray *data;
}

- (void)loadContentsPage:(int)pageNo{
    if(pageNo <0 || pageNo < loadedPageCount || pageNo >= IMAGE_NUM)
        return;
    float width = self.scrollView.frame.size.width;
    float height = self.scrollView.frame.size.height;
    
    NSString *fileName = [NSString stringWithFormat:@"photo%d",pageNo];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(width * pageNo, 0, width, height);
    [self.scrollView addSubview:imageView];
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
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COMMENT_CELL"];
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
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
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([data count]-1) inSection:0];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   // NSLog(@"%@", self.imgName);
    data = [[NSMutableArray alloc]init];
    
    float width = self.scrollView.bounds.size.width;
    float height = self.scrollView.bounds.size.height;
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(width * IMAGE_NUM, height);
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(130, 400, 60, 40)];
    [self.view addSubview:pageControl];
    pageControl.numberOfPages = IMAGE_NUM;
    
    loadedPageCount = 0;
    [self loadContentsPage:0];
    [self loadContentsPage:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
