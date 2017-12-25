//
//  ManyFlowersCellSales.m
//  ManyFlowers
//
//  Created by Konstantin on 02.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import "CellShop2.h"
#import "ListFlower.h"

@implementation CellShop2
@synthesize bBuyFinish,Line1,Line2,lDelFree,lSaleLeft,lSaleRight,lSumaryPrice,lTotal;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [bBuyFinish setTranslatesAutoresizingMaskIntoConstraints:YES];
    [lSumaryPrice setTranslatesAutoresizingMaskIntoConstraints:YES];
    [lTotal setTranslatesAutoresizingMaskIntoConstraints:YES];
}

@end
