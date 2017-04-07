//
//  ViewControllerModel.h
//  Annimation
//
//  Created by 晓磊 on 17/4/6.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ViewControllerModel : NSObject
@property(nonatomic,strong)NSArray* tableData;
-(void)tableSelectTable:(NSIndexPath*)path compelte:(void(^)(UIViewController* controller))endBlock;
@end
