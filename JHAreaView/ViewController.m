//
//  ViewController.m
//  JHAreaView
//
//  Created by jarhom on 2018/2/2.
//  Copyright © 2018年 厦门市京朋传媒有限公司. All rights reserved.
//

#import "ViewController.h"
#import "JHAreaView.h"

@interface ViewController ()

@property (strong, nonatomic) JHArea *province;

@property (strong, nonatomic) JHArea *city;

@property (strong, nonatomic) JHArea *area;

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)btnhandle:(id)sender {
    
    NSInteger level = [self.textfield.text integerValue];
    
    __weak __typeof(self) weakSelf = self;
    [JHAreaView showAreaViewWithTitle:@"收货地址" provinceId:self.province.regionCode cityId:self.city.regionCode areaId:self.area.regionCode level:level selectBlock:^(JHArea *province, JHArea *city, JHArea *area) {
        weakSelf.province = province;
        weakSelf.city = city;
        weakSelf.area = area;
        [weakSelf.btn setTitle:[NSString stringWithFormat:@"%@%@%@",province.regionName?:@"",city.regionName?:@"",area.regionName?:@""] forState:UIControlStateNormal];
    } cancelBlock:^{
        
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


@end
