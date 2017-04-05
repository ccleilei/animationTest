//
//  RoutViewController.m
//  Annimation
//
//  Created by 晓磊 on 17/3/30.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "RoutViewController.h"
#import "HHRouter.h"
@interface RoutViewController ()

@end

@implementation RoutViewController
+(void)load{
    [[HHRouter shared] map:@"test//:rout" toControllerClass:[self class]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor redColor];
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
