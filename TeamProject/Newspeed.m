//
//  Newspeed.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 2. 11..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "Newspeed.h"

@implementation Newspeed
+(id)ptId:(NSInteger)postId postImg:(NSString *)image proImg:(NSString *)proImage nickName:(NSString *)nickName date:(NSDate *)time place:(NSString *)place likeCnt:(NSInteger)likeCnt comCnt:(NSInteger)comCnt{
    
    Newspeed *post = [[Newspeed alloc]init];
    
    post.postId = postId;
    post.image = image;
    post.proImage = proImage;
    post.nickName = nickName;
    post.time = time;
    post.place = place;
    post.likeCnt = likeCnt;
    post.comCnt = comCnt;
    
    return post;
}

-(id)   init
{
    self=[super init];
    if(self)
    {
        
    }
    
    return self;
}

@end
