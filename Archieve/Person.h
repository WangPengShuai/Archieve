//
//  Person.h
//  Archieve
//
//  Created by wps on 2018/8/30.
//  Copyright © 2018年 wps. All rights reserved.
//

#import "PSModel.h"

@interface Person : PSModel

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *area;

@end
