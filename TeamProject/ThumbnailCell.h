//
//  ThumbnailCell.h
//  TeamProject
//
//  Created by SDT-1 on 2014. 1. 28..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbDelegate.h"

@interface ThumbnailCell : UICollectionViewCell
@property (weak)id <ThumbDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;


@end
