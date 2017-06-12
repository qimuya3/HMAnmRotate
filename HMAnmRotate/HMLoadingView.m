//
//  HMLoadingView.m
//  test
//
//  Created by qmy3 on 2017/6/9.
//  Copyright © 2017年 qmy3. All rights reserved.
//

#import "HMLoadingView.h"
#import "HMColorView.h"

static const int itemNum = 3;

@interface HMLoadingView () <CAAnimationDelegate>

@property (nonatomic,strong)NSMutableArray *items;

@property (nonatomic,assign)int finishedTime;

@property (nonatomic,assign)BOOL stop;

@end

@implementation HMLoadingView

- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc]init];
    }
    return _items;
}

+ (instancetype)loadingViewWithFrame:(CGRect)frame {
    return [[self alloc]initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        NSArray *colors = @[ [UIColor redColor],[UIColor greenColor], [UIColor yellowColor] ];
        UIColor * tc = [UIColor colorWithRed:135.0/255 green:208.0/255 blue:250.0/255 alpha:1];
        NSArray *colors = @[ tc, tc, tc];
        for (int i = 0 ; i < itemNum; i++) {
            HMColorView *item = [[HMColorView alloc]init];
            [self layoutItem:item andWithIndedx:i];
            item.hidden = YES;
            item.backgroundColor = colors[i];
            [self addSubview:item];
            [self.items addObject:item];
        }
    }
    return self;
}


- (void)startAnimation {
    
    for (UIView *view in self.items) {
        view.hidden = NO;
    }
    [self doAnm];
}

- (void)stopAnimation {
    _stop = YES;
}


-(void) doAnm{
    
    _finishedTime = 0;
    __weak typeof(self) wself = self;
    UIView *rightView = self.items.lastObject;
    UIView *middleView = self.items[1];
    UIView *leftView = self.items.firstObject;
    
    CGPoint lpt = leftView.center;
    CGPoint mpt = middleView.center;
    CGPoint rpt = rightView.center;
    
    float dd = 15;
    {
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.duration = 1;
        
        CGMutablePathRef curvedPath = CGPathCreateMutable();
        
        CGPathMoveToPoint(curvedPath, NULL, lpt.x, lpt.y);
        CGPathAddQuadCurveToPoint(curvedPath, NULL, lpt.x + fabs(lpt.x-mpt.x)/2, lpt.y- dd, mpt.x, mpt.y);
        pathAnimation.path = curvedPath;
        CGPathRelease(curvedPath);
        
        pathAnimation.delegate = self;
        [leftView.layer addAnimation:pathAnimation forKey:@"lpt"];
        
    }
    
    {
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.duration = 1;
        
        CGMutablePathRef curvedPath = CGPathCreateMutable();
        
        CGPathMoveToPoint(curvedPath, NULL, mpt.x, mpt.y);
        CGPathAddQuadCurveToPoint(curvedPath, NULL, mpt.x + fabs(rpt.x-mpt.x)/2, mpt.y+ dd, rpt.x, rpt.y);
        pathAnimation.path = curvedPath;
        CGPathRelease(curvedPath);
        
        pathAnimation.delegate = self;
        [middleView.layer addAnimation:pathAnimation forKey:@"lpt"];
        
    }
    
    {
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.duration = 1;
        
        CGMutablePathRef curvedPath = CGPathCreateMutable();
        
        CGPathMoveToPoint(curvedPath, NULL, rpt.x, rpt.y);
        CGPathAddQuadCurveToPoint(curvedPath, NULL, mpt.x + fabs(rpt.x-mpt.x)/2, mpt.y- dd, mpt.x, mpt.y);
        CGPathAddQuadCurveToPoint(curvedPath, NULL, lpt.x + fabs(lpt.x-mpt.x)/2, mpt.y+ dd, lpt.x, lpt.y);
        pathAnimation.path = curvedPath;
        CGPathRelease(curvedPath);
        
        pathAnimation.delegate = self;
        [rightView.layer addAnimation:pathAnimation forKey:@"lpt"];
    }
    
    [_items removeAllObjects];
    [_items addObject:rightView];
    [_items addObject:leftView];
    [_items addObject:middleView];
}

-(void)reAnm{
    [self doAnm];
}

- (void)animationDidStart:(CAAnimation *)anim{

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    _finishedTime += 1;
    if (_finishedTime == 3 && _stop == NO) {
        for ( int i = 0; i < _items.count ; i++) {
            UIView * view = _items[i];
            [view.layer removeAllAnimations];
            
            [self layoutItem:view andWithIndedx:i];
        }
        __weak typeof(self) ws = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [ws doAnm];
        });
    }
}


- (void)layoutItem:(UIView *)item andWithIndedx:(int)index {
    CGFloat centerX = self.center.x;
    CGFloat centerY = self.center.y;
    CGFloat itemWidth = item.frame.size.width + 5;
    if (index == 1) {
        item.center = self.center;
    }else {
        CGFloat itemCenterX = index > 1 ? centerX + itemWidth : centerX - itemWidth;
        item.center = CGPointMake(itemCenterX, centerY);
    }
}

@end

