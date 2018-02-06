//
//  JHAreaView.m
//  JHAreaView
//
//  Created by jarhom on 2018/2/2.
//  Copyright © 2018年 厦门市京朋传媒有限公司. All rights reserved.
//

#import "JHAreaView.h"
#import "JHAreaSegmentView.h"
#import "JHAreaListVC.h"

#define JHScreenWidth [[UIScreen mainScreen] bounds].size.width
#define JHScreenHeight [[UIScreen mainScreen] bounds].size.height

#define JHBoardHeight 320.f
#define JHTopHeight 60.f


@interface JHAreaView()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,JHAreaListVCDelegate,JHAreaSegmentViewDelegate>

@property (strong, nonatomic) UIPageViewController *pageVC;

@property (strong, nonatomic) UIView *boardView;

@property (strong, nonatomic) JHAreaSegmentView *segmentView;

@property (strong, nonatomic) JHAreaListVC *listVC_0;
@property (strong, nonatomic) JHAreaListVC *listVC_1;
@property (strong, nonatomic) JHAreaListVC *listVC_2;


/** 1.省数组 */
@property (nonatomic, strong, nullable)NSArray *arrayProvince;
/** 2.当前城市数组 */
@property (nonatomic, strong, nullable)NSArray *arrayCity;
/** 3.当前地区数组 */
@property (nonatomic, strong, nullable)NSArray *arrayArea;


@end

static JHAreaView *areaView = nil;

@implementation JHAreaView


+ (void)showAreaViewWithTitle:(NSString *)title
                   provinceId:(NSString *)provinceId
                       cityId:(NSString *)cityId
                       areaId:(NSString *)areaId
                        level:(NSInteger)level
                  selectBlock:(void(^)(JHArea *province, JHArea *city, JHArea *area))selectBlock
                  cancelBlock:(void(^)(void))cancelBlock {
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    areaView = [[JHAreaView alloc] initWithFrame:CGRectMake(0, 0, JHScreenWidth, JHScreenHeight)];
    areaView.level = level;
    areaView.segmentView.title = title;
    areaView.didSelectArea = selectBlock;
    areaView.didCancelSelect = cancelBlock;
    
    if (provinceId) {
        for (JHArea *province in areaView.arrayProvince) {
            if ([provinceId isEqualToString:province.regionCode]) {
                areaView.selectProvince = province;
                if (cityId) {
                    for (JHArea *city in province.subList) {
                        if ([cityId isEqualToString:city.regionCode]) {
                            areaView.selectCity = city;
                            if (areaId && city.subList.count>0) {
                                for (JHArea *area in city.subList) {
                                    if ([areaId isEqualToString:area.regionCode]) {
                                        areaView.selectArea = area;
                                    }
                                }
                            }
                        }
                    }
                }
                
                break;
            }
        }
        [areaView setupData];
    }
    
    
    
    [window addSubview:areaView];
    
    [UIView animateWithDuration:0.25 animations:^{
        areaView.boardView.frame = CGRectMake(0, JHScreenHeight - JHBoardHeight, JHScreenWidth, JHBoardHeight);
        areaView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    }];
}

- (void)hideAreaView {
    
    [UIView animateWithDuration:0.25 animations:^{
        areaView.boardView.frame = CGRectMake(0, JHScreenHeight, JHScreenWidth, JHBoardHeight);
        areaView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [areaView removeFromSuperview];
        areaView = nil;
    }];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubViews];
        [self setupData];
    }
    return self;
}

- (void)setupSubViews {
    UIView *boardView = [[UIView alloc] initWithFrame:CGRectMake(0, JHScreenHeight, JHScreenWidth, JHBoardHeight)];
    boardView.backgroundColor = [UIColor whiteColor];
    [self addSubview:boardView];
    self.boardView = boardView;
    
    JHAreaSegmentView *segmentView = [[JHAreaSegmentView alloc] initWithFrame:CGRectMake(0, 0, JHScreenWidth, 60)];
    segmentView.delegate = self;
    [self.boardView addSubview:segmentView];
    self.segmentView = segmentView;
    
    UIPageViewController *pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageVC.delegate = self;
    pageVC.dataSource = self;
    pageVC.view.frame = CGRectMake(0, 60, JHScreenWidth, CGRectGetHeight(self.boardView.frame)-60);
    [self.boardView addSubview:pageVC.view];
    self.pageVC = pageVC;
    
}

