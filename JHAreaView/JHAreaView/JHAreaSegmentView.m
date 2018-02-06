//
//  JHAreaSegmentView.m
//  JHAreaView
//
//  Created by jarhom on 2018/2/2.
//  Copyright © 2018年 厦门市京朋传媒有限公司. All rights reserved.
//

#import "JHAreaSegmentView.h"

@interface JHAreaSegmentView()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *closeBtn;

@property (strong, nonatomic) UIView *segmentBoardView;

@property (strong, nonatomic) UIView *line;

@property (strong, nonatomic) NSArray *areaList;



@end

@implementation JHAreaSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self layoutBoardViews];
    }
    
    return self;
}

- (void)setupAreaName:(NSArray <NSString *>*)areaList {
    self.areaList = areaList;
    [self layoutBoardViews];
}

- (void)selectIndex:(NSInteger)index {
    self.selectedIndex = index;
    [self setupLine];
}

- (void)setupViews {
   
    _segmentBoardView = [[UIView alloc] init];
    _segmentBoardView.frame = CGRectMake(0, 20, self.frame.size.width, 40);
    [self addSubview:_segmentBoardView];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    bottomLine.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self addSubview:bottomLine];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"请选择地址";
    [_titleLabel sizeToFit];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor colorWithWhite:0.6f alpha:0.8];
    self.titleLabel.center = CGPointMake(self.center.x, 16);
    [self addSubview:_titleLabel];

    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn.frame = CGRectMake(self.frame.size.width - 52, 8, 44, 44);
    [_closeBtn addTarget:self action:@selector(closeHandle:) forControlEvents:UIControlEventTouchUpInside];
    [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [self addSubview:_closeBtn];
}

- (void)setupLine {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor redColor];
        _line.hidden = YES;
        [self addSubview:_line];
    }
    
    UIButton *selectBtn = nil;
    
    for (UIButton *btn in self.segmentBoardView.subviews) {
        btn.selected = btn.tag == self.selectedIndex;
        if (btn.tag == self.selectedIndex) selectBtn = btn;
    }
    
    if (selectBtn) {
        CGFloat width = CGRectGetWidth(selectBtn.frame);
        CGFloat origin_x = CGRectGetMinX(selectBtn.frame);
        
        [UIView animateWithDuration:0.25 animations:^{
            self.line.frame = CGRectMake(origin_x+10, self.frame.size.height - 3, width - 20, 2);
        } completion:^(BOOL finished) {
            self.line.hidden = NO;
        }];
        
    }
}


- (void)layoutBoardViews {
    if (self.title) {
        self.titleLabel.text = self.title;
        [self.titleLabel sizeToFit];
    }
    
    self.segmentBoardView.frame = CGRectMake(0, 20, self.frame.size.width, 40);
    
    NSArray *subviews = self.segmentBoardView.subviews;
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    
    if (self.areaList.count>0) {
        NSInteger index = 0;
        CGFloat origin_x = 8;
        for (NSString *title in self.areaList) {
            UIButton *btn = [self createBtnWithTitle:title];
            btn.tag = index;
            
            CGRect frame = btn.frame;
            frame.size.width += 20;
            frame.origin.x = origin_x;
            frame.origin.y = 0;
            frame.size.height = self.segmentBoardView.frame.size.height;
            btn.frame = frame;
            
            
            [self.segmentBoardView addSubview:btn];
            
            
            index++;
            origin_x = CGRectGetMaxX(btn.frame) + 5;
        }
    }
    
}


- (UIButton *)createBtnWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(areaTitleTap:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn sizeToFit];
    
    return btn;
}

#pragma mark -

- (void)closeHandle:(UIButton *)btn {
    [self.delegate didTapClose];
}

- (void)areaTitleTap:(UIButton *)btn {
    [self.delegate didTapOnBtnWithIndex:btn.tag];
    [self selectIndex:btn.tag];
}





@end
