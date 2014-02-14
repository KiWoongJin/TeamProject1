//
//  Newspeed3ViewController.h
//  TeamProject
//
//  Created by SDT-1 on 2014. 2. 12..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"

@interface Newspeed3ViewController : UIViewController<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic) CGFloat cellWidth;
@property (readwrite,nonatomic)NSMutableDictionary *totalDic;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

-(void)communication;


@end
