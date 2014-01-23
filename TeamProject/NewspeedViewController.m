//
//  NewspeedViewController.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 1. 23..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "NewspeedViewController.h"
#import "PictureCell.h"
#import "Picture2Cell.h"

@interface NewspeedViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView1;


@end

@implementation NewspeedViewController
{
    NSArray *pictureName1;
  
}
- (IBAction)ChooseButton:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    if (control.selectedSegmentIndex == 0) {
        pictureName1 = @[@"photo1.jpg", @"photo2.jpg",@"photo3.jpg",@"photo4.jpg",@"photo5.jpg",@"photo6.jpg" ,@"photo7.jpg", @"photo8.jpg"];
    }
    else if(control.selectedSegmentIndex ==1){
        pictureName1 = @[@"photo3.jpg", @"photo4.jpg",@"photo1.jpg",@"photo2.jpg",@"photo7.jpg",@"photo6.jpg" ,@"photo5.jpg", @"photo8.jpg"];
    }
    [self.CollectionView1 reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FIRST_CELL" forIndexPath:indexPath];

    UIImage *btnImage = [UIImage imageNamed:[pictureName1 objectAtIndex:indexPath.row]];
    [cell.img1 setImage:btnImage forState:UIControlStateNormal];
  
    cell.label1.text = @"잔센스 칸스";
    
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
    pictureName1 = @[@"photo1.jpg", @"photo2.jpg",@"photo3.jpg",@"photo4.jpg",@"photo5.jpg",@"photo6.jpg" ,@"photo7.jpg", @"photo8.jpg"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
