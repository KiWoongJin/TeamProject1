//
//  LikeViewController.h
//  TeamProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"
@interface LikeViewController : UIViewController <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) CGFloat cellWidth;

@end

