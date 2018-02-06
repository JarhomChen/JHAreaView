//
//  JHAreaSegmentView.h
//  JHAreaView
//
//  Created by jarhom on 2018/2/2.
//  Copyright © 2018年 厦门市京朋传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHAreaSegmentViewDelegate<NSObject>

- (void)didTapOnBtnWithIndex:(NSInteger)index;

- (void)didTapClose;

@end


@interface JHAreaSegmentView : UIView

@property (strong, nonatomic) NSString *title;

@property (nonatomic) NSInteger selectedIndex;

@property (weak, nonatomic) id<JHAreaSegmentViewDelegate>delegate;


- (void)setupAreaName:(NSArray <NSString *>*)areaList;

- (void)selectIndex:(NSInteger)index;


@end
