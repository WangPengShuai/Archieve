//
//  ViewController.m
//  Archieve
//
//  Created by wps on 2018/8/30.
//  Copyright © 2018年 wps. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "BDLocalModelAgent.h"

@interface ViewController ()
@property (nonatomic, strong) BDLocalModelAgent *agent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 10; i ++) {
        Person *p = [[Person alloc] init];
        p.name = [NSString stringWithFormat:@"我是%d",i];
        p.age  = [NSString stringWithFormat:@"年龄%d",i];
        p.area = [NSString stringWithFormat:@"地区%d",i];
        [array addObject:p];
    }
    //缓存
    self.agent = [[BDLocalModelAgent alloc] init];
    self.agent.domain = @"233333";
    [self.agent removeAllInfos];
    [self.agent addInfos:array];
    [self.agent saveInfos];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (Person *w in self.agent.list) {
        NSLog(@"%@",w.name);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
