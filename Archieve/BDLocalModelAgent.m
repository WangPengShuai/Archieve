//
//  LocalModelAgent.m
//  BDKit
//
//  Created by wps on 2018/8/30.
//  Copyright © 2018年 wps. All rights reserved.
//

#import "BDLocalModelAgent.h"
#import "PSModel.h"

#define ID_KEY             @"ID"

@interface BDLocalModelAgent()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BDLocalModelAgent

- (id)init {
    if (self = [super init]) {
        self.domain = NSStringFromClass(self.class);
        self.IDKey = ID_KEY;
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSObject unarchiveWithKey:self.domain];
    }
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (BOOL)isEmpty {
    return self.dataArray.count == 0;
}

- (NSArray *)list {
    return self.dataArray;
}

- (BOOL)isExistID:(id)ID {
    id info = [self infoWithID:ID];
    return (info != nil);
}

- (BOOL)isExistInfo:(id)info {
    return [self isExistID:[info valueForKey:self.IDKey]];
}

- (id)infoWithID:(NSString *)ID {
    for (id info in self.dataArray) {
        if ([[info valueForKey:self.IDKey] isEqual:ID]) {
            return info;
        }
    }
    return nil;
}

- (void)addInfoAtHead:(id)info {
    NSParameterAssert([info isKindOfClass:[PSModel class]]);
    
    if (![self isExistInfo:info] ||
        self.allowRepeat) {
        [self.dataArray insertObject:info atIndex:0];
    }
}

- (void)addInfoAtTail:(id)info {
    NSParameterAssert([info isKindOfClass:[PSModel class]]);
    
    if (![self isExistInfo:info] ||
        self.allowRepeat) {
        [self.dataArray addObject:info];
    }
}

- (void)removeUnnecessaryInfo {
    if (_maxCount < 0) {
        return;
    }
    
    if (self.dataArray.count > _maxCount) {
        self.dataArray = [[self.dataArray subarrayWithRange:NSMakeRange(0, _maxCount - 1)] mutableCopy];
    }
}

- (void)addInfos:(NSArray *)infos {
    for (id info in infos) {
        if (![self isExistInfo:info] ||
            self.allowRepeat) {
            [self.dataArray addObject:info];
        }
    }
}

- (void)removeID:(id)ID {
    for (id info in self.dataArray) {
        if ([[info valueForKey:self.IDKey] isEqual:ID]) {
            [self.dataArray removeObject:info];
            break;
        }
    }
}

- (void)removeInfo:(id)info {
    [self removeID:[info valueForKey:self.IDKey]];
}

- (void)removeInfoAtIndex:(int)index {
    [self.dataArray removeObjectAtIndex:index];
}

- (void)removeAllInfos {
    self.dataArray = [NSMutableArray array];
}

- (void)removeInfos:(NSArray *)infos {
    for (id info in infos) {
        [self removeInfo:info];
    }
}

- (void)saveInfos {
    [self.dataArray performSelectorInBackground:@selector(archiveWithKey:) withObject:self.domain];
}

- (void)setDomain:(NSString *)domain {
    if (domain != _domain) {
        _domain = [domain copy];
    }
    
    self.dataArray = nil;
}

@end
