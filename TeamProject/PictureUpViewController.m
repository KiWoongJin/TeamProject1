//
//  PictureUpViewController.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 1. 24..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "PictureUpViewController.h"
#import "ThumbnailCell.h"
#import "ThumbDelegate.h"
//#define IMAGE_NUM 5

@interface PictureUpViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, ThumbDelegate>{
    UIPageControl *pageControl;
    int loadedPageCount;
    int imageCount;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllView;


@end

@implementation PictureUpViewController{
    NSMutableArray *thArr;
    NSMutableArray *picArr;
    UIPopoverController *popoverController;
}
- (void)loadContentsPage:(int)pageNo{
    if(pageNo <0 || pageNo < loadedPageCount || pageNo >= imageCount)
        return;
    float width = self.scorllView.frame.size.width;
    float height = self.scorllView.frame.size.height;
    
   // NSString *fileName = [NSString stringWithFormat:@"photo%d",pageNo];
   // NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"jpg"];
    UIImage *image = [picArr objectAtIndex:pageNo];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(width * pageNo, 0, width, height);
    [self.scorllView addSubview:imageView];
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

- (IBAction)ShowAction:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:nil otherButtonTitles:@"사 촬영", @"앨범에서 불러오기", nil];
    sheet.tag = 2;
    [sheet showInView:self.view];
}
//- (IBAction)deleteThumb:(id)sender {
//  //  NSIndexPath *indexPath = nil;
//    //NSLog(@"%@", )
//    imageCount --;
//    [thArr removeObjectAtIndex:0];
//    [picArr removeObjectAtIndex:0];
//
//    float width = self.scorllView.bounds.size.width;
//    float height = self.scorllView.bounds.size.height;
//    self.scorllView.contentSize = CGSizeMake(width * imageCount, height);
//    [self loadContentsPage:imageCount-1];
//    pageControl.numberOfPages = imageCount;
//    [self.collectionView reloadData];
//}
- (void)removeImg:(id)sender{
    NSLog(@"%@",sender);
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    NSLog(@"%d", indexPath.row);
    imageCount --;
    [thArr removeObjectAtIndex:indexPath.row];
    [picArr removeObjectAtIndex:indexPath.row];
    
    float width = self.scorllView.bounds.size.width;
    float height = self.scorllView.bounds.size.height;
    self.scorllView.contentSize = CGSizeMake(width * imageCount, height);
    [self loadContentsPage:imageCount-1];
    pageControl.numberOfPages = imageCount;
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [thArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ThumbnailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TH_CELL" forIndexPath:indexPath];
    cell.delegate = self;
    cell.thumbImage.image = [thArr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"오류" message:@"카메라" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
            [alert show];
            return;
        }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:imagePicker animated:YES];
    }
    if (buttonIndex == 1) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:imagePicker animated:YES];
        
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    UIImage *usingImage = (nil == editedImage)? originalImage :editedImage;
  //  self.imageView.image = usingImage;
    [picArr addObject:usingImage];
    [thArr addObject:usingImage];
    imageCount ++;
    [self.collectionView reloadData];
    float width = self.scorllView.bounds.size.width;
    float height = self.scorllView.bounds.size.height;
    self.scorllView.contentSize = CGSizeMake(width * imageCount, height);
    [self loadContentsPage:imageCount-1];
    pageControl.numberOfPages = imageCount;
    
 //   NSLog(@"%d", imageCount);
    [picker dismissModalViewControllerAnimated:YES];
    

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
    thArr = [[NSMutableArray alloc]init];
    picArr = [[NSMutableArray alloc]init];
    imageCount = 0;
    
    float width = self.scorllView.bounds.size.width;
    float height = self.scorllView.bounds.size.height;
    
    self.scorllView.delegate = self;
    self.scorllView.pagingEnabled = YES;
    //self.scorllView.contentSize = CGSizeMake(width * imageCount, height);
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(130, 400, 60, 40)];
    [self.view addSubview:pageControl];
   // pageControl.numberOfPages = imageCount;
    NSLog(@"3%@", self.place2);
    
    loadedPageCount = 0;
   // [self loadContentsPage:0];
   // [self loadContentsPage:1];
   
 
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    self.place.text = self.place2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
