//
//  Foundation+SCCategory.m
//  SamClub
//
//  Created by zoyagzhou on 2019/12/19.
//  Copyright © 2019 tencent. All rights reserved.
//

#import "Foundation+SCCategory.h"

@implementation NSArray (SCCategory)
//安全使用数组
-(id)safeObjectAtIndex:(NSUInteger)index
{
    if ([self isKindOfClass:[NSArray class]])
    {
        if (self.count)
        {
            if (self.count>index)
            {
                return self[index];
            }
        }
    }
    
    return nil;
}
@end


@implementation NSDictionary (SCCategory)

// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    
    return [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:path] options:kNilOptions error:nil];
}
@end
