//
//  TableViewCell_Adress.h
//  ManyFlowers
//
//  Created by Konstantin on 30.12.15.
//  Copyright © 2015 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SIZE_ADRES_CELL 32

@interface TableViewCell_Adress : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *tAdress;
@property (strong, nonatomic) IBOutlet UIImageView *imageLine;
@property (strong, nonatomic) IBOutlet UIImageView *Back;
@property (strong, nonatomic) IBOutlet UIImageView *BackButton;
@property (strong, nonatomic) IBOutlet UIImageView *ImgCheck;
@property (strong, nonatomic) IBOutlet UIButton *ButtonClose;


@end