- (void)setupData {
    if (self.selectArea) {
        [self.pageVC setViewControllers:@[self.listVC_2] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        [self.segmentView setupAreaName:@[self.selectProvince.regionName,self.selectCity.regionName,self.selectArea.regionName]];
        [self.segmentView selectIndex:2];
    } else if (self.selectCity) {
        [self.pageVC setViewControllers:@[self.listVC_1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        [self.segmentView setupAreaName:@[self.selectProvince.regionName,self.selectCity.regionName]];
        [self.segmentView selectIndex:1];
    } else if (self.selectProvince){
        [self.pageVC setViewControllers:@[self.listVC_0] direction:0 animated:NO completion:nil];
        [self.segmentView setupAreaName:@[self.selectProvince.regionName]];
        [self.segmentView selectIndex:0];
    } else {
        [self.pageVC setViewControllers:@[self.listVC_0] direction:0 animated:NO completion:nil];
        [self.segmentView setupAreaName:@[@"请选择"]];
        [self.segmentView selectIndex:0];
    }
    
    
}

#pragma mark - UIPageViewControllerDataSource <NSObject>

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (viewController == self.listVC_2) {
        return self.listVC_1;
    } else if (viewController == self.listVC_1) {
        return self.listVC_0;
    }
    return nil;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.listVC_0 == viewController && self.selectProvince) {
        return self.listVC_1;
    } else if (self.listVC_1 == viewController && self.selectCity) {
        return self.listVC_2;
    }
    return nil;
}

#pragma mark - UIPageViewControllerDelegate <NSObject>
// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (finished && completed) {
        
        UIViewController *vc = [self.pageVC.viewControllers firstObject];
        if (vc == self.listVC_0) {
            [self.segmentView selectIndex:0];
        } else if (vc == self.listVC_1) {
            [self.segmentView selectIndex:1];
        } else if (vc == self.listVC_2) {
            [self.segmentView selectIndex:2];
        }
        
    }
}



#pragma mark - JHAreaListVCDelegate<NSObject>

- (void)listVC:(JHAreaListVC *)vc didSlectArea:(JHArea *)area {
    if (vc == self.listVC_0) {
        self.selectProvince = area;
        self.selectCity = nil;
        self.selectArea = nil;
        
        if (self.level < 2) {
            if (self.didSelectArea)
                self.didSelectArea(self.selectProvince, self.selectCity, self.selectArea);
            
            [self hideAreaView];
            return;
        }
        
        [self.pageVC setViewControllers:@[self.listVC_1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        [self.segmentView setupAreaName:@[self.selectProvince.regionName,@"请选择"]];
        [self.segmentView selectIndex:1];

    } else if (vc == self.listVC_1) {
        self.selectCity = area;
        self.selectArea = nil;
        
        if (self.level < 3) {
            if (self.didSelectArea)
                self.didSelectArea(self.selectProvince, self.selectCity, self.selectArea);
            
            [self hideAreaView];
            return;
        }
        
        [self.pageVC setViewControllers:@[self.listVC_2] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        [self.segmentView setupAreaName:@[self.selectProvince.regionName,self.selectCity.regionName,@"请选择"]];
        [self.segmentView selectIndex:2];

        
    } else if (vc == self.listVC_2 && self.level > 3) {
        self.selectArea = area;
        
        
        if (self.didSelectArea)
            self.didSelectArea(self.selectProvince, self.selectCity, self.selectArea);
        
        [self hideAreaView];
        
        
        
    }
    
    
    

}

#pragma mark - JHAreaSegmentViewDelegate<NSObject>

- (void)didTapOnBtnWithIndex:(NSInteger)index {
    if (index == 0) {
        [self.pageVC setViewControllers:@[self.listVC_0]    direction:UIPageViewControllerNavigationDirectionReverse
                               animated:NO completion:nil];
    } else if (index == 1) {
        [self.pageVC setViewControllers:@[self.listVC_1]    direction:UIPageViewControllerNavigationDirectionReverse
                               animated:NO completion:nil];

    } else if (index == 2) {
        [self.pageVC setViewControllers:@[self.listVC_2]    direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO completion:nil];
    }
}

- (void)didTapClose {
    [self hideAreaView];
}


#pragma mark - --- getters 属性 ---

- (NSArray *)arrayProvince
{
    if (!_arrayProvince) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
        NSArray *list = [[NSArray alloc]initWithContentsOfFile:path];
         _arrayProvince = [NSArray yy_modelArrayWithClass:[JHArea class] json:list];
    }
    return _arrayProvince;
}

- (NSArray *)arrayCity
{
    if (self.selectProvince) {
        _arrayCity = self.selectProvince.subList;
    } else {
        return nil;
    }
    
    return _arrayCity;
}

- (NSArray *)arrayArea
{
    if (self.selectCity) {
        _arrayArea = self.selectCity.subList;
    } else {
        return nil;
    }
    return _arrayArea;
}


- (JHAreaListVC *)listVC_0 {
    if (!_listVC_0) {
        _listVC_0 = [[JHAreaListVC alloc] init];
        _listVC_0.delegate = self;
        _listVC_0.areaList = self.arrayProvince;
    }
    _listVC_0.selectArea = self.selectProvince;

    
    return _listVC_0;
}

- (JHAreaListVC *)listVC_1 {
    if (!_listVC_1) {
        _listVC_1 = [[JHAreaListVC alloc] init];
        _listVC_1.delegate = self;
    }
    _listVC_1.areaList = self.arrayCity;
    _listVC_1.selectArea = self.selectCity;
    
    return _listVC_1;
}

- (JHAreaListVC *)listVC_2 {
    if (!_listVC_2) {
        _listVC_2 = [[JHAreaListVC alloc] init];
        _listVC_2.delegate = self;
    }
    _listVC_2.areaList = self.arrayArea;
    _listVC_2.selectArea = self.selectArea;
    
    return _listVC_2;
}




@end
