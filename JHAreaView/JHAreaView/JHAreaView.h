//
//  JHAreaView.h
//  JHAreaView
//
//  Created by jarhom on 2018/2/2.
//  Copyright © 2018年 厦门市京朋传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHArea.h"

@interface JHAreaView : UIView

//1 只选省份  2、选到市级  3、选到区级
@property (nonatomic) NSUInteger level;

//已选省
@property (strong, nonatomic) JHArea *selectProvince;
//已选市
@property (strong, nonatomic) JHArea *selectCity;
//已选区
@property (strong, nonatomic) JHArea *selectArea;

@property (copy, nonatomic) void (^didSelectArea)(JHArea *province, JHArea *city, JHArea *area);

@property (copy, nonatomic) void (^didCancelSelect)(void);


+ (void)showAreaViewWithTitle:(NSString *)title
                   provinceId:(NSString *)provinceId
                       cityId:(NSString *)cityId
                       areaId:(NSString *)areaId
                        level:(NSInteger)level
                  selectBlock:(void(^)(JHArea *province, JHArea *city, JHArea *area))selectBlock
                  cancelBlock:(void(^)(void))cancelBlock;

@end
