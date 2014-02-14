//
//  MypageCell.h
//  TeamProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MypageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nick;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UILabel *com;
@property (weak, nonatomic) IBOutlet UIImageView *proImg;
@property (weak, nonatomic) IBOutlet UIButton *timeImg;

@end
