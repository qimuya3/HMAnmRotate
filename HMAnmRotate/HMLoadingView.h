//
//  LoadingView.h
//  test
//
//  Created by qmy3 on 2017/6/9.
//  Copyright © 2017年 qmy3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMLoadingView : UIView

+ (instancetype)loadingViewWithFrame:(CGRect)frame;

- (void)startAnimation;

- (void)stopAnimation;

-(void)reAnm;

@end
