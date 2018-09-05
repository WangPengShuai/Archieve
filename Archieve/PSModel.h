//
//  PSModel.h
//  Archieve
//
//  Created by wps on 2018/8/30.
//  Copyright © 2018年 wps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSModel : NSObject<NSCoding>

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

+ (void)cleanArchiveWithKey:(NSString *)key;
+ (void)cleanAllArchiveFile;

+ (void)setArchivePath:(NSString *)path;    //Default is [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/model"]

@end

@interface NSObject(PSModel)

+ (id)unarchiveWithKey:(NSString *)key;
- (void)archiveWithKey:(NSString *)key;

@end
