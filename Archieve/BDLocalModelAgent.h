//
//  LocalModelAgent.h
//  BDKit
//
//  Created by wps on 2018/8/30.
//  Copyright © 2018年 wps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDLocalModelAgent : NSObject

@property (nonatomic, copy) NSString *IDKey;    //默认是 @"ID"
@property (nonatomic, copy) NSString *domain;   //默认是ClassName
@property (nonatomic, assign) BOOL allowRepeat; //允许添加重复的ID 默认是NO
@property (nonatomic, assign) int maxCount;     //-1 表示无限

- (BOOL)isEmpty;

- (NSArray *)list;

- (BOOL)isExistID:(id)ID;   //根据 isEqual: 判断ID是否唯一

- (id)infoWithID:(NSString *)ID;

- (void)addInfoAtHead:(id)info;
- (void)addInfoAtTail:(id)info;

- (void)addInfos:(NSArray *)infos;

- (void)removeID:(id)ID;
- (void)removeInfo:(id)info;
- (void)removeInfoAtIndex:(int)index;
- (void)removeInfos:(NSArray *)infos;

- (void)removeAllInfos;

- (void)saveInfos;

@end
