# JHAreaView
仿京东选择 省 - 市 - 区 

本代码基于YYModel，使用前请先引入YYModel


    #import "JHAreaView.h"


    __weak __typeof(self) weakSelf = self;
    [JHAreaView showAreaViewWithTitle:@"收货地址" provinceId:self.province.regionCode cityId:self.city.regionCode areaId:self.area.regionCode level:2 selectBlock:^(JHArea *province, JHArea *city, JHArea *area) {
        weakSelf.province = province;
        weakSelf.city = city;
        weakSelf.area = area;
        [weakSelf.btn setTitle:[NSString stringWithFormat:@"%@%@%@",province.regionName?:@"",city.regionName?:@"",area.regionName?:@""] forState:UIControlStateNormal];
    } cancelBlock:^{
        
    }];
    
    
    
