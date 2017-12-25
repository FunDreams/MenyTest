//
//  TableViewCell_Adress.m
//  ManyFlowers
//
//  Created by Konstantin on 30.12.15.
//  Copyright © 2015 Olga. All rights reserved.
//

#import "TableViewCell_Adress.h"

@implementation TableViewCell_Adress
@synthesize tAdress,imageLine,Back,BackButton,ButtonClose,ImgCheck;

- (id)init {
    self = [super init];
    if (self) {
        tAdress=[[UITextField alloc]init];
        
        tAdress.frame=CGRectMake(30, 11, 210, 10/*SIZE_ADRES_CELL*/);
        [self.contentView addSubview:tAdress];

        Back=[[UIImageView alloc]init];
        Back.frame=CGRectMake(0,0,260,32);
        [Back setImage:[UIImage imageNamed:@"bg-selest-green.png"]];
        [self.contentView addSubview:Back];
        Back.hidden=YES;

        BackButton=[[UIImageView alloc]init];
        BackButton.frame=CGRectMake(228,0,32,32);
        [BackButton setImage:[UIImage imageNamed:@"Rectangle_adres.png"]];
        [self.contentView addSubview:BackButton];
        BackButton.hidden=YES;

        imageLine=[[UIImageView alloc]init];
        imageLine.frame=CGRectMake(0,31,260,1);
        [imageLine setImage:[UIImage imageNamed:@"LineCell.png"]];
        [self.contentView addSubview:imageLine];

        ImgCheck=[[UIImageView alloc]init];
        ImgCheck.frame=CGRectMake(8,8,15,15);
        [ImgCheck setImage:[UIImage imageNamed:@"Check_off.png"]];
        [self.contentView addSubview:ImgCheck];

        ButtonClose = [UIButton buttonWithType:UIButtonTypeCustom];
        ButtonClose.frame=CGRectMake(228,0,32,32);
      [ButtonClose setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
      [ButtonClose setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:ButtonClose];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
