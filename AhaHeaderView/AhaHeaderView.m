//
//  AhaHeaderView.m
//  AhaNavigationBar
//
//  Created by haiwei on 16/1/17.
//  Copyright © 2016年 vvli. All rights reserved.
//

#import "AhaHeaderView.h"
#import "UIView+SDAutoLayout.h"


@interface AhaHeaderView ()
{
    CGFloat _viewWidth;
    CGFloat _viewHeight;
}

@property (nonatomic, strong) UIImageView * imgView;

@end


@implementation AhaHeaderView


- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        _viewWidth = frame.size.width;
        _viewHeight = frame.size.height;
        
        [self setupImgView:frame];
    }
    return self;
}

- (void)setupImgView:(CGRect)frame {
    
    self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.clipsToBounds = YES;
    
    [self addSubview:self.imgView];
}



- (void)setupImage:(UIImage *)img {
    
    self.imgView.image = img;
}


- (void)setupOffsetY:(CGFloat)y {
    
    self.imgView.frame = CGRectMake(0, y, _viewWidth, _viewHeight - y);
}

@end
