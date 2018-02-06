//
//  JHAreaListVC.h
//  JHAreaView
//
//  Created by jarhom on 2018/2/2.
//  Copyright © 2018年 厦门市京朋传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHArea.h"

@class JHAreaListVC;

@protocol JHAreaListVCDelegate<NSObject>

- (void)listVC:(JHAreaListVC *)vc didSlectArea:(JHArea *)area;

@end


@interface JHAreaListVC : UITableViewController

@property (strong, nonatomic) NSArray *areaList;

@property (strong, nonatomic) JHArea *selectArea;

@property (weak, nonatomic) id<JHAreaListVCDelegate>delegate;


@end
