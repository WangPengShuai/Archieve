//
//  PSModel.m
//  Archieve
//
//  Created by wps on 2018/8/30.
//  Copyright © 2018年 wps. All rights reserved.
//

#import "PSModel.h"
#import <objc/runtime.h>

static NSString *Path = @"model";

@implementation PSModel

//归档
- (void)encodeWithCoder:(NSCoder*)aCoder{
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char* name = ivar_getName(ivar);
        NSString* key = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:key] forKey :key];
    }
    free(ivars);
}

//解档
- (id)initWithCoder:(NSCoder*)aDecoder{
    if (self == [super init]) {
        unsigned int count = 0;
        Ivar* ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char* name = ivar_getName(ivar);
            NSString* key = [NSString stringWithUTF8String:name];
            id value =  [aDecoder decodeObjectForKey:key];//根据key拿到value
            [self setValue:value forKey:key];//KVC赋值
        }
        
        free(ivars);
    }
    return self;
}

    
+ (void)cleanArchiveWithKey:(NSString *)key{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/%@", Path, key]];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (void)cleanAllArchiveFile{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@", Path]];
    [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil];
}

+ (void)setArchivePath:(NSString *)path{
    Path = path;
}

@end

@implementation NSObject (PSModel)

+ (id)unarchiveWithKey:(NSString *)key{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/%@", Path, key]];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (void)archiveWithKey:(NSString *)key{
    [self createFileDirectories];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/%@", Path, key]];
    BOOL result = [NSKeyedArchiver archiveRootObject:self toFile:path];
    NSLog(@"%@ %u",path, result);
}

- (void)createFileDirectories{
    NSString *imageDir =  [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@", Path]];
    BOOL isDir =NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir ==YES && existed == YES) ){//如果没有文件夹则创建
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
@end
