//
//  DetailCell.h
//  TeamProject
//
//  Created by SDT-1 on 2014. 2. 13..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commentImg;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *comment;

@end
