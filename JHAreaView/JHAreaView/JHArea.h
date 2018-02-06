//
//  JHArea.h
//  JHAreaView
//
//  Created by jarhom on 2018/2/2.
//  Copyright © 2018年 厦门市京朋传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface JHArea : NSObject

//地区id
@property (strong, nonatomic) NSString *regionCode;
//地区名
@property (strong, nonatomic) NSString *regionName;

//下级区域
@property (strong, nonatomic) NSArray <JHArea *>*subList;

@end
