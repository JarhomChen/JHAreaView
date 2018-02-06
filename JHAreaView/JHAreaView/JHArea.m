//
//  JHArea.m
//  JHAreaView
//
//  Created by jarhom on 2018/2/2.
//  Copyright © 2018年 厦门市京朋传媒有限公司. All rights reserved.
//

#import "JHArea.h"

@implementation JHArea


- (NSUInteger)hash {
    return [self yy_modelHash];
}
- (BOOL)isEqual:(id)object {
    
    if (self == object) return YES;
    if (![object isMemberOfClass:self.class]) return NO;
    if ([self hash] != [object hash]) return NO;
    
    JHArea *model = object;
    
    if ([model.regionCode isEqual:self.regionCode]) {
        return YES;
    }
    
    return NO;
    

    
    
    
}
- (NSString *)description {
    return [self yy_modelDescription];
}

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {

    return @{@"subList":[JHArea class]};
}

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"subList":@[@"cityList",@"areaList"]};
}

@end
