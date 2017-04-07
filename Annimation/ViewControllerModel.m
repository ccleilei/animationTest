//
//  ViewControllerModel.m
//  Annimation
//
//  Created by 晓磊 on 17/4/6.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "ViewControllerModel.h"
#import "RacViewController.h"
@implementation ViewControllerModel
-(void)tableSelectTable:(NSIndexPath *)path compelte:(void (^)(UIViewController *))endBlock{
    NSString* str=[_tableData objectAtIndex:path.row];
    if ([str isEqualToString:@"rac"]) {
        RacViewController* new=[[RacViewController alloc] init];
        endBlock(new);
    }
}
@end
