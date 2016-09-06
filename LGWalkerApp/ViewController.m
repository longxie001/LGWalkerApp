//
//  ViewController.m
//  LGWalkerApp
//
//  Created by walker on 16/5/3.
//  Copyright © 2016年 LGwalker. All rights reserved.
//

#import "ViewController.h"
#import <pop/pop.h>
#import "LGCustomPayView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIView  *baseView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic,strong)LGCustomPayView *payView;
@property (nonatomic,strong)NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

static NSString *cellid = @"cellid";
@implementation ViewController

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"LGMasonry",
                       @"PopAnimation",
                       @"Others"];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.rowHeight = 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (IBAction)edit:(id)sender
{
    [self performSegueWithIdentifier:@"homeID" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LGBaseViewController *vc = [[NSClassFromString(self.dataArray[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
