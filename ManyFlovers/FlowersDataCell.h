//
//  FlowersDataCell.h
//  ManyFlowers
//
//  Created by Konstantin on 21.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlowersDataCell : NSObject
{
@public
    NSString *Name,*delivery,*Price,*Article,*flowers,*package,*DxH,*InMCAD,*OUTMCAD;
    NSArray *DicPictMain;
    NSString *strPictFaforit;

    NSMutableArray *DicFilterDest;
    NSMutableArray *DicFilterFlower;
    NSMutableArray *DicFilterPrice;
    
    int NumPiece;
}

- (id)initwith:(NSDictionary *)Dic;


@end
