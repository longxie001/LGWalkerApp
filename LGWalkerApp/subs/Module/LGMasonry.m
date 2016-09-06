//
//  LGMasonry.m
//  LGWalkerApp
//
//  Created by Walker on 16/8/30.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "LGMasonry.h"
#import "Masonry.h"

@interface LGMasonry ()
@property (nonatomic,strong)UIView *redView;
@property (nonatomic,strong)UIView *greenView;
@property (nonatomic,strong)UIView *blueView;
@end

@implementation LGMasonry

- (UIView *)redView{
    if (!_redView) {
        _redView = [[UIView alloc]init];
        _redView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_redView];
    }
    return _redView;
}

- (UIView *)greenView{
    if (!_greenView) {
        _greenView = [[UIView alloc]init];
        _greenView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_greenView];
    }
    return _greenView;
}

- (UIView *)blueView{
    if (!_blueView) {
        _blueView = [[UIView alloc]init];
        _blueView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_blueView];
    }
    return _blueView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass([self class]);
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(100);
        make.left.mas_equalTo(self.view).offset(20);
        make.top.mas_equalTo(self.view).offset(80);
    }];
    
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(100, 80)]);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.redView);
    }];
    
    [self.blueView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.redView);
        make.height.equalTo(self.greenView);
        make.top.equalTo(self.redView.bottom).offset(20);
        make.right.equalTo(self.greenView.left).offset(-20);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
