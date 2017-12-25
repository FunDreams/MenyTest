//
//  ManyFlowersCell.h
//  ManyFlowers
//
//  Created by Konstantin on 02.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManyFlowersCellFavorits1 : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *vPict;

@property (strong, nonatomic) IBOutlet UILabel *lName;
@property (strong, nonatomic) IBOutlet UILabel *lPrice;
@property (strong, nonatomic) IBOutlet UILabel *lArticle;

@property (strong, nonatomic) IBOutlet UIButton *bBuy;
@property (strong, nonatomic) IBOutlet UIButton *bClose;

@end
