//
//  FlowersData.h
//  ManyFlowers
//
//  Created by Konstantin on 21.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlowersDataCell.h"
#import "httpClient.h"

@interface FlowersData : NSObject
{
@public
    NSMutableArray *pDataCellsCatalog;
    NSMutableArray *pDataCellsSales;
    NSMutableArray *pDataCellsFavorits;
    NSMutableArray *pDataCellsShops;
    
    NSTimer* JsonTimer;
    BOOL bSyn;
}

@property (strong, nonatomic) httpClient *pClient;
@property (strong, nonatomic) NSMutableDictionary *ArrJson;
@property (strong, nonatomic) NSMutableDictionary *ArrJsonSales;
@property (strong, nonatomic) NSMutableDictionary *ArrJsonFilters;

-(void)SynData;
-(void)LoadData;
-(void)SaveData;

@end
