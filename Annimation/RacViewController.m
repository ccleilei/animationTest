//
//  RacViewController.m
//  Annimation
//
//  Created by 晓磊 on 17/4/6.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "RacViewController.h"
#import <ReactiveCocoa.h>
@interface RacViewController ()
{
    UITextField* passTextfield;
    UITextField* nameTextfield;
    UIButton* loginBn;
}
@end

@implementation RacViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nameTextfield=[[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    [nameTextfield setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:nameTextfield];
    
   passTextfield=[[UITextField alloc] initWithFrame:CGRectMake(100, 150, 200, 40)];
    [passTextfield setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:passTextfield];
    
    loginBn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBn.frame=CGRectMake(100, 200, 200, 40);
    [loginBn setBackgroundColor:[UIColor grayColor]] ;
    [self.view addSubview:loginBn];
   // [self CombinRAC];
    [self contact];
}
//bind 订阅原信号 在nextBlick根据bock装换成新信号并订阅 在新订阅的NextBlock中将指传递给新的subscriber，并调用sendnext

//将信号前后衔接起来 订阅原信号在complete block里面订阅2信号
-(void)contact{
    RACSignal* signal1=[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"1"];
       
       return [RACDisposable disposableWithBlock:^{
           
       }];
    }];
    
    RACSignal* signal2=[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"3"];
        [subscriber sendNext:@"4"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    [[signal1 concat: signal2] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}
//zipWith 订阅信号1 订阅信号2 在nextblock中当存储值 当都有值是组合后传递给新signal的subscribe，并调用sendnext
-(void)clickLog{
    NSLog(@"login");
}

-(void)racFilter{
    [[nameTextfield.rac_textSignal filter:^BOOL(id value) {
        NSString*str=value;
        return str.length>3;
    }]
     subscribeNext:^(id x) {
         NSLog(@"%@",x);
    }];
}
//map 底层调用flatenmap 底层bind 将blck里返回的值打包成新的同类型的singal返回
-(void)racMap{
//    [[racTextfield.rac_textSignal map:^id(NSString* value) {
//        if (value.length>3) {
//            return [UIColor redColor];
//        }
//        return [UIColor whiteColor];
//    }] subscribeNext:^(id x) {
//        racTextfield.backgroundColor=x;
//    }];
  
    RAC(nameTextfield,backgroundColor)=[nameTextfield.rac_textSignal map:^id(NSString* value) {
        if (value.length>3) {
            return [UIColor redColor];
        }
        return [UIColor whiteColor];
    }];
}

-(void)reduceeach{
    RACSignal*signal=[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    [signal reduceEach:^id(NSNumber *num1 , NSNumber *num2){
        return @([num1 intValue]+[num2 intValue]);
    }];

    [signal not];
}
//reduceApply 参数为blck与参数 根据传入的blck和参数 整合结果

-(void)racMerge{
    RACSignal* name=nameTextfield.rac_textSignal;
    RACSignal* pass=passTextfield.rac_textSignal;
    
    [pass flattenMap:^RACStream *(id value) {
        return nil;
    }];
    [[RACSignal merge:@[name,pass]] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }
];
    
}
-(void)CombinRAC{
    [[loginBn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self clickLog];
    }];

    
    RACSignal* nameSIgn=[nameTextfield.rac_textSignal map:^id(NSString* value) {
        return  @(value.length>3);
    }];
    RACSignal* passSign=[passTextfield.rac_textSignal map:^id(NSString* value)  {
        return @(value.length>3);
    }];
    RACSignal* combin=[RACSignal combineLatest:@[nameSIgn,passSign] reduce:^id(NSNumber* name,NSNumber*pass){
        return @([name boolValue]&&[pass boolValue]);
    }];
    RAC(loginBn,enabled)=combin;
    
   [[combin map:^id(id value) {
        if ([value boolValue]) {
            return [UIColor greenColor];
        }
        return [UIColor grayColor];
    }]
        subscribeNext:^(UIColor* x) {
            [loginBn setBackgroundColor:x];
        }
    ];
}
-(void)RACSequencee{
    RACSequence *numbers=[@"1 2 3 4 5 6 7 8 9"componentsSeparatedByString:@" "].rac_sequence;

    RACSequence*new= [numbers flattenMap:^RACStream *(id value) {
        NSLog(@"%@",value);
        return [RACSequence return:value];
    }];
    [new.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}
-(void)ButtonRac{
    [[loginBn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self clickLog];
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
