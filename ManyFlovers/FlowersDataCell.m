//
//  FlowersData.m
//  ManyFlowers
//
//  Created by Konstantin on 21.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import "FlowersDataCell.h"

@implementation FlowersDataCell


- (id)initwith:(NSDictionary *)Dic
{
    if (self)
    {
        NumPiece=1;
        Name = [Dic objectForKey:@"Name"];
        delivery = [Dic objectForKey:@"delivery"];
        Price = [Dic objectForKey:@"Price"];
        Article=[Dic objectForKey:@"Article"];
        flowers=[Dic objectForKey:@"flowers"];
        package=[Dic objectForKey:@"package"];
        DxH=[Dic objectForKey:@"DxH"];
        InMCAD=[Dic objectForKey:@"InMCAD"];
        OUTMCAD=[Dic objectForKey:@"OUTMCAD"];

        DicPictMain=[Dic objectForKey:@"images"];
        
        NSMutableArray *arrayThatYouCanRemoveObjects = [NSMutableArray arrayWithArray:DicPictMain];
        
repeate://очищаем от избраных
        for (int i=0;i<[arrayThatYouCanRemoveObjects count];i++)
        {
            NSDictionary *valuesDicPic = [arrayThatYouCanRemoveObjects objectAtIndex:i];
            NSArray *Keys = [valuesDicPic  allKeys];
            
            NSString *Key=[Keys objectAtIndex:0];
            if([Key isEqualToString:@"NamePictFavorits"])
            {
                [arrayThatYouCanRemoveObjects removeObjectAtIndex:i];
                NSArray *values = [valuesDicPic  allValues];
                NSString *value=[values objectAtIndex:0];
                strPictFaforit=value;

                goto repeate;
            }
        };

        DicPictMain = [NSArray arrayWithArray: arrayThatYouCanRemoveObjects];
        
        DicFilterDest=[NSMutableArray array];
        DicFilterFlower=[NSMutableArray array];
        DicFilterPrice=[NSMutableArray array];

        NSArray *TmpArray=[Dic objectForKey:@"filter_destinations"];
        for (NSDictionary *Dicl in TmpArray)
        {
            NSString *idstr=[Dicl objectForKey:@"id"];
            [DicFilterDest addObject:[NSNumber numberWithInteger:[idstr integerValue]]];
        }

        TmpArray=[Dic objectForKey:@"filter_flowers"];
        for (NSDictionary *Dicl in TmpArray)
        {
            NSString *idstr=[Dicl objectForKey:@"id"];
            [DicFilterFlower addObject:[NSNumber numberWithInteger:[idstr integerValue]]];
        }

        NSDictionary *TmpDic=[Dic objectForKey:@"filter_price"];
        NSString *idstr=[TmpDic objectForKey:@"id"];
        [DicFilterPrice addObject:[NSNumber numberWithInteger:[idstr integerValue]]];
    }
    return self;
}
@end
