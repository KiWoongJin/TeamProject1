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

#define CELL_WIDTH 150
#define CELL_COUNT 8
#define CELL_IDENTIFIER @"TEST_CELL"

@interface NewspeedViewController ()
@property (nonatomic, strong) NSMutableArray *cellHeights;
@end

@implementation NewspeedViewController
{
    NSArray *pictureName1;
  
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
            
            _cellHeights[i] =@((tmp.size.height*150)/tmp.size.width) ;
        }
    }
    return _cellHeights;
}

- (IBAction)ChooseButton:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    if (control.selectedSegmentIndex == 0) {
        pictureName1 = @[@"photo1.jpg", @"photo2.jpg",@"photo3.jpg",@"photo4.jpg",@"photo5.jpg",@"photo6.jpg" ,@"photo7.jpg", @"photo8.jpg"];
    }
    else if(control.selectedSegmentIndex ==1){
        pictureName1 = @[@"photo3.jpg", @"photo4.jpg",@"photo1.jpg",@"photo2.jpg",@"photo7.jpg",@"photo6.jpg" ,@"photo5.jpg", @"photo8.jpg"];
    }
  
    //[self.collectionView reloadData];
    [self.view addSubview:self.collectionView];
      [self updateLayout];
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
    //cell.displayString = [NSString stringWithFormat:@"%d", indexPath.row];
    
    // cell.displayLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    cell.imgView.image =[UIImage imageNamed:[pictureName1 objectAtIndex:indexPath.row]];
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
	// Do any additional setup after loading the view.
    pictureName1 = @[@"photo1.jpg", @"photo2.jpg",@"photo3.jpg",@"photo4.jpg",@"photo5.jpg",@"photo6.jpg" ,@"photo7.jpg", @"photo8.jpg"];
    [self.view addSubview:self.collectionView];
    [self updateLayout];
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
