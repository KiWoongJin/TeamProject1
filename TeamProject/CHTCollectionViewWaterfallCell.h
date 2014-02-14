//
//  UICollectionViewWaterfallCell.h
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Newspeed.h"
#import "AFNetworking.h"
#import "ThumbDelegate.h"


@interface CHTCollectionViewWaterfallCell : UICollectionViewCell
@property (nonatomic, copy) NSString *displayString;
@property (weak)id <ThumbDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIButton *imgBtn;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn2;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn3;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn4;
@property (weak, nonatomic) IBOutlet UIImageView *proImage1;
@property (weak, nonatomic) IBOutlet UIImageView *proImage2;
@property (weak, nonatomic) IBOutlet UIImageView *proImage3;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickName2;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *nickName3;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel3;

@property (weak, nonatomic) IBOutlet UILabel *likeCnt;
@property (weak, nonatomic) IBOutlet UILabel *comCnt;
@property (weak, nonatomic) IBOutlet UILabel *likeCnt2;
@property (weak, nonatomic) IBOutlet UILabel *comCnt2;
@property (weak, nonatomic) IBOutlet UILabel *likeCnt3;
@property (weak, nonatomic) IBOutlet UILabel *comCnt3;


@end
