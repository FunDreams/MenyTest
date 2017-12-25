//
//  ManyFlowersCellSales.m
//  ManyFlowers
//
//  Created by Konstantin on 02.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import "CellShop1.h"
#import "ListFlower.h"
#import "FlowersDataCell.h"

@implementation CellShop1


@synthesize lName,lPrice,lArticle,bClose;
@synthesize valueLabel,stepper,vPict,vLine,lDel;


- (id)init {
    self = [super init];
    if (self) {
        stepper.wraps = YES;
        self.stepper.autorepeat = YES;
        
        stepper.maximumValue = 20;
        stepper.minimumValue = 1;

    }
    return self;
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [bClose setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vLine setTranslatesAutoresizingMaskIntoConstraints:YES];
    [lDel setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    for (UIView *view in stepper.subviews) {
        
        if([view isKindOfClass:[UIButton class]]) {
            
//            UIButton *button = (UIButton *)view;
//            [button setImage:[UIImage imageNamed:@"Check_on.png"] forState:UIControlStateNormal];
//            [button setBackgroundImage:[UIImage imageNamed:@"Check_on.png"] forState:UIControlStateNormal];
//            [button setBackgroundImage:[UIImage imageNamed:@"Check_on.png"] forState:UIControlStateHighlighted];
        }
    }
    
    valueLabel.text=@"1";
}

-(IBAction)StepperPlus:(id)sender
{
    FlowersDataCell *pDataCell=[pParent->pDataFlowers->pDataCellsShops objectAtIndex:self.tag];
    pDataCell->NumPiece++;
    valueLabel.text = [NSString stringWithFormat:@"%d", (int)pDataCell->NumPiece];
    [pParent UpdatePrieceInfo];
}

-(IBAction)StepperMinus:(id)sender
{
    FlowersDataCell *pDataCell=[pParent->pDataFlowers->pDataCellsShops objectAtIndex:self.tag];

    pDataCell->NumPiece--;
    if(pDataCell->NumPiece==0)pDataCell->NumPiece=1;
    valueLabel.text = [NSString stringWithFormat:@"%d", (int)pDataCell->NumPiece];

    [pParent UpdatePrieceInfo];
}

- (IBAction)ValueChange:(UIStepper *)sender;
{
    NSUInteger value = sender.value;
    valueLabel.text = [NSString stringWithFormat:@"%d", (int)value];
    
    FlowersDataCell *pDataCell=[pParent->pDataFlowers->pDataCellsShops objectAtIndex:self.tag];
    pDataCell->NumPiece=stepper.value;

    [pParent UpdatePrieceInfo];
}

@end
