//
//  SenCollectionViewCell.m
//  shadowing
//
//  Created by silvon on 12-12-27.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import "SenCollectionViewCell.h"

#define IMGVIEW_V_PADDING 0
#define IMGVIEW_H_PADDING 11

@implementation SenCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImage *img = [UIImage imageNamed:@"1.png"];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        CGRect frame = [imgView frame];
        frame.origin.y = IMGVIEW_V_PADDING;
        frame.origin.x = IMGVIEW_H_PADDING;
        [self addSubview:imgView];
       
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
