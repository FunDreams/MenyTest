//
//  ManyFlowersCell.h
//  ManyFlowers
//
//  Created by Konstantin on 02.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListFlower;

@interface CellShop1 : UITableViewCell
{
@public
    ListFlower *pParent;
}

@property (strong, nonatomic) IBOutlet UIImageView *vPict;
@property (strong, nonatomic) IBOutlet UIImageView *vLine;

@property (strong, nonatomic) IBOutlet UILabel *lDel;
@property (strong, nonatomic) IBOutlet UILabel *lName;
@property (strong, nonatomic) IBOutlet UILabel *lPrice;
@property (strong, nonatomic) IBOutlet UILabel *lArticle;

@property (strong, nonatomic) IBOutlet UIButton *bClose;

@property (nonatomic, weak) IBOutlet UILabel *valueLabel;
@property (nonatomic, weak) IBOutlet UIStepper *stepper;


@end
