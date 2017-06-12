//
//  ViewController.m
//  HMAnmRotate
//
//  Created by w on 2017/6/12.
//  Copyright © 2017年 qmy3. All rights reserved.
//

#import "ViewController.h"
#import "HMLoadingView.h"
@interface ViewController ()
{
    
    HMLoadingView * _lv;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HMLoadingView *loadingView = [HMLoadingView loadingViewWithFrame:self.view.bounds];
//    HMLoadingView.frame = CGRectMake(50, 100, 100, 100);
    [self.view addSubview:loadingView];
    [loadingView startAnimation];
    
    _lv = loadingView;
}
- (IBAction)onClick:(id)sender {
    [_lv reAnm];
}

@end
