//
//  ViewController.m
//  LGWalkerApp
//
//  Created by walker on 16/5/3.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "ViewController.h"
#import "CustomBackButtonNavController.h"
#import <pop/pop.h>

@interface ViewController ()
@property (nonatomic,strong)UIView  *baseView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"showOrHideTabbar"
                                                       object:nil
                                                     userInfo:@{@"show":@YES}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"home";
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
    [array addObject:@"6"];
    [array addObject:@"8"];
    [array addObject:nil];
    
    NSLog(@"--%@",array);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:nil forKey:@"hello"];
    dict[@"world"] = nil;
    [dict setObject:nil forKey:@"today"];
    NSLog(@"--%@",dict);
    
    _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 320, 0)];
    _baseView.backgroundColor = [UIColor grayColor];
    for (int i =0; i<15; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20*i+10, 320,10)];
        view.backgroundColor = [UIColor whiteColor];
        [_baseView addSubview:view];
    }
    _baseView.clipsToBounds = YES;
    [self.view addSubview:_baseView];
    
}

- (IBAction)btnaction:(id)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        _baseView.frame = CGRectMake(0, 100, 320, 400);
    }];
    
    
}

- (IBAction)ViewControllerUnwindSegue:(UIStoryboardSegue *)unwindSegue {
    NSLog(@"unwindSegue");
}

- (IBAction)edit:(id)sender
{
    [UIView animateWithDuration:0.4 animations:^{
         _baseView.frame = CGRectMake(0, 100, 320, 0);
    }];
    [self performSegueWithIdentifier:@"homeID" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
