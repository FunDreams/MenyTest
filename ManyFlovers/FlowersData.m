//
//  FlowersData.m
//  ManyFlowers
//
//  Created by Konstantin on 21.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import "FlowersData.h"
#import "httpClient.h"
#import "ViewController.h"

@implementation FlowersData
@synthesize pClient,ArrJsonFilters,ArrJson,ArrJsonSales;

- (id)init
{
    self = [super init];
    if (self)
    {
        pDataCellsCatalog = [[NSMutableArray alloc] init];
        pDataCellsSales = [[NSMutableArray alloc] init];
        pDataCellsFavorits = [[NSMutableArray alloc] init];
        pDataCellsShops = [[NSMutableArray alloc] init];
        
        ArrJson = [NSMutableDictionary dictionary];
        bSyn=NO;
    }
    return self;
}

-(void)AddCell:(NSMutableArray*)pArray dic:(NSDictionary *)Dic
{
    FlowersDataCell *pDataCell=[[FlowersDataCell alloc] initwith:Dic];
    [pArray addObject:pDataCell];
}

-(void)DelCell:(int)iIndex
{
    if([pDataCellsCatalog count]<iIndex)return;
    [pDataCellsCatalog removeObjectAtIndex:iIndex];
}

-(void)SynData
{
    dispatch_async(dispatch_get_main_queue(),^{
        if(pClient.bBusy==NO)
        {
            pClient.bBusy=YES;
repeate:
            [pClient GetData:@"http://web-air.ru:8082" syn:YES download:YES competition:^(NSData *result,NSString *ID,NSError *error) {

                if(result != nil && [result length]>0)
                {
                    
                    ArrJson = [NSJSONSerialization JSONObjectWithData:result
                                        options:NSJSONReadingMutableContainers error:nil];
                    
                    NSDictionary *DicItem=[ArrJson objectForKey:@"items"];
                    
                    if(DicItem)
                    {
                        for (NSMutableDictionary *dic in DicItem)
                        {
                            [self AddCell:pDataCellsCatalog dic:dic];
                        }
                    }
                }
                
                [pClient GetData:@"http://web-air.ru:8082/filters/" syn:YES download:YES competition:^(NSData *result,NSString *ID,NSError *error) {
                    
                    if(result != nil && [result length]>0)
                    {
                        
                        ArrJsonFilters = [NSJSONSerialization JSONObjectWithData:result
                                                                         options:NSJSONReadingMutableContainers error:nil];                        
                    }
                    
                    
                    [pClient GetData:@"http://web-air.ru:8082/?sales=1" syn:YES download:YES competition:^(NSData *result,NSString *ID,NSError *error) {
                        
                        if(result != nil && [result length]>0)
                        {
                            ArrJsonSales = [NSJSONSerialization JSONObjectWithData:result
                                                                             options:NSJSONReadingMutableContainers error:nil];

                            NSDictionary *DicItem=[ArrJsonSales objectForKey:@"items"];
                            
                            if(DicItem)
                            {
                                for (NSMutableDictionary *dic in DicItem)
                                {
                                    [self AddCell:pDataCellsSales dic:dic];
                                }
                            }

                            ViewController* mainController = (ViewController*)  [[UIApplication sharedApplication] delegate].window.rootViewController;
                            [mainController ShowButton];
                    
                        }
                    }];
                    
                }];
            }];
            
            pClient.bBusy=NO;
        }
        else goto repeate;
    });
}

-(void)targetMethod
{
    if([ArrJson count]>0)
    {
        [self InitData:ArrJson array:pDataCellsCatalog];

        bSyn=NO;
        [JsonTimer invalidate];
        JsonTimer = nil;
    }
}

-(void)InitData:(NSMutableDictionary *)DicJson array:(NSMutableArray *)Array
{
    NSDictionary *DicItem=[DicJson objectForKey:@"items"];
    
    if(DicItem)
    {
        for (NSMutableDictionary *dic in DicItem)
        {
            [self AddCell:Array dic:dic];
        }
    }
}


-(void)LoadData
{

    
}

-(void)SaveData
{
    
}

@end
