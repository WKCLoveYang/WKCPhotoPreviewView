//
//  ViewController.m
//  Demo
//
//  Created by wkcloveYang on 2019/8/27.
//  Copyright © 2019 wkcloveYang. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <WKCPhotoPreviewView.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) WKCPhotoPreviewView * perviewview;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _perviewview = [[WKCPhotoPreviewView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_perviewview];
    _perviewview.image = [UIImage imageNamed:@"2"];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-40);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
}

- (void)buttonAction:(UIButton *)sender
{
    self.imageView.image = _perviewview.image;
    _perviewview.hidden = YES;
}

@end
