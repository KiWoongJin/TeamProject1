//
//  Newspeed.h
//  TeamProject
//
//  Created by SDT-1 on 2014. 2. 11..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Newspeed : NSObject
@property (readwrite, nonatomic)NSInteger postId;
@property (readwrite, nonatomic)NSString *image;
@property (readwrite, nonatomic)NSString *proImage;
@property (readwrite, nonatomic)NSString *nickName;
@property (readwrite, nonatomic)NSDate *time;
@property (readwrite, nonatomic)NSString *place;
@property (readwrite, nonatomic)NSInteger likeCnt;
@property (readwrite, nonatomic)NSInteger comCnt;

+(id)ptId:(NSInteger)postId postImg:(NSString *)image proImg:(NSString *)proImage nickName:(NSString *)nickName date:(NSDate *)time place:(NSString *)place likeCnt:(NSInteger)likeCnt comCnt:(NSInteger)comCnt;


@end
