//
//  ViewController.m
//  Annimation
//
//  Created by 晓磊 on 17/1/11.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "ViewController.h"
#import "HHRouter.h"
#import "RacViewController.h"
#import "ViewControllerModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray* titles;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    VIewModel=[[ViewControllerModel alloc] init];
    VIewModel.tableData=[NSArray arrayWithObjects:@"rac",@"事件响应",@"路由",@"animation", nil];
    UITableView* table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];

    [self.navigationController pushViewController:[[HHRouter shared] matchController:@"test//:rout"] animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return VIewModel.tableData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=[VIewModel.tableData objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [VIewModel tableSelectTable:indexPath compelte:^(UIViewController *controller) {
        [self.navigationController pushViewController:controller animated:YES];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
