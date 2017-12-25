//
//  ManyFlowersCell.h
//  ManyFlowers
//
//  Created by Konstantin on 02.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListFlower;
@interface CellShop2 : UITableViewCell
{
@public
    ListFlower *pParent;
}

@property (strong, nonatomic) IBOutlet UIImageView *Line1;
@property (strong, nonatomic) IBOutlet UIImageView *Line2;

@property (strong, nonatomic) IBOutlet UILabel *lDelFree;
@property (strong, nonatomic) IBOutlet UILabel *lSaleLeft;
@property (strong, nonatomic) IBOutlet UILabel *lSaleRight;

@property (strong, nonatomic) IBOutlet UILabel *lTotal;
@property (strong, nonatomic) IBOutlet UILabel *lSumaryPrice;
@property (strong, nonatomic) IBOutlet UIButton *bBuyFinish;

@end
