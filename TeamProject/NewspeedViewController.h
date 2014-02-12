//
//  NewspeedViewController.h
//  TeamProject
//
//  Created by SDT-1 on 2014. 1. 23..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"
@interface NewspeedViewController : UIViewController <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CGFloat cellWidth;
@property (readwrite,nonatomic)NSMutableDictionary *totalDic;
@property (readwrite,nonatomic)NSDictionary *postCount;
@property (readwrite,nonatomic)NSMutableArray *arrayFeedDic;

-(void)communication;
@end
