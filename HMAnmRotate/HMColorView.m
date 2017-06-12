//
//  HMColorView.m
//  test
//
//  Created by qmy3 on 2017/6/9.
//  Copyright © 2017年 qmy3. All rights reserved.
//

#import "HMColorView.h"

@implementation HMColorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float fw = 10;
        self.layer.cornerRadius = fw*0.5;
        self.frame = CGRectMake(0, 0, fw, fw);
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.backgroundColor = color;
}


@end
