//
//  ViewController.m
//  AddLabel
//
//  Created by 互动 on 16/4/10.
//  Copyright (c) 2016年 互动. All rights reserved.
//

#import "ViewController.h"
#import "LabelView.h"

@interface ViewController ()
@property(nonatomic,strong)LabelView* labelV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.labelV];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- getter and setter
-(LabelView *)labelV{
    if (_labelV) {
        return _labelV;
    }
    _labelV = [[LabelView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 20)];
    _labelV.backgroundColor = [UIColor yellowColor];
    return _labelV;
}
@end
