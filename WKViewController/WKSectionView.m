//
//  WKSectionView.m
//  WKViewController
//
//  Created by macairwkcao on 15/10/30.
//  Copyright © 2015年 CWK. All rights reserved.
//

#import "WKSectionView.h"



@implementation WKSectionView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    NSArray *normalImages = @[@"icon_home_localMusic_normal.png",@"icon_home_collection_normal.png",@"icon_home_myPlaylist_normal.png",@"icon_home_musicLibrary_normal.png"];
    NSArray *presslImages = @[@"icon_home_localMusic_press.png",@"icon_home_collection_press.png",@"icon_home_myPlaylist_press.png",@"icon_home_musicLibrary_press.png"];
    NSArray *title = @[@"本地音乐",@"收藏单曲",@"我的歌单",@"音乐库"];
    
    CGFloat width = self.frame.size.width/4.0;
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:normalImages[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor blueColor];
        [button setFrame:CGRectMake((width-40)/2.0+width*i, 30, 40, 40)];
        [button setImage:[UIImage imageNamed:presslImages[i]] forState:UIControlStateHighlighted];
        [self addSubview:button];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width-80)/2.0+width*i, 80, 80, 25)];
        titleLabel.text = title[i];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 创建一个贝塞尔曲线句柄
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
//

    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width, 0) controlPoint:CGPointMake(self.frame.size.width/2,15)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, 0)];


//    [path moveToPoint:CGPointMake(0, 80)];
//        [path moveToPoint:CGPointMake(self.frame.size.width, 80)];
//    [path closePath];
    // 创建描边（Quartz）上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 将此path添加到Quartz上下文中
    CGContextAddPath(context, path.CGPath);
    // 设置本身颜色
    [[UIColor whiteColor] set];
    // 设置填充的路径
    CGContextFillPath(context);
    
    
    
}

@end
