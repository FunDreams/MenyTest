//
//  ListFlower.m
//  ManyFlovers
//
//  Created by Konstantin on 23.08.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import "ListFlower.h"
#import "FlowersDataCell.h"
#import "ManyFlowersCell.h"
#import "ManyFlowersCellIpad.h"
#import "ManyFlowersCellFavorits1.h"
#import "ManyFlowersCellFavorits2.h"
#import "CellShop1.h"
#import "CellShop2.h"
#import "TableViewCell_Adress.h"
#import "ViewControllerListFlower.h"
#import "httpClient.h"
#import <AudioToolbox/AudioToolbox.h>


@interface ListFlower ()
@end


@implementation ListFlower


@synthesize bCatalog,bCreate,bFavorits,bSales,bFilter,vSalesFon,imageLineOn3step;
@synthesize vMain,vCatalog,vCatalogFon,vCreate,vSales,vFavorits,vFilter;
@synthesize vCatalogTable,vSalesTable,vFavoritsTable,imageLine1Shop;
@synthesize vArrSales,vArrCatalog,vArrShop,bCalendar,vMyparWhiteSQR;
@synthesize bWithFlowers,bToMan,bUpToPrice,bCity,imageLine1,imageLine2;
@synthesize lWithFlowers,lToMan,lUpToPrice,vShopTable;
@synthesize vArrWithFlower,vArrTo,vArrByPriece,vArrCity;
@synthesize bShoppingCart,bNext,vArrAdressTable,vArrAdressTableTmp;
@synthesize pClient,pParent,vArrCatalogFilter,bResetFilter,imageLine;
@synthesize vUpWhiteSQR,vDownWhiteSQR,bEdit,bSave,bCansel;

@synthesize fDateDeliv,fTimeDeliv,lMyDataNameUp,lMyDataNameDown;
@synthesize lMyDataPhoneUp,lMyDataPhoneDown,lMyDataMailDown,lMyDataMailUp,lMyDataAdresUp,lMyDatadresDown;

@synthesize vOptions,vShoping,vOptionsInside,bSwitchInMoscow,vDel_Pay,vFAQ,vClients,vAbout;
@synthesize bInMoscow,bInMyDataSave,bFirstRun,bCloseOptions,bCloseOptionsFaq,bCloseAbout,bCloseClients;
@synthesize vMypar,vMyparInside,iNumCity,iNumFilerFlowers,iNumFilerToMan,iNumFilerPrice;
@synthesize fMyDataName,fMyDataPhone,fMyDataSity;

@synthesize vFinishShop,vInsideFinishShop,iStep;
@synthesize fName,fPhone,fEmail,fAdress,fMyDataEmail,fMyDataAdress;
@synthesize sName,sPhone,sEmail,sCity,sAdress;

@synthesize lAdressDelivery,lDateDelivery,bNewAdress,bEditAdress,tAdresTable,pDateDelivery;
@synthesize bToDay,bCach,bNonCach,tMessage,tMessagePost,ivPostard,tMessageUp,tMessageDown;
@synthesize lFourStepHeader,lFourNameShop;
//---------------------------------------------------------------------------------------------
- (void)SaveData
{
    [pPlFileManager SetKeyBoolValue:@"bInMoscow" withValue:bInMoscow];
    [pPlFileManager SetKeyBoolValue:@"bFirstRun" withValue:bFirstRun];
    [pPlFileManager SetKeyBoolValue:@"bInMyDataSave" withValue:bInMyDataSave];
    
    sName=[fMyDataName text];
    if(fName==nil)sName=@"Не заполнено";
    [pPlFileManager SetKeyStrValue:@"fName" withValue:sName];

    sPhone=[fMyDataPhone text];
    if(fPhone==nil)sPhone=@"+7 (___) ___-__-__";
    [pPlFileManager SetKeyStrValue:@"fPhone" withValue:sPhone];

    sEmail=[fMyDataEmail text];
    if(fEmail==nil)sEmail=@"Не заполнен";
    [pPlFileManager SetKeyStrValue:@"fEmail" withValue:sEmail];

    sCity=[fMyDataSity text];
    if(sCity==nil)sCity=@"Не заполнен";
    [pPlFileManager SetKeyStrValue:@"sCity" withValue:sCity];

    [pPlFileManager SetKeyIntValue:@"iNumCity" withValue:iNumCity];
    
    sAdress=[fMyDataAdress text];
    if(fEmail==nil)sAdress=@"Не заполнен";
    [pPlFileManager SetKeyStrValue:@"fAdress" withValue:sAdress];
    
    int Count=(int)[vArrAdressTable count];
    if(Count>0)
    {
        [pPlFileManager SetKeyIntValue:@"iNumAdress" withValue:Count];

        for (int i=0;i<Count;i++) {
            NSString *strKey=[NSString stringWithFormat:@"SecondAdres%d",i];
            NSString *Value=[vArrAdressTable objectAtIndex:i];
            [pPlFileManager SetKeyStrValue:strKey withValue:Value];
        }
    }
}
- (void)LoadData
{
    bInMoscow=[pPlFileManager GetKeyBoolValue:@"bInMoscow"];
    bFirstRun=[pPlFileManager GetKeyBoolValue:@"bFirstRun"];
    bInMyDataSave=[pPlFileManager GetKeyBoolValue:@"bInMyDataSave"];
    
    
    sName=[pPlFileManager GetKeyStrValue:@"fName"];
    if(sName==nil)sName=@"Не заполнено";
    
    sPhone=[pPlFileManager GetKeyStrValue:@"fPhone"];
    if(sPhone==nil)sPhone=@"+7 (___) ___-__-__";
    
    sEmail=[pPlFileManager GetKeyStrValue:@"fEmail"];
    if(sEmail==nil)sEmail=@"Не заполнен";

    sCity=[pPlFileManager GetKeyStrValue:@"sCity"];
    if(sCity==nil)sCity=@"Не заполнен";

    iNumCity=[pPlFileManager GetKeyIntValue:@"iNumCity"];
    
    sAdress=[pPlFileManager GetKeyStrValue:@"fAdress"];
    if(sAdress==nil)sAdress=@"Не заполнен";
    
    int Count=[pPlFileManager GetKeyIntValue:@"iNumAdress"];
    if(Count>0)
    {
        for (int i=0;i<Count;i++) {
            NSString *strKey=[NSString stringWithFormat:@"SecondAdres%d",i];
            NSString *Value=[pPlFileManager GetKeyStrValue:strKey];
            [vArrAdressTable addObject:Value];
        }
    }
}
//---------------------------------------------------------------------------------------------
- (void)setNeedsDisplay
{
    float HeightNavHeader=self.navigationController.navigationBar.frame.size.height;
    float HeightStatusBar=[UIApplication sharedApplication].statusBarFrame.size.height;
    float Delta=HeightNavHeader+HeightStatusBar;
    
    int HeightMenu=72;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    vMain.frame=CGRectMake(0, Delta, screenWidth, screenHeight-Delta-HeightMenu);

    float CenterX=vMain.frame.size.width/2;
    float CenterY=(vMain.frame.size.height)/2;
    
    switch(iCurSel)
    {
        case I_PAGE_FINISH_BUY:
        {
//            [vFinishShop setFrame:CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
//            CGRect Tframe=CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height);
//            vFinishShop.frame = Tframe;
//            
//            CGPoint TCenter;
//            float DeltaSize=vMain.bounds.size.height-vInsideFinishShop.frame.size.height;
//            if(DeltaSize<0)
//            {
//                TCenter=CGPointMake(CenterX, CenterY+DeltaSize+HeightNavHeader);
//            }
//            else
//            {
//                TCenter=CGPointMake(CenterX, CenterY);
//            }
//            vInsideFinishShop.center = TCenter;
        }

        break;
            
        case I_PAGE_MY_PARAMETR:
        {
//            CGRect Tframe=CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height);
    //        CGPoint TCenter=CGPointMake(CenterX, CenterY+OffsetY_In_myPar);
            
//            [UIView animateWithDuration:0.5 animations:^
//             {
//                 vMypar.frame = Tframe;
//                 vMyparInside.center = TCenter;
//             }];

            [vMypar setFrame:CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
            [vMyparInside setFrame:CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
      //      vMyparInside.center=CGPointMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height);
        }
        break;
            
        case I_PAGE_DEL_PAY:
        case I_PAGE_FAQ:
        case I_PAGE_CLIENT:
        case I_PAGE_ABOUT:
        {
            [vDel_Pay setFrame:CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
            [vFAQ setFrame:CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
            [vClients setFrame:CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
            [vAbout setFrame:CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
            
            float CenterX=vMain.frame.size.width/2;
//            float CenterY=(vDel_Pay.frame.size.height)/2;
            
            bCloseOptions.center=CGPointMake(CenterX, vMain.frame.size.height-40);
            bCloseOptionsFaq.center=CGPointMake(CenterX, vMain.frame.size.height-40);
            bCloseClients.center=CGPointMake(CenterX, vMain.frame.size.height-40);
            bCloseAbout.center=CGPointMake(CenterX, vMain.frame.size.height-40);
        }
        break;
            
        case I_PAGE_OPTIONS:
        {
            [vOptions setFrame:CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
            
            vOptionsInside.center=CGPointMake(CenterX, CenterY);
        }
        break;

        case I_PAGE_SHOPING:
        {
            [vShoping setFrame:CGRectMake(0,0,vMain.frame.size.width,vMain.frame.size.height)];
            
            int border=(vMain.frame.size.width-251)/2;

            [vShopTable setFrame:CGRectMake(border,0,vMain.frame.size.width-2*border,
                                                vMain.frame.size.height)];
        }
        break;

        case I_PAGE_CATALOG:
        {
            [vCatalog setFrame:CGRectMake(0,0,vMain.frame.size.width,vMain.frame.size.height)];

            if(bFilterOpen==YES)
            {
                [bFilter setFrame:CGRectMake(0,vMain.frame.size.height-iButtonH,
                                             vMain.frame.size.width,iButtonH)];
            }
            else
            {
                [bFilter setFrame:CGRectMake(0,0,vMain.frame.size.width,iButtonH)];
                
            }

//            [vFilter setFrame:CGRectMake(0, 0,
//                                         vMain.frame.size.width,0)];

            int border=(vMain.frame.size.width-272)/2;
            [vCatalogTable setFrame:CGRectMake(border,iButtonH,vMain.frame.size.width-2*border,
                                               vMain.frame.size.height-iButtonH)];

            
            float Height=300;
            float Step=Height/3;
            float StartPoint=CenterY-Height+Step/2+HeightNavHeader+HeightStatusBar;
            float Step2=Step-20;
            
            float offset=40;
            lWithFlowers.center=CGPointMake(CenterX, StartPoint+Step2-offset);
            bWithFlowers.center=CGPointMake(CenterX, StartPoint+Step2);
            
            lToMan.center=CGPointMake(CenterX, StartPoint+Step2*2-offset);
            bToMan.center=CGPointMake(CenterX, StartPoint+Step2*2);
            
            lUpToPrice.center=CGPointMake(CenterX, StartPoint+Step2*3-offset);
            bUpToPrice.center=CGPointMake(CenterX, StartPoint+Step2*3);

            bResetFilter.center=CGPointMake(CenterX, StartPoint+Step2*4-30);
            
            NSArray * values = [vArrCatalog allValues];
            
            if(IPAD)
            {
                for (ManyFlowersCellIpad *tCell in values)
                {
                    tCell.scrollView.center=CGPointMake(CenterX-164, tCell.scrollView.center.y);
                    tCell.pageControl.center=CGPointMake(tCell.scrollView.center.x,
                                        tCell.scrollView.center.y+tCell.scrollView.frame.size.height/2-25);
                    
                    tCell.lName0.center=CGPointMake(CenterX+100, tCell.lName0.center.y);
                    tCell.lName.center=CGPointMake(CenterX+260, tCell.lName.center.y);
                    tCell.bFavorits.center=CGPointMake(CenterX-345, tCell.bFavorits.center.y);
                    tCell.bBuy.center=CGPointMake(CenterX+270, tCell.bBuy.center.y);
                    tCell.lPrice.center=CGPointMake(CenterX+115, tCell.lPrice.center.y);
                    tCell.vViewDetails.center=CGPointMake(CenterX+220, tCell.vViewDetails.center.y);
                }
            }
            else
            {
            }
        }
        break;

        case I_PAGE_SALES:
        {
            [vSales setFrame:CGRectMake(0,0,vMain.frame.size.width,
                                        vMain.frame.size.height)];
            

            int border=(vMain.frame.size.width-272)/2;
            [vSalesTable setFrame:CGRectMake(border,0,vMain.frame.size.width-2*border,
                                               vMain.frame.size.height)];
            
            NSArray * values = [vArrSales allValues];

            if(IPAD)
            {
                for (ManyFlowersCellIpad *tCell in values)
                {
                    tCell.scrollView.center=CGPointMake(CenterX-164, tCell.scrollView.center.y);
                    tCell.pageControl.center=CGPointMake(tCell.scrollView.center.x,
                                                         tCell.scrollView.center.y+tCell.scrollView.frame.size.height/2-25);
                    
                    tCell.lName0.center=CGPointMake(CenterX+100, tCell.lName0.center.y);
                    tCell.lName.center=CGPointMake(CenterX+260, tCell.lName.center.y);
                    tCell.bFavorits.center=CGPointMake(CenterX-345, tCell.bFavorits.center.y);
                    tCell.bBuy.center=CGPointMake(CenterX+270, tCell.bBuy.center.y);
                    tCell.lPrice.center=CGPointMake(CenterX+115, tCell.lPrice.center.y);
                    tCell.vViewDetails.center=CGPointMake(CenterX+220, tCell.vViewDetails.center.y);
                }
            }
            else
            {
            }

//            [vSalesTable reloadData];
        }
        break;

        case I_PAGE_FAVORITS:
        {
            CGRect rectangle = CGRectMake(0,0,vMain.frame.size.width,
                                          vMain.frame.size.height);
            
            
            [vFavorits setFrame:rectangle];
            
            int border=(vMain.frame.size.width-251)/2;
            [vFavoritsTable setFrame:CGRectMake(border,0,vMain.frame.size.width-2*border,
                                               vMain.frame.size.height)];
        }
        break;

        case I_PAGE_CREATE:
        {
            [vCreate setFrame:CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
        }
        break;

        default:
            break;
    }
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self setNeedsDisplay];
}

- (void)willRotateFromInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    [self setNeedsDisplay];

}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    [self setNeedsDisplay];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
  //  int m=0;
//    [self setNeedsDisplay];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        [pickerLabel setFont:[UIFont fontWithName:@"RobotoSlab-Regular" size:18]];
        
        [pickerLabel setTextColor:[UIColor whiteColor]];
        pickerLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    if(pickerView==bWithFlowers)
    {
        [pickerLabel setText:[vArrWithFlower objectAtIndex:row]];
    }
    
    if(pickerView==bToMan)
    {
        [pickerLabel setText:[vArrTo objectAtIndex:row]];
    }
    
    if(pickerView==bUpToPrice)
    {
        [pickerLabel setText:[vArrByPriece objectAtIndex:row]];
    }

    if(pickerView==bCity)
    {
        [pickerLabel setTextColor:[UIColor blackColor]];
        NSString *TmpStr=[vArrCity objectAtIndex:row];
        [pickerLabel setText:TmpStr];
    }

    return pickerLabel;
}

- (IBAction)ResetFilter:(id)sender
{
    [bWithFlowers selectRow:0 inComponent:0 animated:YES];
    [bToMan selectRow:0 inComponent:0 animated:YES];
    [bUpToPrice selectRow:0 inComponent:0 animated:YES];
    
    [bWithFlowers reloadAllComponents];
    [bToMan reloadAllComponents];
    [bUpToPrice reloadAllComponents];
    
    iNumFilerFlowers=0;
    iNumFilerToMan=0;
    iNumFilerPrice=0;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    NSInteger iCount=0;

    if(pickerView==bWithFlowers)
    {
        iCount=[vArrWithFlower count];
    }
    
    if(pickerView==bToMan)
    {
        iCount=[vArrTo count];
    }

    if(pickerView==bUpToPrice)
    {
        iCount=[vArrByPriece count];
    }

    if(pickerView==bCity)
    {
        iCount=[vArrCity count];
    }

    return iCount;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    if(pickerView==bCity)
    {
        iNumCity=(int)row;
    }
    
    if(pickerView==bWithFlowers)
    {
        iNumFilerFlowers=row;
    }
    
    if(pickerView==bToMan)
    {
        iNumFilerToMan=row;
    }

    if(pickerView==bUpToPrice)
    {
        iNumFilerPrice=row;
    }
}

- (void)InitFilter
{
    [PlusSign setImage:[UIImage imageNamed:@"Icon-arrow-filter.png"]];
    
    int W=12,H=12;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    PlusSign.frame = CGRectMake(screenRect.size.width/2-W/2+40, iButtonH/2-H/2, W, H);
    
    [bFilter setTitle:@"ФИЛЬТР  " forState:UIControlStateNormal];
    [bFilter setTitle:@"ФИЛЬТР  " forState:UIControlStateHighlighted];
    bFilterOpen=NO;
}


- (IBAction)ButtonFilter:(id)sender
{
    if(bFilterOpen==YES)
    {
        int border=(vMain.frame.size.width-272)/2;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            vCatalogTable.frame = CGRectMake(border,
                                             iButtonH,vMain.frame.size.width-2*border,
                                            vMain.frame.size.height-iButtonH);

            vCatalogFon.frame = CGRectMake(0,
                                             iButtonH,vMain.frame.size.width,
                                             vMain.frame.size.height-iButtonH);
        }];
        
        CGRect newRectBfilter=CGRectMake(0,0,vMain.frame.size.width,iButtonH);
        [UIView animateWithDuration:0.5 animations:^
         {
             bFilter.frame = newRectBfilter;
         }
         completion:^(BOOL completed)
         {
             [self InitFilter];
         }];

        bFilterOpen=NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:
                                    ^{vFilter.frame = CGRectMake(0, 0, vMain.bounds.size.width,
                                      vMain.frame.size.height-iButtonH);}];
        
        
        int border=(vMain.frame.size.width-272)/2;
        [UIView animateWithDuration:0.5 animations:^{
            vCatalogTable.frame = CGRectMake(border,
                                        vMain.frame.size.height,
                                        vMain.frame.size.width-2*border,
                                        0);
            
            vCatalogFon.frame = CGRectMake(0,vMain.frame.size.height,
                                           vMain.frame.size.width,0);
        }];

        CGRect newRectBfilter=CGRectMake(0,vMain.frame.size.height-iButtonH,
                                         vMain.frame.size.width,iButtonH);
        
        [UIView animateWithDuration:0.5 animations:^
         {
             bFilter.frame = newRectBfilter;
         }
         completion:^(BOOL completed)
         {
             [PlusSign setImage:[UIImage imageNamed:@"Icon-arrow_two.png"]];
             
             int W=12,H=12;
             CGRect screenRect = [[UIScreen mainScreen] bounds];
             PlusSign.frame = CGRectMake(screenRect.size.width/2-W/2+86, iButtonH/2-H/2, W, H);

             [bFilter setTitle:@"СВЕРНУТЬ ФИЛЬТР  " forState:UIControlStateNormal];
             [bFilter setTitle:@"СВЕРНУТЬ ФИЛЬТР  " forState:UIControlStateHighlighted];
         }];
        
        bFilterOpen=YES;
    }
}

-(id)init
{
    self = [super init];
    if (self) {
        
        vArrCatalogFilter = [NSMutableArray array];
        pQueueDownLoad = [NSMutableArray array];
        pDataFlowers=[[FlowersData alloc] init];
        pPlFileManager=[[CPlManager alloc] init];

        pClient=[[httpClient alloc] init];
        pDataFlowers.pClient=pClient;

        sName=[[NSString alloc] init];
        sPhone=[[NSString alloc] init];
        sCity=[[NSString alloc] init];
        sEmail=[[NSString alloc] init];
        sAdress=[[NSString alloc] init];
        
        bFilterOpen=NO;
        vArrCatalog = [[NSMutableDictionary alloc] init];
        vArrSales = [[NSMutableDictionary alloc] init];
        vArrShop = [[NSMutableDictionary alloc] init];
        vArrAdressTable = [NSMutableArray array];
        vArrAdressTableTmp = [NSMutableArray array];
    
    SelectAdress = [NSMutableArray array];

    iCurrentActive=-1;
    TmpTextFieldT=nil;

    }

    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
//    for(NSString *fontfamilyname in [UIFont familyNames])
//    {
//        NSLog(@"Family:'%@'",fontfamilyname);
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//        {
//            NSLog(@"\tfont:'%@'",fontName);
//        }
//        NSLog(@"~~~~~~~~");
//    }
    
    OffsetY_In_myPar=0;
    bFirstRun=YES;
    
    [self performSelectorInBackground:@selector(downloadQueue) withObject:nil];

    NSMutableDictionary *TmpFilters= pDataFlowers.ArrJsonFilters;
    
    NSArray *DicPrice=[TmpFilters objectForKey:@"filter_price"];
    NSArray *DicFlowers=[TmpFilters objectForKey:@"filter_flowers"];
    NSArray *DicDestination=[TmpFilters objectForKey:@"filter_destinations"];
    
    vArrWithFlower = [[NSMutableArray alloc] initWithObjects:@"Все",nil];
    vArrTo = [[NSMutableArray alloc] initWithObjects:@"Всем",nil];
    vArrByPriece = [[NSMutableArray alloc] initWithObjects:@"Все",nil];
    
    for (NSDictionary *Dic in DicFlowers) {
        
        NSString *name=[Dic objectForKey:@"name"];
        [vArrWithFlower addObject:name];
    }

    for (NSDictionary *Dic in DicDestination) {
        
        NSString *name=[Dic objectForKey:@"name"];
        [vArrTo addObject:name];
    }

    for (NSDictionary *Dic in DicPrice) {
        
        NSString *name=[Dic objectForKey:@"name"];
        [vArrByPriece addObject:name];
    }

    iNumFilerFlowers=0;
    iNumFilerToMan=0;
    iNumFilerPrice=0;

    vArrCity = [[NSMutableArray alloc] initWithObjects:@"Не выбран",@"Москва",
                @"Санкт-Петербург",@"Новосибирск",@"Екатеринбург",
                @"Нижний Новгород",@"Казань",@"Самара",@"Челябинск",
                @"Омск",@"Ростов-на-Дону",@"Уфа",@"Красноярск",@"Пермь",
                @"Волгоград",@"Воронеж",nil];
    
//    //add background
//    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tile.png"]];
//    [vMypar addSubview:background];
//    [vMypar sendSubviewToBack:background];
//    vMypar.contentMode = UIViewContentModeScaleAspectFit;
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:self.view.window];
//    // register for keyboard notifications
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:self.view.window];


    iButtonH=30;//высота кнопки filter
//настраиваем кнопку фильтра
    [bFilter setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    PlusSign = [[UIImageView alloc]initWithImage:
                             [UIImage imageNamed:@"Icon-arrow-filter.png"]];

    int W=12,H=12;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    PlusSign.frame = CGRectMake(screenRect.size.width/2-W/2+40, iButtonH/2-H/2, W, H);//choose values that fit properly inside the frame of your baseButton
    //or grab the width and height of yourBaseButton and change accordingly
    PlusSign.contentMode=UIViewContentModeScaleAspectFill;//or whichever mode works best for you
    [bFilter addSubview:PlusSign];
/////////////////////////////////////////////////////////////////////////
    [vCatalogFon setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vCatalog setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vCatalogTable setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vFilter setTranslatesAutoresizingMaskIntoConstraints:YES];

    [bWithFlowers setTranslatesAutoresizingMaskIntoConstraints:YES];
    [bToMan setTranslatesAutoresizingMaskIntoConstraints:YES];
    [bUpToPrice setTranslatesAutoresizingMaskIntoConstraints:YES];
    [bResetFilter setTranslatesAutoresizingMaskIntoConstraints:YES];

    [lWithFlowers setTranslatesAutoresizingMaskIntoConstraints:YES];
    [lToMan setTranslatesAutoresizingMaskIntoConstraints:YES];
    [lUpToPrice setTranslatesAutoresizingMaskIntoConstraints:YES];

    [vOptions setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vOptionsInside setTranslatesAutoresizingMaskIntoConstraints:YES];

    [vDel_Pay setTranslatesAutoresizingMaskIntoConstraints:YES];
    [bCloseOptions setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vFAQ setTranslatesAutoresizingMaskIntoConstraints:YES];
    [bCloseOptionsFaq setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vClients setTranslatesAutoresizingMaskIntoConstraints:YES];
    [bCloseClients setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vAbout setTranslatesAutoresizingMaskIntoConstraints:YES];
    [bCloseAbout setTranslatesAutoresizingMaskIntoConstraints:YES];

    [vMypar setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vMyparInside setTranslatesAutoresizingMaskIntoConstraints:YES];

    [vShoping setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vShopTable setTranslatesAutoresizingMaskIntoConstraints:YES];

    [vSales setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vSalesTable setTranslatesAutoresizingMaskIntoConstraints:YES];

    [vFavorits setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vFavoritsTable setTranslatesAutoresizingMaskIntoConstraints:YES];

    [vFinishShop setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vInsideFinishShop setTranslatesAutoresizingMaskIntoConstraints:YES];
    [bShoppingCart setTranslatesAutoresizingMaskIntoConstraints:YES];
    [bNext setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vMain setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    [vMain addSubview:vCatalog];
//инизиализация MyData=============================================================
    int Border=25;

    vMyparWhiteSQR=[[UIView alloc]initWithFrame:
                      CGRectMake(Border,25,screenRect.size.width-2*Border,256)];

    [vMyparWhiteSQR setBackgroundColor:[UIColor whiteColor]];
    [vMyparInside addSubview:vMyparWhiteSQR];

    vUpWhiteSQR = [[UIImageView alloc] init];
    vUpWhiteSQR.frame = CGRectMake(Border,17,screenRect.size.width-2*Border,9);
    [vMyparInside addSubview:vUpWhiteSQR];
    vUpWhiteSQR.transform = CGAffineTransformMakeScale(1, -1);
    [vUpWhiteSQR setImage:[UIImage imageNamed:@"product-frame-bottom.png"]];

    vDownWhiteSQR = [[UIImageView alloc] init];
    vDownWhiteSQR.frame = CGRectMake(Border,280,screenRect.size.width-2*Border,9);
    [vMyparInside addSubview:vDownWhiteSQR];
    [vDownWhiteSQR setImage:[UIImage imageNamed:@"product-frame-bottom.png"]];

    bEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    [vMyparInside addSubview:bEdit];
    bEdit.frame = CGRectMake(92,244,134,24);
    bEdit.center=CGPointMake(screenRect.size.width/2, bEdit.center.y);
    [bEdit setImage:[UIImage imageNamed:@"EDIT.png"] forState:UIControlStateNormal];
    [bEdit setImage:[UIImage imageNamed:@"EDIT.png"] forState:UIControlStateHighlighted];
    [bEdit addTarget:self action:@selector(aEditMyData:)forControlEvents:UIControlEventTouchUpInside];

    bSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [vMyparInside addSubview:bSave];
    bSave.frame = CGRectMake(screenRect.size.width/2-100,264,101,24);
    [bSave setImage:[UIImage imageNamed:@"SAVE.png"] forState:UIControlStateNormal];
    [bSave setImage:[UIImage imageNamed:@"SAVE.png"] forState:UIControlStateHighlighted];
    [bSave addTarget:self action:@selector(SaveOptions:)forControlEvents:UIControlEventTouchUpInside];
    bSave.alpha=0;

    bCansel = [UIButton buttonWithType:UIButtonTypeCustom];
    [vMyparInside addSubview:bCansel];
    bCansel.frame = CGRectMake(screenRect.size.width/2+10,264,94,24);
    [bCansel setImage:[UIImage imageNamed:@"CANCEL.png"] forState:UIControlStateNormal];
    [bCansel setImage:[UIImage imageNamed:@"CANCEL.png"] forState:UIControlStateHighlighted];
    [bCansel addTarget:self action:@selector(aCanselEditMyData:)forControlEvents:
        UIControlEventTouchUpInside];
    bCansel.alpha=0;

    lMyDataNameUp = [[UILabel alloc] init];
    lMyDataNameUp.frame = CGRectMake(40,30,230,20);
    lMyDataNameUp.center=CGPointMake(screenRect.size.width/2, lMyDataNameUp.center.y);
    lMyDataNameUp.tintColor=[UIColor colorWithRed:108/255 green:106/255 blue:106/255 alpha:1];
    lMyDataNameUp.text=@"Имя:";
    lMyDataNameUp.font=[UIFont fontWithName:@"RobotoSlab-regular" size:12];
    [vMyparInside addSubview:lMyDataNameUp];

    lMyDataNameDown = [[UILabel alloc] init];
    lMyDataNameDown.frame = CGRectMake(40,48,230,20);
    lMyDataNameDown.tintColor=[UIColor colorWithRed:108/255 green:106/255 blue:106/255 alpha:1];
    lMyDataNameDown.center=CGPointMake(screenRect.size.width/2, lMyDataNameDown.center.y);
    lMyDataNameDown.font=[UIFont fontWithName:@"RobotoSlab-regular" size:12];
    [vMyparInside addSubview:lMyDataNameDown];

    lMyDataPhoneUp = [[UILabel alloc] init];
    lMyDataPhoneUp.frame = CGRectMake(40,80,230,20);
    lMyDataPhoneUp.center=CGPointMake(screenRect.size.width/2, lMyDataPhoneUp.center.y);
    lMyDataPhoneUp.tintColor=[UIColor colorWithRed:108/255 green:106/255 blue:106/255 alpha:1];
    lMyDataPhoneUp.text=@"Телефон:";
    lMyDataPhoneUp.font=[UIFont fontWithName:@"RobotoSlab-regular" size:12];
    [vMyparInside addSubview:lMyDataPhoneUp];
    
    lMyDataPhoneDown = [[UILabel alloc] init];
    lMyDataPhoneDown.frame = CGRectMake(40,98,230,20);
    lMyDataPhoneDown.center=CGPointMake(screenRect.size.width/2, lMyDataPhoneDown.center.y);
    lMyDataPhoneDown.tintColor=[UIColor colorWithRed:108/255 green:106/255 blue:106/255 alpha:1];
    lMyDataPhoneDown.font=[UIFont fontWithName:@"RobotoSlab-regular" size:12];
    [vMyparInside addSubview:lMyDataPhoneDown];

    lMyDataMailUp = [[UILabel alloc] init];
    lMyDataMailUp.frame = CGRectMake(40,130,230,20);
    lMyDataMailUp.center=CGPointMake(screenRect.size.width/2, lMyDataMailUp.center.y);
    lMyDataMailUp.tintColor=[UIColor colorWithRed:108/255 green:106/255 blue:106/255 alpha:1];
    lMyDataMailUp.text=@"E-mail:";
    lMyDataMailUp.font=[UIFont fontWithName:@"RobotoSlab-regular" size:12];
    [vMyparInside addSubview:lMyDataMailUp];
    
    lMyDataMailDown = [[UILabel alloc] init];
    lMyDataMailDown.frame = CGRectMake(40,148,230,20);
    lMyDataMailDown.center=CGPointMake(screenRect.size.width/2, lMyDataMailDown.center.y);
    lMyDataMailDown.tintColor=[UIColor colorWithRed:108/255 green:106/255 blue:106/255 alpha:1];
    lMyDataMailDown.font=[UIFont fontWithName:@"RobotoSlab-regular" size:12];
    [vMyparInside addSubview:lMyDataMailDown];

    lMyDataAdresUp = [[UILabel alloc] init];
    lMyDataAdresUp.frame = CGRectMake(40,180,230,20);
    lMyDataAdresUp.center=CGPointMake(screenRect.size.width/2, lMyDataAdresUp.center.y);
    lMyDataAdresUp.tintColor=[UIColor colorWithRed:108/255 green:106/255 blue:106/255 alpha:1];
    lMyDataAdresUp.text=@"Адрес:";
    lMyDataAdresUp.font=[UIFont fontWithName:@"RobotoSlab-regular" size:12];
    [vMyparInside addSubview:lMyDataAdresUp];
    
    lMyDatadresDown = [[UILabel alloc] init];
    lMyDatadresDown.frame = CGRectMake(40,198,230,20);
    lMyDatadresDown.center=CGPointMake(screenRect.size.width/2, lMyDatadresDown.center.y);
    lMyDatadresDown.tintColor=[UIColor colorWithRed:108/255 green:106/255 blue:106/255 alpha:1];
    
    lMyDatadresDown.font=[UIFont fontWithName:@"RobotoSlab-regular" size:12];
    [vMyparInside addSubview:lMyDatadresDown];
    
    
    fMyDataName = [[UITextField alloc] initWithFrame:CGRectMake(42, 35, 236, 32)];
    fMyDataName.center=CGPointMake(screenRect.size.width/2, fMyDataName.center.y);
    fMyDataName.borderStyle = UITextBorderStyleNone;
    fMyDataName.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    fMyDataName.text=@"";
    fMyDataName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    fMyDataName.background = [UIImage imageNamed:@"RectangleWhite.png"];
    fMyDataName.delegate = self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    fMyDataName.leftView = paddingView;
    fMyDataName.leftViewMode = UITextFieldViewModeAlways;
    [vMyparInside addSubview:fMyDataName];
    fMyDataName.alpha=0;

    fMyDataPhone = [[SHSPhoneTextField alloc] initWithFrame:CGRectMake(42,80, 236, 32)];
    fMyDataPhone.center=CGPointMake(screenRect.size.width/2, fMyDataPhone.center.y);
    [fMyDataPhone.formatter setDefaultOutputPattern:@"(###) ###-##-##"];
    fMyDataPhone.formatter.prefix = @"+7 ";
    fMyDataPhone.borderStyle = UITextBorderStyleNone;
    fMyDataPhone.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    fMyDataPhone.text=@"+7 (___) ___-__-__";
    fMyDataPhone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    fMyDataPhone.background = [UIImage imageNamed:@"RectangleWhite.png"];
    fMyDataPhone.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    fMyDataPhone.leftView = paddingView;
    fMyDataPhone.leftViewMode = UITextFieldViewModeAlways;
    fMyDataPhone.alpha=0;
    [vMyparInside addSubview:fMyDataPhone];

    fMyDataEmail = [[UITextField alloc] initWithFrame:CGRectMake(42, 125, 236, 32)];
    fMyDataEmail.center=CGPointMake(screenRect.size.width/2, fMyDataEmail.center.y);
    fMyDataEmail.borderStyle = UITextBorderStyleNone;
    fMyDataEmail.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    fMyDataEmail.text=@"";
    fMyDataEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    fMyDataEmail.background = [UIImage imageNamed:@"RectangleWhite.png"];
    fMyDataEmail.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    fMyDataEmail.leftView = paddingView;
    fMyDataEmail.leftViewMode = UITextFieldViewModeAlways;
    fMyDataEmail.keyboardType=UIKeyboardTypeEmailAddress;
    [vMyparInside addSubview:fMyDataEmail];
    fMyDataEmail.alpha=0;

    fMyDataSity = [[UITextField alloc] initWithFrame:CGRectMake(42, 170, 236, 32)];
    fMyDataSity.center=CGPointMake(screenRect.size.width/2, fMyDataSity.center.y);
    fMyDataSity.borderStyle = UITextBorderStyleNone;
    fMyDataSity.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    fMyDataSity.text=@"";
    fMyDataSity.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    fMyDataSity.background = [UIImage imageNamed:@"RectangleWhite.png"];
    fMyDataSity.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    fMyDataSity.leftView = paddingView;
    fMyDataSity.leftViewMode = UITextFieldViewModeAlways;
    [vMyparInside addSubview:fMyDataSity];
    fMyDataSity.alpha=0;

    fMyDataAdress = [[UITextField alloc] initWithFrame:CGRectMake(42, 215, 236, 32)];
    fMyDataAdress.center=CGPointMake(screenRect.size.width/2, fMyDataAdress.center.y);
    fMyDataAdress.borderStyle = UITextBorderStyleNone;
    fMyDataAdress.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    fMyDataAdress.text=@"";
    fMyDataAdress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    fMyDataAdress.background = [UIImage imageNamed:@"RectangleWhite.png"];
    fMyDataAdress.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    fMyDataAdress.leftView = paddingView;
    fMyDataAdress.leftViewMode = UITextFieldViewModeAlways;
    [vMyparInside addSubview:fMyDataAdress];
    fMyDataAdress.alpha=0;

    [self updateMyData];
    
    [vMain addSubview:vMypar];
//инизиализация _Текстовая страница=============================================================
    _vAboutText=[[UIView alloc]initWithFrame:
                CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
    
    UIGraphicsBeginImageContext(_vAboutText.frame.size);
    [[UIImage imageNamed:@"fon.png"] drawInRect:_vAboutText.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _vAboutText.backgroundColor = [UIColor colorWithPatternImage:image];

    [vMain addSubview:_vAboutText];
//----прокрутка вьювера
    _vAboutInside=[[UIScrollView alloc]initWithFrame:_vAboutText.frame];
    
    _vAboutInside.showsVerticalScrollIndicator=YES;
    _vAboutInside.scrollEnabled=YES;
    _vAboutInside.userInteractionEnabled=YES;
    _vAboutInside.contentSize = CGSizeMake(320,800);
    [_vAboutText addSubview:_vAboutInside];
//----верхний текст о сервисе
    _tvAboutVUp1 = [[UITextView alloc] initWithFrame:CGRectMake(36, 5, 248, 40)];
    _tvAboutVUp1.center=CGPointMake(screenRect.size.width/2, _tvAboutVUp1.center.y);
    _tvAboutVUp1.text = @"О сервисе";

    _tvAboutVUp1.backgroundColor=[UIColor clearColor];
    _tvAboutVUp1.textColor=[UIColor colorWithRed:49.0/255.0
                                          green:44.0/255.0 blue:45.0/255.0 alpha:1.0];

    _tvAboutVUp1.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:16];
    _tvAboutVUp1.userInteractionEnabled=NO;
    [_vAboutInside addSubview:_tvAboutVUp1];
//----простой текст
    _tvAboutVUp2 = [[UITextView alloc] initWithFrame:CGRectMake(36, 35, 248, 144)];
    _tvAboutVUp2.center=CGPointMake(screenRect.size.width/2, _tvAboutVUp2.center.y);
    _tvAboutVUp2.text = @"Суд зачёл пребывание Васильевой под домашним арестом с ноября 2012 года. На свободу она сможет выйти в 2017 году, сообщает ТАСС. Через месяц защита бывшей чиновницы сможет подать на условно-досрочное освобождение, поскольку она отбудет половину срока.";

    _tvAboutVUp2.backgroundColor=[UIColor clearColor];
    _tvAboutVUp2.textColor=[UIColor colorWithRed:108.0/255.0
                                           green:106.0/255.0 blue:106.0/255.0 alpha:1.0];

    _tvAboutVUp2.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _tvAboutVUp2.userInteractionEnabled=NO;
    [_vAboutInside addSubview:_tvAboutVUp2];
//----FAQ--------------------------------------
    _tvAboutFAQ = [[UITextView alloc] initWithFrame:CGRectMake(36,175,248,40)];
    _tvAboutFAQ.center=CGPointMake(screenRect.size.width/2, _tvAboutFAQ.center.y);
    _tvAboutFAQ.text = @"F.A.Q";
    
    _tvAboutFAQ.backgroundColor=[UIColor clearColor];
    _tvAboutFAQ.textColor=[UIColor colorWithRed:49.0/255.0
                                           green:44.0/255.0 blue:45.0/255.0 alpha:1.0];
    
    _tvAboutFAQ.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:16];
    _tvAboutFAQ.userInteractionEnabled=NO;
    [_vAboutInside addSubview:_tvAboutFAQ];
//----первая линия---------------------------------------------------------------------
    _tvAboutLine = [[UIImageView alloc] init];
    
    _tvAboutLine.frame=CGRectMake(36,215,248,1);
    _tvAboutLine.center=CGPointMake(screenRect.size.width/2, _tvAboutLine.center.y);
    [_tvAboutLine setImage:[UIImage imageNamed:@"LineCell.png"]];
    [_vAboutInside addSubview:_tvAboutLine];
//----раздвигающийся view1-------------------------------------------------------------
    _view1 = [[ViewEx alloc] initWithFrame:CGRectMake(36,215,248,30)];
    _view1.center=CGPointMake(screenRect.size.width/2, _view1.center.y);
    _view1.backgroundColor=[UIColor clearColor];
    [_view1 InitData];
    _view1.tvTextInside.text=@"Как сделать заказ?";
    _view1.translatesAutoresizingMaskIntoConstraints = NO;

    [_vAboutInside addSubview:_view1];
//----раздвигающийся view2-------------------------------------------------------------
    _view2 = [[ViewEx alloc] initWithFrame:CGRectMake(36,245,248,30)];
    _view2.center=CGPointMake(screenRect.size.width/2, _view2.center.y);
    _view2.backgroundColor=[UIColor clearColor];
    [_view2 InitData];
    _view2.tvTextInside.text=@"Как отследить заказ?";
    _view2.translatesAutoresizingMaskIntoConstraints = NO;

    [_vAboutInside addSubview:_view2];
//----раздвигающийся view3-------------------------------------------------------------
    _view3 = [[ViewEx alloc] initWithFrame:CGRectMake(36,275,248,30)];
    _view3.center=CGPointMake(screenRect.size.width/2, _view3.center.y);
    _view3.backgroundColor=[UIColor clearColor];
    [_view3 InitData];
    _view3.tvTextInside.text=@"Как изменить данные доставки?";
    _view3.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_vAboutInside addSubview:_view3];
    
//----простой текст2
    _tvAboutDown = [[UITextView alloc] initWithFrame:CGRectMake(36, 305, 248, 144)];
    _tvAboutDown.center=CGPointMake(screenRect.size.width/2, _tvAboutDown.center.y);
    _tvAboutDown.text = @"Суд зачёл пребывание Васильевой под домашним арестом с ноября 2012 года. На свободу она сможет выйти в 2017 году, сообщает ТАСС. Через месяц защита бывшей чиновницы сможет подать на условно-досрочное освобождение, поскольку она отбудет половину срока.";
    
    _tvAboutDown.backgroundColor=[UIColor clearColor];
    _tvAboutDown.textColor=[UIColor colorWithRed:108.0/255.0
                                           green:106.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    _tvAboutDown.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _tvAboutDown.userInteractionEnabled=NO;
    _tvAboutDown.translatesAutoresizingMaskIntoConstraints = NO;
    [_vAboutInside addSubview:_tvAboutDown];
//добавляем привязки-----------------------------------------------------------------------------------
    // 1. Create a dictionary of views
    NSDictionary *viewsDictionary = @{@"view1":_view1, @"view2":_view2,
                                      @"view3":_view3, @"Text":_tvAboutDown};
    
    
    // 2. Define the views Sizes
    NSArray *Viwe1_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view1(30)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    NSArray *Viwe1_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view1(248)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    [_view1 addConstraints:Viwe1_constraint_H];
    [_view1 addConstraints:Viwe1_constraint_V];

    _view1.WitdhConstrain=[Viwe1_constraint_H objectAtIndex:0];
    
    NSArray *Viwe2_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view2(30)]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:viewsDictionary];
    
    NSArray *Viwe2_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view2(248)]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:viewsDictionary];
    [_view2 addConstraints:Viwe2_constraint_H];
    [_view2 addConstraints:Viwe2_constraint_V];
    
    _view2.WitdhConstrain=[Viwe2_constraint_H objectAtIndex:0];

    NSArray *Viwe3_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view3(30)]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    
    NSArray *Viwe3_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view3(248)]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    [_view3 addConstraints:Viwe3_constraint_H];
    [_view3 addConstraints:Viwe3_constraint_V];
    
    _view3.WitdhConstrain=[Viwe3_constraint_H objectAtIndex:0];

    
    NSArray *Text_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[Text(144)]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    
    NSArray *Text_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Text(248)]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    [_tvAboutDown addConstraints:Text_constraint_H];
    [_tvAboutDown addConstraints:Text_constraint_V];

    
    int iBorder=(screenRect.size.width-248)/2;
    NSDictionary *metrics = @{@"hSpacing":[NSNumber numberWithInt:iBorder]};
    
    NSArray *constraint_POS_V = [NSLayoutConstraint
            constraintsWithVisualFormat:@"V:|-215-[view1]-0-[view2]-0-[view3]-0-[Text]"
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:viewsDictionary];
    
    NSArray *constraint_POS_H1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hSpacing-[view1]"
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:viewsDictionary];

    NSArray *constraint_POS_H2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hSpacing-[view2]"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:viewsDictionary];

    NSArray *constraint_POS_H3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hSpacing-[view3]"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:viewsDictionary];
//36
    NSArray *constraint_POS_TEXT = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hSpacing-[Text]"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:viewsDictionary];

    [_vAboutInside addConstraints:constraint_POS_V];
    [_vAboutInside addConstraints:constraint_POS_H1];
    [_vAboutInside addConstraints:constraint_POS_H2];
    [_vAboutInside addConstraints:constraint_POS_H3];
    [_vAboutInside addConstraints:constraint_POS_TEXT];
//инизиализация _vFeedBack=============================================================
    _vFeedBack=[[UIView alloc]initWithFrame:
                      CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];

    UIGraphicsBeginImageContext(_vFeedBack.frame.size);
    [[UIImage imageNamed:@"fon.png"] drawInRect:_vFeedBack.bounds];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _vFeedBack.backgroundColor = [UIColor colorWithPatternImage:image];
    
    _vFeedBackInside=[[UIScrollView alloc]initWithFrame:_vFeedBack.frame];

    _vFeedBackInside.showsVerticalScrollIndicator=YES;
    _vFeedBackInside.scrollEnabled=YES;
    _vFeedBackInside.userInteractionEnabled=YES;
    _vFeedBackInside.contentSize = CGSizeMake(screenRect.size.width,800);
    

 //   [_vFeedBackInside setBackgroundColor:[UIColor clearColor]];
    [_vFeedBack addSubview:_vFeedBackInside];

//----первая часть для верхнего текста
    _vFeedBackTVUp1 = [[UITextView alloc] initWithFrame:CGRectMake(36, 5, 228, 90)];
    _vFeedBackTVUp1.center=CGPointMake(screenRect.size.width/2, _vFeedBackTVUp1.center.y);
    _vFeedBackTVUp1.text = @"Позвонить нам (с 10.00 до 21.00)";
    
    _vFeedBackTVUp1.backgroundColor=[UIColor clearColor];
    _vFeedBackTVUp1.textColor=[UIColor colorWithRed:108.0/255.0
                                             green:108.0/255.0 blue:106.0/255.0 alpha:1.0];

    _vFeedBackTVUp1.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _vFeedBackTVUp1.userInteractionEnabled=NO;
    [_vFeedBackInside addSubview:_vFeedBackTVUp1];
//----вторая часть для верхнего текста
    _vFeedBackTVUp2 = [[UITextView alloc] initWithFrame:CGRectMake(36, 20, 228, 90)];
    _vFeedBackTVUp2.center=CGPointMake(screenRect.size.width/2, _vFeedBackTVUp2.center.y);
    _vFeedBackTVUp2.text = @"8 800 000-00-00 ";
    
    _vFeedBackTVUp2.backgroundColor=[UIColor clearColor];
    _vFeedBackTVUp2.textColor=[UIColor colorWithRed:108.0/255.0
                                           green:108.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    _vFeedBackTVUp2.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _vFeedBackTVUp2.userInteractionEnabled=NO;
    [_vFeedBackInside addSubview:_vFeedBackTVUp2];
//----третья часть для верхнего текста
    _vFeedBackTVUp3 = [[UITextView alloc] initWithFrame:CGRectMake(36, 55, 228, 90)];
    _vFeedBackTVUp3.center=CGPointMake(screenRect.size.width/2, _vFeedBackTVUp3.center.y);
    _vFeedBackTVUp3.text = @"Напишите нам на e-mail:";
    
    _vFeedBackTVUp3.backgroundColor=[UIColor clearColor];
    _vFeedBackTVUp3.textColor=[UIColor colorWithRed:108.0/255.0
                                            green:108.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    _vFeedBackTVUp3.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _vFeedBackTVUp3.userInteractionEnabled=NO;
    [_vFeedBackInside addSubview:_vFeedBackTVUp3];
//----четвёртая часть для верхнего текста
    _vFeedBackTVUp4 = [[UITextView alloc] initWithFrame:CGRectMake(36, 70, 228, 90)];
    _vFeedBackTVUp4.center=CGPointMake(screenRect.size.width/2, _vFeedBackTVUp4.center.y);
    _vFeedBackTVUp4.text = @"support@manyflowers.ru";
    
    _vFeedBackTVUp4.backgroundColor=[UIColor clearColor];
   _vFeedBackTVUp4.textColor=[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    _vFeedBackTVUp4.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _vFeedBackTVUp4.userInteractionEnabled=NO;
    [_vFeedBackInside addSubview:_vFeedBackTVUp4];
//----картинка телефонной трубки
    _iFeedBackFeedBackImage = [[UIImageView alloc] initWithFrame:
                               CGRectMake(screenRect.size.width/2+80, 15, 50, 50)];
    [_vFeedBackInside addSubview:_iFeedBackFeedBackImage];
    [_iFeedBackFeedBackImage setImage:[UIImage imageNamed:@"PhoneCall.png"]];
//----Заговолок
    _tvFeedBackHead = [[UITextView alloc] initWithFrame:CGRectMake(36, 100, 228, 40)];
    _tvFeedBackHead.center=CGPointMake(screenRect.size.width/2, _tvFeedBackHead.center.y);
    _tvFeedBackHead.text = @"Написать нам";
    _tvFeedBackHead.backgroundColor=[UIColor clearColor];
    _tvFeedBackHead.textColor=[UIColor colorWithRed:44.0/255.0
                                              green:49.0/255.0 blue:45.0/255.0 alpha:1.0];
    _tvFeedBackHead.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:16];
    _tvFeedBackHead.userInteractionEnabled=NO;
    [_vFeedBackInside addSubview:_tvFeedBackHead];
    //поле имя
    _fMyFeedBackName = [[UITextField alloc] initWithFrame:CGRectMake(35, 135, 250, 32)];
    _fMyFeedBackName.center=CGPointMake(screenRect.size.width/2, _fMyFeedBackName.center.y);
    _fMyFeedBackName.borderStyle = UITextBorderStyleNone;
    _fMyFeedBackName.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _fMyFeedBackName.text=@"Ваше имя";
    _fMyFeedBackName.textColor=[UIColor colorWithRed:108.0/255.0
                                            green:106.0/255.0 blue:106.0/255.0 alpha:1.0];
    _fMyFeedBackName.background = [UIImage imageNamed:@"Rectangle 341.png"];
    _fMyFeedBackName.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    _fMyFeedBackName.leftView = paddingView;
    _fMyFeedBackName.leftViewMode = UITextFieldViewModeAlways;
    [_vFeedBackInside addSubview:_fMyFeedBackName];
    //поле телефон
    _fMyFeedPhone = [[SHSPhoneTextField alloc] initWithFrame:CGRectMake(35,180, 250, 32)];
    _fMyFeedPhone.center=CGPointMake(screenRect.size.width/2, _fMyFeedPhone.center.y);
    [_fMyFeedPhone.formatter setDefaultOutputPattern:@"(###) ###-##-##"];
    _fMyFeedPhone.formatter.prefix = @"+7 ";
    _fMyFeedPhone.borderStyle = UITextBorderStyleNone;
    _fMyFeedPhone.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _fMyFeedPhone.text=@"+7 (___) ___-__-__";
    _fMyFeedPhone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _fMyFeedPhone.background = [UIImage imageNamed:@"Rectangle 341.png"];
    _fMyFeedPhone.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    _fMyFeedPhone.textColor=[UIColor colorWithRed:108.0/255.0
                                         green:106.0/255.0 blue:106.0/255.0 alpha:1.0];
    _fMyFeedPhone.leftView = paddingView;
    _fMyFeedPhone.leftViewMode = UITextFieldViewModeAlways;
    [_vFeedBackInside addSubview:_fMyFeedPhone];
    //поле Email
    _fMyFeedBackEmail = [[UITextField alloc] initWithFrame:CGRectMake(35, 225, 250, 32)];
    _fMyFeedBackEmail.center=CGPointMake(screenRect.size.width/2, _fMyFeedBackEmail.center.y);
    _fMyFeedBackEmail.borderStyle = UITextBorderStyleNone;
    _fMyFeedBackEmail.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _fMyFeedBackEmail.text=@"E-mail";
    _fMyFeedBackEmail.textColor=[UIColor colorWithRed:108.0/255.0
                                            green:106.0/255.0 blue:106.0/255.0 alpha:1.0];
    _fMyFeedBackEmail.background = [UIImage imageNamed:@"Rectangle 341.png"];
    _fMyFeedBackEmail.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    _fMyFeedBackEmail.leftView = paddingView;
    _fMyFeedBackEmail.leftViewMode = UITextFieldViewModeAlways;
    [_vFeedBackInside addSubview:_fMyFeedBackEmail];
    
    //сообщение
    _fMyFeedMessage = [[UITextView alloc] initWithFrame:CGRectMake(35, 275, 250, 95)];
    _fMyFeedMessage.center=CGPointMake(screenRect.size.width/2, _fMyFeedMessage.center.y);
    _fMyFeedMessage.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    _fMyFeedMessage.text=@"Текст";
    
    _iFeedBackBackMessage = [[UIImageView alloc] initWithFrame:_fMyFeedMessage.frame];
    [_iFeedBackBackMessage setImage:[UIImage imageNamed:@"Rectangle_big.png"]];
    [_vFeedBackInside addSubview:_iFeedBackBackMessage];
    
    _fMyFeedMessage.backgroundColor = [UIColor clearColor];
    _fMyFeedMessage.delegate = self;
    UIBezierPath* aObjBezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 10, 95)];
    textFieldWich.textContainer.exclusionPaths  = @[aObjBezierPath];
    
    [_vFeedBackInside addSubview:_fMyFeedMessage];
    
    //кнопка отправить сообщение
    _bFeedBackSent = [UIButton buttonWithType:UIButtonTypeCustom];
    _bFeedBackSent.frame = CGRectMake(screenRect.size.width/2-125,380,184,24);
    [_bFeedBackSent setImage:[UIImage imageNamed:@"SENT.png"] forState:UIControlStateNormal];
    [_bFeedBackSent setImage:[UIImage imageNamed:@"SENT.png"] forState:UIControlStateHighlighted];
    [_bFeedBackSent addTarget:self action:@selector(SendFeedBack:)forControlEvents:UIControlEventTouchUpInside];
    [_vFeedBackInside addSubview:_bFeedBackSent];

    [vMain addSubview:_vFeedBack];
//инизиализация vCreate=============================================================
    [vMain addSubview:vCreate];
    
    scrollviewCreate=[[UIScrollView alloc]initWithFrame:
                              CGRectMake(0,0,vMain.bounds.size.width,
                                         vMain.bounds.size.height)];
//----сдвиг всего вьювера
    scrollviewCreate.showsVerticalScrollIndicator=YES;
    scrollviewCreate.scrollEnabled=YES;
    scrollviewCreate.userInteractionEnabled=YES;
    scrollviewCreate.contentSize = CGSizeMake(vMain.bounds.size.width,800);
    [vCreate addSubview:scrollviewCreate];
//----шапка для экрана
    TextViewCreateUp = [[UITextView alloc] initWithFrame:CGRectMake(36, 0, 248, 90)];
    TextViewCreateUp.center=CGPointMake(screenRect.size.width/2, TextViewCreateUp.center.y);
    TextViewCreateUp.text = @"Если Вы не нашли подходящего для себя букета — заполните информацию о получателе, укажите свои пожелания, и флорист создаст для вас индивидуальный букет";
    
    TextViewCreateUp.backgroundColor=[UIColor clearColor];
    TextViewCreateUp.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    TextViewCreateUp.userInteractionEnabled=NO;
    [scrollviewCreate addSubview:TextViewCreateUp];
    
//----для кого
    textFieldFor = [[UITextField alloc] initWithFrame:CGRectMake(35, 100, 250, 32)];
    textFieldFor.center=CGPointMake(screenRect.size.width/2, textFieldFor.center.y);

  //  textFieldFor.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    textFieldFor.borderStyle = UITextBorderStyleNone;
    textFieldFor.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    textFieldFor.text=@"Кому: любимой, жене, коллеге...";
    textFieldFor.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFieldFor.background = [UIImage imageNamed:@"Rectangle 341.png"];
    textFieldFor.delegate = self;
    //    [textFieldFor setEnabled:NO];
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    textFieldFor.leftView = paddingView;
    textFieldFor.leftViewMode = UITextFieldViewModeAlways;
    [scrollviewCreate addSubview:textFieldFor];

//----по какому поводу
    textFieldCase = [[UITextField alloc] initWithFrame:CGRectMake(35, 140, 250, 32)];
    textFieldCase.center=CGPointMake(screenRect.size.width/2, textFieldCase.center.y);
    
    textFieldCase.borderStyle = UITextBorderStyleNone;
    textFieldCase.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    textFieldCase.text=@"По какому случаю";
    textFieldCase.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFieldCase.background = [UIImage imageNamed:@"Rectangle 341.png"];
    textFieldCase.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    textFieldCase.leftView = paddingView;
    textFieldCase.leftViewMode = UITextFieldViewModeAlways;
    [scrollviewCreate addSubview:textFieldCase];
//----телефон
    textFieldPhone = [[SHSPhoneTextField alloc]
                                         initWithFrame:CGRectMake(35, 180, 250, 32)];
    textFieldPhone.center=CGPointMake(screenRect.size.width/2, textFieldPhone.center.y);

    [textFieldPhone.formatter setDefaultOutputPattern:@"(###) ###-##-##"];
    textFieldPhone.formatter.prefix = @"+7 ";

    textFieldPhone.borderStyle = UITextBorderStyleNone;
    textFieldPhone.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
//    textField.placeholder = @"enter text";
    textFieldPhone.text=@"+7 (___) ___-__-__";
 //   textField.autocorrectionType = UITextAutocorrectionTypeNo;
//    textField.keyboardType = UIKeyboardTypeDefault;
 //   textField.returnKeyType = UIReturnKeyDone;
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldPhone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFieldPhone.background = [UIImage imageNamed:@"Rectangle 341.png"];
    textFieldPhone.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    textFieldPhone.leftView = paddingView;
    textFieldPhone.leftViewMode = UITextFieldViewModeAlways;

    [scrollviewCreate addSubview:textFieldPhone];
//----пожелание
    textFieldWich = [[UITextView alloc] initWithFrame:CGRectMake(35, 220, 250, 95)];
    textFieldWich.center=CGPointMake(screenRect.size.width/2, textFieldWich.center.y);
    textFieldWich.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    textFieldWich.text=@"Пожелание к букету: цвет,состав";
    textFieldWich.backgroundColor = [UIColor colorWithPatternImage:
                                     [UIImage imageNamed: @"Rectangle_big.png"]];
    textFieldWich.delegate = self;
    
    aObjBezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 10, 95)];
    textFieldWich.textContainer.exclusionPaths  = @[aObjBezierPath];
    
    [scrollviewCreate addSubview:textFieldWich];
//----по какому поводу
    tfCreatePrice = [[UITextField alloc] initWithFrame:CGRectMake(35, 325, 250, 32)];
    tfCreatePrice.center=CGPointMake(screenRect.size.width/2, tfCreatePrice.center.y);
    
    tfCreatePrice.borderStyle = UITextBorderStyleNone;
    tfCreatePrice.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    tfCreatePrice.text=@"Стоимость до...";
    tfCreatePrice.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tfCreatePrice.background = [UIImage imageNamed:@"Rectangle 341.png"];
    tfCreatePrice.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    tfCreatePrice.leftView = paddingView;
    tfCreatePrice.leftViewMode = UITextFieldViewModeAlways;

    [scrollviewCreate addSubview:tfCreatePrice];
//----кнопка отправить
    bCreateSendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bCreateSendButton.frame = CGRectMake(101, 370, 184, 24);
    bCreateSendButton.center=CGPointMake(tfCreatePrice.center.x+33, bCreateSendButton.center.y);

    bCreateSendButton.backgroundColor = [UIColor clearColor];
    
    [bCreateSendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *buttonImageNormal = [UIImage imageNamed:@"SENT.png"];
    UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [bCreateSendButton setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
    
    [bCreateSendButton addTarget:self action:@selector(SendMessageCreate:) forControlEvents:UIControlEventTouchUpInside];
    [scrollviewCreate addSubview:bCreateSendButton];
//==================================================================================
    [vMain addSubview:vSales];
    [vMain addSubview:vFavorits];
    [vMain addSubview:vDel_Pay];
    [vMain addSubview:vShoping];
    [vMain addSubview:vOptions];
    [vMain addSubview:vFAQ];
    [vMain addSubview:vClients];
    [vMain addSubview:vAbout];
    [vMain addSubview:vFinishShop];
    [vMain addSubview:vInsideFinishShop];

    [self ClearViews];

    
//    [fName addTarget:fName
//              action:@selector(resignFirstResponder)
//    forControlEvents:UIControlEventEditingDidEndOnExit];
//    
//    [fPhone addTarget:fPhone
//               action:@selector(resignFirstResponder)
//     forControlEvents:UIControlEventEditingDidEndOnExit];
//    
//    [fEmail addTarget:fEmail
//               action:@selector(resignFirstResponder)
//     forControlEvents:UIControlEventEditingDidEndOnExit];
//    
//    [fAdress addTarget:fAdress
//                action:@selector(resignFirstResponder)
//      forControlEvents:UIControlEventEditingDidEndOnExit];

    
//    [lUpToPrice setTranslatesAutoresizingMaskIntoConstraints:YES];
//    [vSalesTable setTranslatesAutoresizingMaskIntoConstraints:YES];
//    [vFavoritsTable setTranslatesAutoresizingMaskIntoConstraints:YES];
//инициализация экранов шагов покупки======================================================
    ivPostard = [[UIImageView alloc] init];
    [vInsideFinishShop addSubview:ivPostard];
    [ivPostard setImage:[UIImage imageNamed:@"postcart.png"]];

    
    imageLine1 = [[UIImageView alloc] init];
    
    imageLine1.frame=CGRectMake(0,0,258,1);
    [imageLine1 setImage:[UIImage imageNamed:@"LineCell.png"]];
    [vInsideFinishShop addSubview:imageLine1];

    imageLine2 = [[UIImageView alloc] init];
    
    imageLine2.frame=CGRectMake(0,0,258,1);
    [imageLine2 setImage:[UIImage imageNamed:@"LineCell.png"]];
    [vInsideFinishShop addSubview:imageLine2];

    
    imageLine = [[UIImageView alloc] init];
    [vInsideFinishShop addSubview:imageLine];
    
    imageLine.frame=CGRectMake(0,0,248,3);
    [imageLine setImage:[UIImage imageNamed:@"LINE.png"]];

    imageLine1Shop = [[UIImageView alloc] init];
    [vInsideFinishShop addSubview:imageLine1Shop];
    
    imageLine1Shop.frame=CGRectMake(0,0,248,1);
    [imageLine1Shop setImage:[UIImage imageNamed:@"LineCell.png"]];

    
    iStep = [[UIImageView alloc] init];
    [vInsideFinishShop addSubview:iStep];

    lAdressDelivery = [[UILabel alloc] init];
    lAdressDelivery.font = [UIFont fontWithName:@"RobotoSlab-bold" size:13];
    [vInsideFinishShop addSubview:lAdressDelivery];

    lDateDelivery = [[UILabel alloc] init];
    lDateDelivery.font=[UIFont fontWithName:@"RobotoSlab-bold" size:13];
    [vInsideFinishShop addSubview:lDateDelivery];
    
    bNewAdress = [[UIButton alloc] init];
    [bNewAdress setImage:[UIImage imageNamed:@"ADD ADRES.png"] forState:UIControlStateNormal];
    [bNewAdress setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [bNewAdress addTarget:self
                   action:@selector(aAddAdress:)forControlEvents:UIControlEventTouchDown];
    [vInsideFinishShop addSubview:bNewAdress];

    
    bEditAdress = [[UIButton alloc] init];
    [bEditAdress setBackgroundImage:[UIImage
                                    imageNamed:@"bg-filter.png"] forState:UIControlStateNormal];
    [bEditAdress setTitle:@"Изменить" forState:UIControlStateNormal];
    [bEditAdress setTitle:@"Изменить" forState:UIControlStateHighlighted];
    [bEditAdress setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [bEditAdress addTarget:self
               action:@selector(aChangeAdressTable:)forControlEvents:UIControlEventTouchDown];

    [vInsideFinishShop addSubview:bEditAdress];

    tAdresTable = [[UITableView alloc] init];
    [vInsideFinishShop addSubview:tAdresTable];
    tAdresTable.delegate=self;
    tAdresTable.dataSource = self;
    tAdresTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    tAdresTable.backgroundColor=[UIColor clearColor];
    [tAdresTable setShowsHorizontalScrollIndicator:NO];
    [tAdresTable setShowsVerticalScrollIndicator:NO];
 //   tAdresTable.backgroundColor=TileColor;

    pDateDelivery = [[UIDatePicker alloc] init];
    [vInsideFinishShop addSubview:pDateDelivery];
    
    bToDay = [UIButton buttonWithType:UIButtonTypeCustom];
    [vInsideFinishShop addSubview:bToDay];
//    [bToDay setBackgroundImage:[UIImage imageNamed:@"bg-filter@2x.png"] forState:UIControlStateNormal];
//    [bToDay setBackgroundImage:[UIImage imageNamed:@"bg-filter@2x.png"]forState:UIControlStateHighlighted];
    [bToDay setTitle:@"       Ближайшее время" forState:UIControlStateNormal];
    [bToDay setTitle:@"       Ближайшее время" forState:UIControlStateHighlighted];
    [bToDay setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [bToDay addTarget:self
                 action:@selector(aToDay:)forControlEvents:UIControlEventTouchDown];
    
    [bToDay setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [bToDay setTitleColor:[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:106/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    vImageCachGrey = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Check-grey-on.png"]];
    bToDay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    vImageCachGrey.frame=CGRectMake(0, 8, 15, 15);
    [bToDay addSubview:vImageCachGrey];
    iCheck=YES;
    
    bToDay.titleLabel.font=[UIFont fontWithName:@"RobotoSlab-Regular" size:12];

    
    
    bCach = [UIButton buttonWithType:UIButtonTypeCustom];
    [vInsideFinishShop addSubview:bCach];
    [bCach setBackgroundImage:[UIImage imageNamed:@"bg-selest-green.png"] forState:UIControlStateNormal];
[bCach setBackgroundImage:[UIImage imageNamed:@"bg-selest-green.png"]forState:UIControlStateHighlighted];
    [bCach setTitle:@"          Наличные при получении" forState:UIControlStateNormal];
    [bCach setTitle:@"          Наличные при получении" forState:UIControlStateHighlighted];
    [bCach setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [bCach setTitleColor:[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:106/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    vImageCach = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Check_on.png"]];
    bCach.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    vImageCach.frame=CGRectMake(7, 7, 15, 15);
    [bCach addTarget:self
                 action:@selector(aCach:)forControlEvents:UIControlEventTouchDown];
    bCach.enabled=NO;
    bCach.titleLabel.font=[UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    [bCach addSubview:vImageCach];

    
    //дата доставки
    fDateDeliv = [[UITextField alloc] initWithFrame:CGRectMake(35, 100, 250, 32)];
    
    fDateDeliv.borderStyle = UITextBorderStyleNone;
    fDateDeliv.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    fDateDeliv.text=@"17 мая 2005";
    fDateDeliv.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    fDateDeliv.background = [UIImage imageNamed:@"Rectangle 341.png"];
    fDateDeliv.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    fDateDeliv.leftView = paddingView;
    fDateDeliv.leftViewMode = UITextFieldViewModeAlways;
    
    fDateDeliv.textColor=[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:106/255.0 alpha:1.0];
    [vInsideFinishShop addSubview:fDateDeliv];
    
    bCalendar = [[UIButton alloc] init];//кнопка календарь
    [bCalendar setImage:[UIImage imageNamed:@"ButtonCalendar.png"] forState:UIControlStateNormal];
    [bCalendar setImage:[UIImage imageNamed:@"ButtonCalendar.png"] forState:UIControlStateHighlighted];

    [bCalendar setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [bCalendar addTarget:self
                  action:@selector(sGetDate:)forControlEvents:UIControlEventTouchDown];
    [vInsideFinishShop addSubview:bCalendar];


    fTimeDeliv = [[UITextField alloc] initWithFrame:CGRectMake(35, 100, 250, 32)];
    
    fTimeDeliv.borderStyle = UITextBorderStyleNone;
    fTimeDeliv.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    fTimeDeliv.text=@"Укажите время";
    fTimeDeliv.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    fTimeDeliv.background = [UIImage imageNamed:@"Rectangle 341.png"];
    fTimeDeliv.delegate = self;
    //    [textFieldFor setEnabled:NO];
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
    fTimeDeliv.leftView = paddingView;
    fTimeDeliv.leftViewMode = UITextFieldViewModeAlways;
    
    fTimeDeliv.textColor=[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:106/255.0 alpha:1.0];
    [vInsideFinishShop addSubview:fTimeDeliv];

    
//элементы для шагов покупки================================================================
    bNonCach = [UIButton buttonWithType:UIButtonTypeCustom];
    [vInsideFinishShop addSubview:bNonCach];
//    [bNonCach setBackgroundImage:[UIImage imageNamed:@"bg-selest-green.png"] forState:UIControlStateNormal];
//[bNonCach setBackgroundImage:[UIImage imageNamed:@"bg-selest-green.png"]forState:UIControlStateHighlighted];
    [bNonCach setTitle:@"          Пластиковой картой" forState:UIControlStateNormal];
    [bNonCach setTitle:@"          Пластиковой картой" forState:UIControlStateHighlighted];
    [bNonCach setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [bNonCach setTitleColor:[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:106/255.0 alpha:1.0] forState:UIControlStateNormal];

    vImageNoCach = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Check_off.png"]];
    bNonCach.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    vImageNoCach.frame=CGRectMake(7, 7, 15, 15);
    [bNonCach addTarget:self
               action:@selector(aNonCach:)forControlEvents:UIControlEventTouchDown];
    bNonCach.titleLabel.font=[UIFont fontWithName:@"RobotoSlab-Regular" size:12];
    [bNonCach addSubview:vImageNoCach];

    
    tMessage = [[UITextView alloc] initWithFrame:CGRectMake(35, 220, 250, 61)];
    tMessage.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    tMessage.text=@"Дополнительная информация";
    tMessage.backgroundColor = [UIColor colorWithPatternImage:
                                     [UIImage imageNamed: @"InfoPostCard.png"]];
    tMessage.delegate = self;
    aObjBezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 6, 95)];
    tMessage.textContainer.exclusionPaths  = @[aObjBezierPath];
    [vInsideFinishShop addSubview:tMessage];

    tMessagePost = [[UITextView alloc] initWithFrame:CGRectMake(35, 220, 250, 61)];
    tMessagePost.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    tMessagePost.text=@"Добавить открытку";
    tMessagePost.backgroundColor = [UIColor clearColor];
    tMessagePost.textColor = [UIColor colorWithRed:183.0/255 green:213.0/255 blue:171.0/255 alpha:1];
    tMessagePost.delegate = self;
    aObjBezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 7, 95)];
    tMessagePost.textContainer.exclusionPaths  = @[aObjBezierPath];
    [vInsideFinishShop addSubview:tMessagePost];

    
    imageLineOn3step = [[UIImageView alloc] init];
    [vInsideFinishShop addSubview:imageLineOn3step];
    
    imageLineOn3step.frame=CGRectMake(0,0,248,3);
    [imageLineOn3step setImage:[UIImage imageNamed:@"plus-line.png"]];

//    sPostCard=[[UISlider alloc] init];
//    [sPostCard setMaximumValue:4];
//    [sPostCard setMinimumValue:0];
//    [vInsideFinishShop addSubview:sPostCard];
//    [sPostCard addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];

    
    lFourStepHeader = [[UILabel alloc] init];
    lFourStepHeader.font=[UIFont fontWithName:@"RobotoSlab-bold" size:15];
    [vInsideFinishShop addSubview:lFourStepHeader];

    lFourNameShop = [[UILabel alloc] init];
    lFourNameShop.font=[UIFont fontWithName:@"RobotoSlab-bold" size:15];
    [vInsideFinishShop addSubview:lFourNameShop];

    tMessageUp=[[UITextView alloc] init];
    tMessageUp.delegate = self;
    tMessageUp.font=[UIFont fontWithName:@"Roboto-regular" size:12];
    [vInsideFinishShop addSubview:tMessageUp];

    tMessageDown=[[UITextView alloc] init];
    tMessageDown.delegate = self;
    tMessageUp.font=[UIFont fontWithName:@"Roboto-regular" size:12];
    [vInsideFinishShop addSubview:tMessageDown];
    
//=========================================================================================
    UIImage *faceImage = [UIImage imageNamed:@"Buy.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    [face addTarget:self action:@selector(ShopithCart:) forControlEvents:UIControlEventTouchDown];
    face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
    [face setImage:faceImage forState:UIControlStateNormal];
    
    ShopithCart = [[UIBarButtonItem alloc] initWithCustomView:face];
    self.navigationItem.rightBarButtonItem = ShopithCart;
    
    UIImage *bImage = [UIImage imageNamed:@"Options.png"];
    UIButton* infoButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [infoButton addTarget:self action:@selector(Options:) forControlEvents:UIControlEventTouchDown];
    infoButton.bounds = CGRectMake( 0, 0, bImage.size.width, bImage.size.height );
    [infoButton setImage:bImage forState:UIControlStateNormal];
    
    optionButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    self.navigationItem.leftBarButtonItem = optionButton;
    
    self.view.frame=CGRectMake(30, 0, screenRect.size.width, screenRect.size.height);
    
    iCurSel=1;
    [self Catalog:I_PAGE_CATALOG];
    
    [self setNeedsDisplay];
}
- (void)viewDidAppear:(BOOL)animated {
//- (void)viewWillAppear:(BOOL)animated {

//    UINavigationBar *navigationBar = [[self navigationController] navigationBar];
//    CGRect frame = [navigationBar frame];
//    frame.size.height = 20.0f;
 //   [navigationBar setFrame:frame];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                            [UIFont fontWithName:@"PTSans-Bold" size:16.0f], NSFontAttributeName,
                            [UIColor blackColor], NSForegroundColorAttributeName,
                            nil, NSShadowAttributeName,nil]];
    
    [self UpdateAdres];
}

//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait  | UIInterfaceOrientationMaskPortraitUpsideDown;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int iHeight=0;
    
    switch(iCurSel)
    {
        case I_PAGE_FINISH_BUY:
        {
            if(tableView==tAdresTable)
            {
                iHeight=SIZE_ADRES_CELL;
            }
        }
        break;
            
        case I_PAGE_SHOPING:
        {
            if(indexPath.row==[self->pDataFlowers->pDataCellsShops count])
            {
                if([self->pDataFlowers->pDataCellsShops count]>1)
                {
                    iHeight=120;
                }
                else
                {
                    iHeight=56;
                }
            }
            else
            {
                if([self->pDataFlowers->pDataCellsShops count]==1)
                {//высота обычных ячеек
                    iHeight=164;
                }
                else
                {
                    iHeight=144;
                }
            }
        }
        break;
            
        case I_PAGE_CATALOG:
        {
            NSString *KeyRow = [NSString stringWithFormat:@"%d",(int)indexPath.row];
            ManyFlowersCell *pDataCell=[vArrCatalog objectForKey:KeyRow];

            if(pDataCell!=nil)
            {
                if(IPAD)
                {
                    iHeight=302;
                }
                else
                {
                    if(pDataCell.Big==YES)
                    {
                        iHeight=430;
                    }
                    else
                    {
                        iHeight=240;
                    }
                }
            }
            else
            {
                iHeight=225;
            }
        }
        break;
        
        case I_PAGE_SALES:
        {
            NSString *KeyRow = [NSString stringWithFormat:@"%d",(int)indexPath.row];
            ManyFlowersCell *pDataCell=[vArrSales objectForKey:KeyRow];
            
            if(pDataCell!=nil)
            {
                if(IPAD)
                {
                    iHeight=302;
                }
                else
                {
                    if(pDataCell.Big==YES)
                    {
                        iHeight=430;
                    }
                    else
                    {
                        iHeight=230;
                    }
                }
            }
            else
            {
                iHeight=225;
            }
        }
        break;
            
        case I_PAGE_FAVORITS:
            
            if(indexPath.row==[self->pDataFlowers->pDataCellsFavorits count])
            {
                iHeight=50;
            }
            else iHeight=134;
            break;
    }
    
    return iHeight;

}

- (NSInteger)SetFilter
{
    NSInteger iCount= [vArrCatalogFilter count];
    [vArrCatalogFilter removeAllObjects];

    int j=0;
    for (int i=0;i<[pDataFlowers->pDataCellsCatalog count];i++)
    {
        BOOL IsAdd=YES;

        FlowersDataCell *Cell=[pDataFlowers->pDataCellsCatalog objectAtIndex:i];
        
        if(iNumFilerFlowers>0)
        {
            BOOL isFind=NO;
            for (int k=0; k<[Cell->DicFilterFlower count]; k++)
            {
                NSNumber *TmpValue=(NSNumber *)[Cell->DicFilterFlower objectAtIndex:k];
                
                NSInteger TValue= [TmpValue integerValue];
                if(TValue==iNumFilerFlowers)
                {
                    isFind=YES;
                    break;
                }
            }
            
            if(isFind==NO)
                IsAdd=NO;
        }

        if(iNumFilerToMan>0)
        {
            BOOL isFind=NO;
            for (int k=0; k<[Cell->DicFilterDest count]; k++)
            {
                NSNumber *TmpValue=(NSNumber *)[Cell->DicFilterDest objectAtIndex:k];
                
                NSInteger TValue= [TmpValue integerValue];
                if(TValue==iNumFilerToMan)
                {
                    isFind=YES;
                    break;
                }
            }
            
            if(isFind==NO)
                IsAdd=NO;
        }

        if(iNumFilerPrice>0)
        {
            BOOL isFind=NO;
            for (int k=0; k<[Cell->DicFilterPrice count]; k++)
            {
                NSNumber *TmpValue=(NSNumber *)[Cell->DicFilterPrice objectAtIndex:k];
                
                NSInteger TValue= [TmpValue integerValue];
                if(TValue==iNumFilerPrice)
                {
                    isFind=YES;
                    break;
                }
            }
            
            if(isFind==NO)
                IsAdd=NO;
        }

        
        if(IsAdd)
        {
            [vArrCatalogFilter addObject:[NSNumber numberWithInteger:i]];
            j++;
        }
    }
    
    iCount= [vArrCatalogFilter count];
    return iCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger iCount=0;
    switch(iCurSel)
    {
        case I_PAGE_FINISH_BUY:
            if(tableView==tAdresTable)
                iCount=[vArrAdressTableTmp count];
            break;

        case I_PAGE_CATALOG:
            iCount= [self SetFilter];
            break;
            
        case I_PAGE_SALES:
            iCount= [self->pDataFlowers->pDataCellsSales count];
            break;
            
        case I_PAGE_FAVORITS:
        {
            
            iCount= [self->pDataFlowers->pDataCellsFavorits count]+1;
            
            if([self->pDataFlowers->pDataCellsFavorits count]==0)
                vFavoritsTable.hidden=YES;
            else vFavoritsTable.hidden=NO;
        }
            break;
            
        case I_PAGE_SHOPING:
        {
            if([pDataFlowers->pDataCellsShops count]==0)
            {
                vShopTable.hidden=YES;
                iCount=0;
            }
            else
            {
                iCount= [self->pDataFlowers->pDataCellsShops count]+1;
                vShopTable.hidden=NO;
            }
        }
    }
    
    return iCount;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setNeedsDisplay];
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    [self setNeedsDisplay];

    switch(iCurSel)
    {
        case I_PAGE_CATALOG:
        {
        }
        break;
            
        case I_PAGE_SHOPING:
        {
            if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row)
            {
                [self UpdatePrieceInfo];
            }
        }
        break;
    }
}

- (IBAction)DeleteAdres:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:tAdresTable];
    NSIndexPath *indexPath = [tAdresTable indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        if(bInMyDataSave==YES)
        {
            if(indexPath.row>0)
            {
                [vArrAdressTable removeObjectAtIndex:indexPath.row];
                [SelectAdress removeObject:indexPath];
            }
        }
        else
        {
            [vArrAdressTable removeObjectAtIndex:indexPath.row];
            [SelectAdress removeObject:indexPath];
        }
        
        [self UpdateAdres];
        [tAdresTable reloadData];
        
        NSLog(@"The content of arry is%@",SelectAdress);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if(tableView==tAdresTable)
    {
        TableViewCell_Adress *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([SelectAdress containsObject:indexPath])
        {
            [SelectAdress removeObject:indexPath];
            
            cell.Back.hidden=YES;
            cell.BackButton.hidden=YES;
            [cell.ImgCheck setImage:[UIImage imageNamed:@"Check_off.png"]];

        }
        else
        {
            cell.Back.hidden=NO;
            cell.BackButton.hidden=NO;
            [cell.ImgCheck setImage:[UIImage imageNamed:@"Check_on.png"]];

            [SelectAdress addObject:indexPath];
        }
        
//        NSLog(@"The content of arry is%@",SelectAdress);
        [tableView reloadData];
    }
}


- (void)downloadQueue
{
repeate:
    if([pQueueDownLoad count]>0)
    {
        if(pClient.bBusy==NO)
        {
            pClient.bBusy=YES;

            NSArray *TmpSet=[pQueueDownLoad objectAtIndex:0];

            //что бы картинки быстрее загружались
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{

                [pClient GetData:[TmpSet objectAtIndex:0] syn:YES download:NO competition:
                 ^(NSData *result,NSString *ID,NSError *error)
                 {
                     if(error!=nil)
                     {
                         [self downloadQueue];
                     }
                     else if(result != nil && [result length]>0)
                     {
                         UIImageView *Tmp=[TmpSet objectAtIndex:1];
                         
                         UIImage *ImgRez=[UIImage imageWithData:result];
                         [Tmp setImage:ImgRez];
                         [pQueueDownLoad removeObjectAtIndex:0];
                     }

                     pClient.bBusy=NO;
                 }];
            }];
        }
    }
    
    [NSThread sleepForTimeInterval:.001];
    goto repeate;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch(iCurSel)
    {
        case I_PAGE_FINISH_BUY:
        {
            if(tableView==tAdresTable)
            {
                static NSString *CellIdentifier = @"TableViewCell_Adress_Identifier";
                TableViewCell_Adress *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                if (cell == nil)
                {
                    cell = [[TableViewCell_Adress alloc] init];
                }
                
                NSString *Tmp=[vArrAdressTableTmp objectAtIndex:(int)indexPath.row];
                cell.tAdress.text=Tmp;
                cell.backgroundColor=TileColor;
                cell.tAdress.font=[UIFont fontWithName:@"Roboto-Regular" size:12];

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.tag=indexPath.row;
                cell.tAdress.tag=indexPath.row;
                
                cell.ButtonClose.tag=indexPath.row;

                [cell.ButtonClose addTarget:self action:@selector(DeleteAdres:) forControlEvents:UIControlEventTouchUpInside];
                
                if(indexPath.row==iCurrentActive)
                {
                    [cell.tAdress becomeFirstResponder];
                    iCurrentActive=-1;
                    TmpTextFieldT=cell.tAdress;
                }
                
                [cell.tAdress addTarget:self
                                 action:@selector(OnDidEnterAdress:)
                 forControlEvents:UIControlEventEditingDidEndOnExit];

                [cell.tAdress addTarget:self
                                 action:@selector(OnDidEnterAdress:)
                       forControlEvents:UIControlEventEditingDidEnd];

                [cell.tAdress addTarget:self
                                 action:@selector(OnDidBeginEnterAdress:)
                       forControlEvents:UIControlEventEditingDidBegin];
                

                cell.tAdress.userInteractionEnabled = NO;
                if(indexPath.row==([vArrAdressTableTmp count]-1) && bNewAdressInTable==YES)
                {
                    cell.tAdress.userInteractionEnabled = YES;
                    tTmpSelect=cell.tAdress;
                }
                
                if ([SelectAdress containsObject:indexPath])
                {
                    cell.Back.hidden=NO;
                    cell.BackButton.hidden=NO;
                    [cell.ImgCheck setImage:[UIImage imageNamed:@"Check_on.png"]];
                }
                else
                {
                    cell.Back.hidden=YES;
                    cell.BackButton.hidden=YES;
                    [cell.ImgCheck setImage:[UIImage imageNamed:@"Check_off.png"]];
                }
                
                return cell;
            }
        }
        break;
            
        case I_PAGE_SHOPING:
        {
            if(indexPath.row==[self->pDataFlowers->pDataCellsShops count])
            {
                static NSString *CellIdentifier = @"CellShop2_Identifier";
                CellShop2 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                if (cell == nil)
                {
                    NSArray *topLevelObjects = [[NSBundle mainBundle]
                                loadNibNamed:@"CellShop2" owner:nil options:nil];
                    
                    for(id currentObject in topLevelObjects)
                    {
                        if([currentObject isKindOfClass:[CellShop2 class]])
                        {
                            cell = (CellShop2 *)currentObject;
                            
                            cell.tag = indexPath.row;
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            
                            [cell.bBuyFinish addTarget:self action:@selector(BuyFinish:) forControlEvents:UIControlEventTouchUpInside];
                            
                            cell.backgroundColor=TileColor;
                            [vArrShop setObject:cell forKey:ELEMAX];
                            
                            cell->pParent=self;
                            
                            break;
                        }
                    }
                }
                
                if([self->pDataFlowers->pDataCellsShops count]>1)
                {
                    cell.Line1.hidden=NO;
                    cell.Line2.hidden=NO;
                    cell.lDelFree.hidden=NO;
                    cell.lSaleLeft.hidden=NO;
                    cell.lSaleRight.hidden=NO;
                    
                    cell.lTotal.center=CGPointMake(cell.lTotal.center.x, 92);
                    cell.lSumaryPrice.center=CGPointMake(cell.lSumaryPrice.center.x, 91);
                    cell.bBuyFinish.center=CGPointMake(cell.bBuyFinish.center.x, 92);
                }
                else
                {
                    cell.Line1.hidden=YES;
                    cell.Line2.hidden=YES;
                    cell.lDelFree.hidden=YES;
                    cell.lSaleLeft.hidden=YES;
                    cell.lSaleRight.hidden=YES;
                    
                    cell.lTotal.center=CGPointMake(cell.lTotal.center.x, 25);
                    cell.lSumaryPrice.center=CGPointMake(cell.lSumaryPrice.center.x, 25);
                    cell.bBuyFinish.center=CGPointMake(cell.bBuyFinish.center.x, 25);
                }

                return cell;
            }
            else
            {
                NSString *KeyRow = [NSString stringWithFormat:@"%d",(int)indexPath.row];

                static NSString *CellIdentifier = @"CellShop1_Identifier";
                CellShop1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                if (cell == nil)
                {
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CellShop1" owner:nil options:nil];
                    
                    for(id currentObject in topLevelObjects)
                    {
                        if([currentObject isKindOfClass:[CellShop1 class]])
                        {
                            cell = (CellShop1 *)currentObject;
                            
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            
                            FlowersDataCell *pDataCell=[pDataFlowers->pDataCellsShops objectAtIndex:indexPath.row];
                            
                            cell.lName.text=pDataCell->Name;
                            cell.lPrice.text=[pDataCell->Price stringByAppendingString:@" Р"];
                            
                             cell.lArticle.text=[NSString stringWithFormat:@"Артикул: %@",pDataCell->Article];
                            
                            cell.tag = indexPath.row;
                            cell.bClose.tag = indexPath.row;
                            [cell.bClose addTarget:self action:@selector(ButtonCloseShop:) forControlEvents:UIControlEventTouchUpInside];
                            
                            [cell.bClose setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
                            
                            cell.backgroundColor=TileColor;
                            
                            cell.stepper.value=pDataCell->NumPiece;
                            cell.valueLabel.text = [NSString stringWithFormat:@"%d",
                                                    (int)cell.stepper.value];
                            
                            [vArrShop setObject:cell forKey:KeyRow];
                            
                            NSMutableString *URLString = [NSMutableString
                                stringWithFormat:@"http://web-air.ru:8082%@",pDataCell->strPictFaforit];
                            
                            NSArray *TmpSet=[NSArray arrayWithObjects:URLString,cell.vPict,nil];
                            [pQueueDownLoad addObject:TmpSet];
                            
                            cell->pParent=self;

                            break;
                        }
                    }
                }
                
                CGRect LineRect=cell.vLine.frame;
                CGRect CellRect=cell.frame;
                LineRect.size.height=1;
                [cell.vLine setImage:[UIImage imageNamed:@"LineCell.png"]];
                float Y=CellRect.size.height-LineRect.size.height;

                if([self->pDataFlowers->pDataCellsShops count]==1)
                {//маленькая ячейка
                    [cell.vLine setImage:[UIImage imageNamed:@"LINE.png"]];
                    LineRect.size.height=3;
                    cell.lDel.hidden=NO;
                    
                    Y=164;
                }
                else
                {
                    cell.lDel.hidden=YES;
                    Y=144;
                }
                
                cell.vLine.frame=LineRect;
                cell.vLine.frame = CGRectMake(LineRect.origin.x, Y,
                                              LineRect.size.width,LineRect.size.height);

                return cell;
            }
        }//корзина
            break;
            
        case I_PAGE_CATALOG:
        {
            UITableViewCell *CellRez=0;
            
            NSNumber *TmpNum= [vArrCatalogFilter objectAtIndex:indexPath.row];
            NSString *KeyRow = [NSString stringWithFormat:@"%d",(int)[TmpNum integerValue]];
            CellRez=[vArrCatalog objectForKey:KeyRow];

            if(IPAD)
            {
                ManyFlowersCellIpad *cell=(ManyFlowersCellIpad *)CellRez;
                
                if (cell == nil)
                {
                    NSArray *topLevelObjects = [[NSBundle mainBundle]
                                loadNibNamed:@"ManyFlowersCellIpad" owner:nil options:nil];
                    
                    for(id currentObject in topLevelObjects)
                    {
                        if([currentObject isKindOfClass:[ManyFlowersCellIpad class]])
                        {
                            cell = (ManyFlowersCellIpad *)currentObject;
                            [vArrCatalog setObject:cell forKey:KeyRow];
                            CellRez=cell;
                            
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            
                            cell.bBuy.tag = indexPath.row;
                            [cell.bBuy addTarget:self action:@selector(ButtonBuy:)
                                forControlEvents:UIControlEventTouchUpInside];


                            
                            FlowersDataCell *pDataCell=[pDataFlowers->pDataCellsCatalog
                                                        objectAtIndex:indexPath.row];
                            
                            cell.lName.text=pDataCell->Name;
                            cell.lPrice.text=[pDataCell->Price stringByAppendingString:@" Р"];
                            
                            cell.ldelivery.text=pDataCell->delivery;
                            cell.lArticle.text=pDataCell->Article;
                            cell.lFlowers.text=pDataCell->flowers;
                            cell.lDxH.text=pDataCell->DxH;
                            cell.lpackage.text=pDataCell->package;
                            cell.lInMCAD.text=pDataCell->InMCAD;
                            cell.lOUTMCAD.text=pDataCell->OUTMCAD;
                            
                            cell.bFavorits.tag = indexPath.row;
                            [cell.bFavorits addTarget:self action:@selector(PutToFavorits:) forControlEvents:UIControlEventTouchUpInside];

                            NSArray *valueffsDicPic = pDataCell->DicPictMain;
                            [cell InitAllPages:(unsigned)[valueffsDicPic count]];
                            
                            for (int i=0;i<[valueffsDicPic count];i++)
                            {
                                [cell loadScrollViewWithPage:i];
                            }
                            
                            for (int i=0;i<[valueffsDicPic count];i++)
                            {
                                NSDictionary *valuesDicPic = [valueffsDicPic objectAtIndex:i];
                                NSArray *values = [valuesDicPic  allValues];
                                
                                NSMutableString *URLString = [NSMutableString
                                                              stringWithFormat:@"http://web-air.ru:8082%@",[values objectAtIndex:0]];
                                
                                ViewControllerListFlower *ViwerImage=
                                [cell.viewControllers objectAtIndex:i];
                                
                                NSArray *TmpSet=[NSArray arrayWithObjects:URLString,ViwerImage.Image,nil];
                                [pQueueDownLoad addObject:TmpSet];
                            };
                        }
                        break;
                    }
                }
            }
            else
            {
                ManyFlowersCell *cell=(ManyFlowersCell *)CellRez;
                
                if (cell == nil)
                {
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ManyFlowersCell" owner:nil options:nil];
                    
                    for(id currentObject in topLevelObjects)
                    {
                        if([currentObject isKindOfClass:[ManyFlowersCell class]])
                        {
                            cell = (ManyFlowersCell *)currentObject;
                            [vArrCatalog setObject:cell forKey:KeyRow];
                            CellRez=cell;
                            
                            if(cell.Big)
                            {
                                cell.bCloseDetails.alpha=1;
                            }
                            else
                            {
                                cell.bCloseDetails.alpha=0;
                            }
                            
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            
                        FlowersDataCell *pDataCell=[pDataFlowers->pDataCellsCatalog objectAtIndex:indexPath.row];
                            
                            cell.lName.text=pDataCell->Name;
                            cell.lPrice.text=[pDataCell->Price stringByAppendingString:@" Р"];
                            cell.lPrice2.text=[pDataCell->Price stringByAppendingString:@" Р"];
                            
                            cell.lSend.text=[NSString stringWithFormat:@"Доставка: %@",pDataCell->delivery];
                            
                            cell.ldelivery.text=pDataCell->delivery;
                            cell.lArticle.text=pDataCell->Article;
                            cell.lFlowers.text=pDataCell->flowers;
                            cell.lDxH.text=pDataCell->DxH;
                            cell.lpackage.text=pDataCell->package;
                            cell.lInMCAD.text=[NSString stringWithFormat:@"В пределах МКАД-%@",pDataCell->InMCAD];
                        cell.lOUTMCAD.text=[NSString stringWithFormat:@"За пределы МКАД-%@",pDataCell->OUTMCAD];
                            
                            cell.bBuy.tag = indexPath.row;
                            [cell.bBuy addTarget:self action:@selector(ButtonBuy:) forControlEvents:UIControlEventTouchUpInside];
                            
                            [cell.bBuy2 addTarget:self action:@selector(ButtonBuy:)
                                 forControlEvents:UIControlEventTouchUpInside];
                            
                            cell.scrollView.tag=indexPath.row;
                            
                            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
                            [cell.scrollView addGestureRecognizer:singleTap];
                            cell.scrollView.tag=indexPath.row;
                            
                            cell.bCloseDetails.tag = indexPath.row;
                            [cell.bCloseDetails addTarget:self action:@selector(ButtonCloseDetails:) forControlEvents:UIControlEventTouchUpInside];
                            
                            cell.bFavorits.tag = indexPath.row;
                            [cell.bFavorits addTarget:self action:@selector(PutToFavorits:) forControlEvents:UIControlEventTouchUpInside];
                            
                            
                            NSArray *valueffsDicPic = pDataCell->DicPictMain;
                            [cell InitAllPages:(unsigned)[valueffsDicPic count]];
                            
                            for (int i=0;i<[valueffsDicPic count];i++)
                            {
                                [cell loadScrollViewWithPage:i];
                            }
                            
                            for (int i=0;i<[valueffsDicPic count];i++)
                            {
                                NSDictionary *valuesDicPic = [valueffsDicPic objectAtIndex:i];
                                NSArray *values = [valuesDicPic  allValues];
                                
                                NSMutableString *URLString = [NSMutableString
                                                              stringWithFormat:@"http://web-air.ru:8082%@",[values objectAtIndex:0]];
                                
                                ViewControllerListFlower *ViwerImage=
                                [cell.viewControllers objectAtIndex:i];
                                
                                NSArray *TmpSet=[NSArray arrayWithObjects:URLString,ViwerImage.Image,nil];
                                [pQueueDownLoad addObject:TmpSet];
                            }
                            break;
                        }
                    }
                }
            }
            
            [self setNeedsDisplay];
            return CellRez;
        }
        break;

        case I_PAGE_CREATE:
            break;

        case I_PAGE_SALES:
        {
            UITableViewCell *CellRez=0;
            NSString *KeyRow = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            CellRez=[vArrSales objectForKey:KeyRow];
            
            if(IPAD)
            {
                ManyFlowersCellIpad *cell=(ManyFlowersCellIpad *)CellRez;
                
                if (cell == nil)
                {
                    NSArray *topLevelObjects = [[NSBundle mainBundle]
                                                loadNibNamed:@"ManyFlowersCellIpad" owner:nil options:nil];
                    
                    for(id currentObject in topLevelObjects)
                    {
                        if([currentObject isKindOfClass:[ManyFlowersCellIpad class]])
                        {
                            cell = (ManyFlowersCellIpad *)currentObject;
                            [vArrSales setObject:cell forKey:KeyRow];
                            CellRez=cell;
                            
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            
                            cell.bBuy.tag = indexPath.row;
                            [cell.bBuy addTarget:self action:@selector(ButtonBuy:)
                                forControlEvents:UIControlEventTouchUpInside];
                            
                            FlowersDataCell *pDataCell=[pDataFlowers->pDataCellsSales
                                                        objectAtIndex:indexPath.row];
                            
                            cell.lName.text=pDataCell->Name;
                            cell.lPrice.text=[pDataCell->Price stringByAppendingString:@" Р"];
                            
                            cell.ldelivery.text=pDataCell->delivery;
                            cell.lArticle.text=pDataCell->Article;
                            cell.lFlowers.text=pDataCell->flowers;
                            cell.lDxH.text=pDataCell->DxH;
                            cell.lpackage.text=pDataCell->package;
                            cell.lInMCAD.text=pDataCell->InMCAD;
                            cell.lOUTMCAD.text=pDataCell->OUTMCAD;
                            
                            cell.bFavorits.tag = indexPath.row;
                            [cell.bFavorits addTarget:self action:@selector(PutToFavorits:) forControlEvents:UIControlEventTouchUpInside];
                            
                            NSArray *valueffsDicPic = pDataCell->DicPictMain;
                            [cell InitAllPages:(unsigned)[valueffsDicPic count]];
                            
                            for (int i=0;i<[valueffsDicPic count];i++)
                            {
                                [cell loadScrollViewWithPage:i];
                            }
                            
                            for (int i=0;i<[valueffsDicPic count];i++)
                            {
                                NSDictionary *valuesDicPic = [valueffsDicPic objectAtIndex:i];
                                NSArray *values = [valuesDicPic  allValues];
                                
                                NSMutableString *URLString = [NSMutableString
                                                              stringWithFormat:@"http://web-air.ru:8082%@",[values objectAtIndex:0]];
                                
                                ViewControllerListFlower *ViwerImage=
                                [cell.viewControllers objectAtIndex:i];
                                
                                NSArray *TmpSet=[NSArray arrayWithObjects:URLString,ViwerImage.Image,nil];
                                [pQueueDownLoad addObject:TmpSet];
                            };
                        }
                        break;
                    }
                }
            }
            else
            {
                ManyFlowersCell *cell=(ManyFlowersCell *)CellRez;
                
                if (cell == nil)
                {
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ManyFlowersCell" owner:nil options:nil];
                    
                    for(id currentObject in topLevelObjects)
                    {
                        if([currentObject isKindOfClass:[ManyFlowersCell class]])
                        {
                            cell = (ManyFlowersCell *)currentObject;
                            [vArrSales setObject:cell forKey:KeyRow];
                            CellRez=cell;
                            
                            if(cell.Big)
                            {
                                cell.bCloseDetails.alpha=1;
                            }
                            else
                            {
                                cell.bCloseDetails.alpha=0;
                            }
                            
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            
                            FlowersDataCell *pDataCell=[pDataFlowers->pDataCellsSales objectAtIndex:indexPath.row];
                            
                            cell.lName.text=pDataCell->Name;
                            cell.lPrice.text=[pDataCell->Price stringByAppendingString:@" Р"];
                            cell.lPrice2.text=[pDataCell->Price stringByAppendingString:@" Р"];
                            
                            cell.lSend.text=pDataCell->delivery;
                            
                            cell.ldelivery.text=pDataCell->delivery;
                            cell.lArticle.text=pDataCell->Article;
                            cell.lFlowers.text=pDataCell->flowers;
                            cell.lDxH.text=pDataCell->DxH;
                            cell.lpackage.text=pDataCell->package;
                            cell.lInMCAD.text=pDataCell->InMCAD;
                            cell.lOUTMCAD.text=pDataCell->OUTMCAD;
                            
                            cell.bBuy.tag = indexPath.row;
                            [cell.bBuy addTarget:self action:@selector(ButtonBuy:) forControlEvents:UIControlEventTouchUpInside];
                            
                            [cell.bBuy2 addTarget:self action:@selector(ButtonBuy:)
                                 forControlEvents:UIControlEventTouchUpInside];
                            
                            cell.scrollView.tag=indexPath.row;
                            
                            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
                            [cell.scrollView addGestureRecognizer:singleTap];
                            cell.scrollView.tag=indexPath.row;
                            
                            cell.bCloseDetails.tag = indexPath.row;
                            [cell.bCloseDetails addTarget:self action:@selector(ButtonCloseDetails:) forControlEvents:UIControlEventTouchUpInside];
                            
                            cell.bFavorits.tag = indexPath.row;
                            [cell.bFavorits addTarget:self action:@selector(PutToFavorits:) forControlEvents:UIControlEventTouchUpInside];
                            
                            
                            NSArray *valueffsDicPic = pDataCell->DicPictMain;
                            [cell InitAllPages:(unsigned)[valueffsDicPic count]];
                            
                            for (int i=0;i<[valueffsDicPic count];i++)
                            {
                                [cell loadScrollViewWithPage:i];
                            }
                            
                            for (int i=0;i<[valueffsDicPic count];i++)
                            {
                                NSDictionary *valuesDicPic = [valueffsDicPic objectAtIndex:i];
                                NSArray *values = [valuesDicPic  allValues];
                                
                                NSMutableString *URLString = [NSMutableString
                                                              stringWithFormat:@"http://web-air.ru:8082%@",[values objectAtIndex:0]];
                                
                                ViewControllerListFlower *ViwerImage=
                                [cell.viewControllers objectAtIndex:i];
                                
                                NSArray *TmpSet=[NSArray arrayWithObjects:URLString,ViwerImage.Image,nil];
                                [pQueueDownLoad addObject:TmpSet];
                            }
                            break;
                        }
                    }
                }
            }
            [self setNeedsDisplay];
            return CellRez;
        }
        break;

        case I_PAGE_FAVORITS:
        {
            if(indexPath.row==[self->pDataFlowers->pDataCellsFavorits count])
            {
                static NSString *CellIdentifier = @"ManyFlowersCellFavorits2_Identifier";
                ManyFlowersCellFavorits2 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                if (cell == nil){
                    
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ManyFlowersCellFavorits2" owner:nil options:nil];
                    
                    for(id currentObject in topLevelObjects)
                    {
                        if([currentObject isKindOfClass:[ManyFlowersCellFavorits2 class]])
                        {
                            cell = (ManyFlowersCellFavorits2 *)currentObject;
                            break;
                        }
                    }
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.bClear addTarget:self action:@selector(ClearAllFavorits:) forControlEvents:UIControlEventTouchUpInside];
                
                [self setNeedsDisplay];
                return cell;
            }
            else
            {
                static NSString *CellIdentifier = @"ManyFlowersCellFavorits1_Identifier";
                ManyFlowersCellFavorits1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                if (cell == nil){
                    
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ManyFlowersCellFavorits1" owner:nil options:nil];
                    
                    for(id currentObject in topLevelObjects)
                    {
                        if([currentObject isKindOfClass:[ManyFlowersCellFavorits1 class]])
                        {
                            cell = (ManyFlowersCellFavorits1 *)currentObject;

                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            
                        FlowersDataCell *pDataCell=[pDataFlowers->pDataCellsFavorits objectAtIndex:indexPath.row];
                            
                            cell.lName.text=[NSString stringWithFormat:@"Букет %@",pDataCell->Name];

                            cell.lPrice.text=pDataCell->Price;
                            cell.lPrice.text=[pDataCell->Price stringByAppendingString:@" Р"];

                            cell.lArticle.text=[NSString stringWithFormat:@"Артикул: %@",pDataCell->Article];
                            
                            cell.bClose.tag = indexPath.row;
                            [cell.bClose addTarget:self action:@selector(ButtonCloseFavorit:) forControlEvents:UIControlEventTouchUpInside];
                            
                            cell.bBuy.tag = indexPath.row;
                            [cell.bBuy addTarget:self action:@selector(ButtonBuy:)
                                forControlEvents:UIControlEventTouchUpInside];

                            NSMutableString *URLString = [NSMutableString
                                                          stringWithFormat:@"http://web-air.ru:8082%@",pDataCell->strPictFaforit];
                            
                            NSArray *TmpSet=[NSArray arrayWithObjects:URLString,cell.vPict,nil];
                            [pQueueDownLoad addObject:TmpSet];

                            break;
                        }
                    }
                }
                
                [self setNeedsDisplay];
                return cell;
            }

        }
        break;
        
        default:
        break;
    }
    
    return nil;
}


-(void) singleTapGestureCaptured:(UITapGestureRecognizer *)gestureRecognizer{
    
    //Get the View
    UIScrollView *tableGridImage = (UIScrollView*)gestureRecognizer.view;
    int selectedRow = (int)tableGridImage.tag;

    switch(iCurSel)
    {
        case I_PAGE_CATALOG:
        {
            NSString *KeyRow = [NSString stringWithFormat:@"%d",selectedRow];
            UITableViewCell *cell=[vArrCatalog objectForKey:KeyRow];
            ManyFlowersCell *pDataCell=(ManyFlowersCell *)cell;

            if(pDataCell.Big==NO)
            {
                CGPoint rootViewPoint = [[pDataCell superview]
                                         convertPoint:pDataCell.center toView:vCatalog];
                int TmpY=pDataCell.frame.size.height/2;
                int Delta=rootViewPoint.y-TmpY;
                
                [UIView animateWithDuration:0.5 animations:^{
                    vCatalogTable.contentOffset =
                            CGPointMake(0, vCatalogTable.contentOffset.y+Delta);
                }];
                
                [UIView animateWithDuration:0.5 animations:^{pDataCell.bCloseDetails.alpha = 1.0;}];
                
                [UIView animateWithDuration:0.5 animations:^{
                     pDataCell.lPrice.alpha = 0.0;}];
                
                
                [UIView animateWithDuration:0.5 animations:^{
                    pDataCell.lSend.alpha = 0.0;}];
             
                
                [UIView animateWithDuration:0.5 animations:^{
                    pDataCell.bBuy.alpha = 0.0;
                }];
                
                
                [UIView animateWithDuration:0.5 animations:^{pDataCell.vViewDetails.alpha = 1.0;}];
                
                [UIView animateWithDuration:0.5 animations:^{
                    pDataCell.vFon.frame = CGRectMake(0,0,272, 400);
                }];

                [UIView animateWithDuration:0.5 animations:^{
                    pDataCell.vBottomFrame.center=CGPointMake(pDataCell.vBottomFrame.center.x,403);
                }];
                
                [UIView animateWithDuration:0.5 animations:^{vCatalogFon.alpha = 0.15;}];
                
                pDataCell.Big=YES;
                [vCatalogTable beginUpdates];
                [vCatalogTable endUpdates];
            }
        }
            break;
            
        case I_PAGE_SALES:
        {
            NSString *KeyRow = [NSString stringWithFormat:@"%d",selectedRow];
            UITableViewCell *cell=[vArrSales objectForKey:KeyRow];
            
            ManyFlowersCell *pDataCell=(ManyFlowersCell *)cell;
            [UIView animateWithDuration:0.5 animations:^{pDataCell.bCloseDetails.alpha = 1.0;}];
            
            [UIView animateWithDuration:0.5 animations:^{pDataCell.lPrice.alpha = 0.0;}];
            [UIView animateWithDuration:0.5 animations:^{pDataCell.lSend.alpha = 0.0;}];
            [UIView animateWithDuration:0.5 animations:^{pDataCell.bBuy.alpha = 0.0;}];
            
            [UIView animateWithDuration:0.5 animations:^{pDataCell.vViewDetails.alpha = 1.0;}];
            
            [UIView animateWithDuration:0.5 animations:^{
                pDataCell.vFon.frame = CGRectMake(0,0,272, 400);
            }];

            [UIView animateWithDuration:0.5 animations:^{
                pDataCell.vBottomFrame.center=CGPointMake(pDataCell.vBottomFrame.center.x,403);
            }];
            
            [UIView animateWithDuration:0.5 animations:^{vSalesFon.alpha = 0.15;}];

            pDataCell.Big=YES;
            [vSalesTable beginUpdates];
            [vSalesTable endUpdates];
            
        }
            break;
    }
}
-(void)ChangeIconBuy
{
    UIImage *faceImage = nil;

    if([pDataFlowers->pDataCellsShops count]==0)
    {
        faceImage = [UIImage imageNamed:@"Buy.png"];
    }
    else
    {
        faceImage = [UIImage imageNamed:@"Icon-cart-green.png"];
    }
    
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    [face addTarget:self action:@selector(ShopithCart:) forControlEvents:UIControlEventTouchDown];
    face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
    [face setImage:faceImage forState:UIControlStateNormal];
    
    ShopithCart = [[UIBarButtonItem alloc] initWithCustomView:face];
    self.navigationItem.rightBarButtonItem = ShopithCart;

}

-(void)ButtonCloseShop:(UIButton*)button
{
    int row = (int)button.tag;
    
    FlowersDataCell *TmpCell=[pDataFlowers->pDataCellsShops objectAtIndex:row];
    TmpCell->NumPiece=1;
    
    [pDataFlowers->pDataCellsShops removeObjectAtIndex:row];
    
    [self ChangeIconBuy];
    [self UpdatePrieceInfo];
    
    [vShopTable reloadData];
}

-(void)ButtonCloseFavorit:(UIButton*)button
{
    int row = (int)button.tag;
    [pDataFlowers->pDataCellsFavorits removeObjectAtIndex:row];
    [vFavoritsTable reloadData];
}

-(void)BuyFinish:(UIButton*)button
{
    if(iCurSel!=I_PAGE_FINISH_BUY)
    {
        self.title = @"ОФОРМЛЕНИЕ ЗАКАЗА";
        iCurSel=I_PAGE_FINISH_BUY;
        
        [self ClearViews];
        vFinishShop.hidden=NO;
        vInsideFinishShop.hidden=NO;
        
        float HeightNavHeader=self.navigationController.navigationBar.frame.size.height;
        
        float CenterX=vMain.frame.size.width/2;
        float CenterY=(vMain.frame.size.height)/2;

        [vFinishShop setFrame:CGRectMake(0,30,vMain.bounds.size.width,vMain.bounds.size.height)];
        CGRect Tframe=CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height);
        vFinishShop.frame = Tframe;
        
        CGPoint TCenter;
        float DeltaSize=vMain.bounds.size.height-vInsideFinishShop.frame.size.height;
        if(DeltaSize<0)
        {
            TCenter=CGPointMake(CenterX, CenterY+DeltaSize+HeightNavHeader);
        }
        else
        {
            TCenter=CGPointMake(CenterX, CenterY);
        }
        vInsideFinishShop.center = CGPointMake(TCenter.x, vInsideFinishShop.center.y);

//        [bNext setTitle:@"ДАЛЕЕ" forState:UIControlStateNormal];
//        [bNext setTitle:@"ДАЛЕЕ" forState:UIControlStateHighlighted];
        
        iCurrentStep=0;
        [self UpdateInterfaceBuyFinish];
        [self setNeedsDisplay];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    bool Edit=YES;
    if(tableView==vCatalogTable)
    {
        Edit=NO;
    }

    if(tableView==vSalesTable)
    {
        Edit=NO;
    }

    if(tableView==vShopTable)
    {
        Edit=NO;
    }

    if(tableView==vFavoritsTable)
    {
        Edit=NO;
    }

    return Edit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tAdresTable==tableView)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            
            if(indexPath.row>0)
            {
                [SelectAdress removeObject:indexPath];

                [vArrAdressTable removeObjectAtIndex:indexPath.row-1];
                [vArrAdressTableTmp removeObjectAtIndex:indexPath.row];
            }
            else
            {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Сообщение"
                                                                     message:@"Основной адрес удалить нельзя."
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                [errorAlert show];
            }
            
            [tAdresTable reloadData];
        }
    }
}

- (IBAction)sGetDate:(id)sender
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0, screenRect.size.height, 350, 150);
    
    if(viewControllerData==nil)
        viewControllerData = [[UIViewController alloc]init];
    
    viewControllerData.view.frame=frame;
    
    blockView=[[UIView alloc] initWithFrame:self.view.frame];
    blockView.backgroundColor = [UIColor blackColor];
    blockView.alpha = 0.0;
    blockView.userInteractionEnabled=NO;
    [self.view addSubview:blockView];
    
    [UIView animateWithDuration:0.5 animations:^{
        blockView.alpha = .5;
    }];

    
    self.navigationItem.rightBarButtonItem.enabled=NO;
    self.navigationItem.leftBarButtonItem.enabled=NO;
//----------------------------------------------------------------------------------------
    viewControllerData.view.backgroundColor = [UIColor colorWithPatternImage:
                                 [UIImage imageNamed:@"bg-gragient-for-filter.png"]];
    
    UIDatePicker *datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(10, 40, 300, 100)];
    [datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.hidden = NO;
    datepicker.date = [NSDate date];
//    [datepicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    
    [datepicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    SEL selector = NSSelectorFromString( @"setHighlightsToday:" );
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature :
                                [UIDatePicker
                                 instanceMethodSignatureForSelector:selector]];
    BOOL no = NO;
    [invocation setSelector:selector];
    [invocation setArgument:&no atIndex:2];
    [invocation invokeWithTarget:datepicker];
    
    
    [viewControllerData.view addSubview:datepicker];
    
    UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(225, 10, 100, 20)];

    button.titleLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:18];
    [button setTitle: @"готово" forState: UIControlStateNormal];
    [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    
    [button addTarget:self action:@selector(Ready:) forControlEvents:UIControlEventTouchUpInside];

    [viewControllerData.view addSubview:button]; //add to the subview

    
    [self addChildViewController:viewControllerData];
    [self.view addSubview:viewControllerData.view];
    [viewControllerData didMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        [viewControllerData.view setFrame:CGRectMake(0,screenRect.size.height-frame.size.height, frame.size.width, frame.size.height)];
    }];
}

-(void) Ready: (id)sender
{
 //   viewControllerData.view.userActivity=1;

    self.navigationItem.rightBarButtonItem.enabled=YES;
    self.navigationItem.leftBarButtonItem.enabled=YES;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect frame = viewControllerData.view.frame;

    [UIView animateWithDuration:0.5 animations:^{
        [viewControllerData.view setFrame:CGRectMake(0,screenRect.size.height, frame.size.width, frame.size.height)];
        
        blockView.alpha = 0;
    }
    completion:^(BOOL completed)
    {
        [blockView removeFromSuperview];
    }];
    
}

-(void) dateChanged: (id)sender
{
    UIDatePicker *control = (UIDatePicker *) sender;
    control.datePickerMode=UIDatePickerModeDate;
    NSDate *eventDate = control.date;
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
    [timeFormat setDateFormat:@"dd MMMM yyyy"];
    NSString *dateString = [timeFormat stringFromDate:eventDate];
    fDateDeliv.text=dateString;
}

- (void)UpdateAdres
{
    [vArrAdressTableTmp removeAllObjects];
    if(bInMyDataSave==YES)
        [vArrAdressTableTmp insertObject:sAdress atIndex:0];
    
    [vArrAdressTableTmp addObjectsFromArray:vArrAdressTable];
}

- (IBAction)aAddAdress:(id)sender
{
    NSString *TmpAdress=@"";
    [vArrAdressTable addObject:TmpAdress];

    [self UpdateAdres];

    iCurrentActive=(int)([vArrAdressTableTmp count]-1);

    [tAdresTable setContentOffset:CGPointMake(0,
            ([vArrAdressTableTmp count]+1)*SIZE_ADRES_CELL-tAdresTable.frame.size.height) animated:YES];
    
    bNewAdressInTable=YES;
    
    [tAdresTable reloadData];
}

- (IBAction)aChangeAdressTable:(id)sender
{
    if(tAdresTable.editing==YES)
    {
        [tAdresTable setEditing: NO animated: YES];
        [bEditAdress setTitle:@"Изменить" forState:UIControlStateNormal];
        [bEditAdress setTitle:@"Изменить" forState:UIControlStateHighlighted];
        bNewAdress.enabled=YES;
    }
    else
    {
        [tAdresTable setEditing:YES animated:YES];
        [bEditAdress setTitle:@"Готово" forState:UIControlStateNormal];
        [bEditAdress setTitle:@"Готово" forState:UIControlStateHighlighted];
        bNewAdress.enabled=NO;
    }
}

- (IBAction)NextStep:(id)sender
{
    iCurrentStep++;
    [self UpdateInterfaceBuyFinish];
}


-(IBAction)valueChanged:(UISlider*)sender {
    int discreteValue = roundl([sender value]); // Rounds float to an integer
    [sender setValue:(float)discreteValue]; // Sets your slider to this value
    
//    NSString *NamePostart=[NSString stringWithFormat:@"postcard%d.png",(int)(discreteValue+1)];
//    [ivPostard setImage:[UIImage imageNamed:NamePostart]];

}

-(void)updateMyData
{
    lMyDataNameDown.text=sName;
    lMyDataPhoneDown.text=sPhone;
    lMyDataMailDown.text=sEmail;
    
    if([sAdress isEqualToString:@"Не заполнен"])
    {
        lMyDatadresDown.text=sAdress;
    }
    else
    {
        lMyDatadresDown.text=[NSString stringWithFormat:@"%@, %@",sCity,sAdress];
    }
}

-(IBAction)aCach:(UISlider*)sender
{
    [vImageCach setImage:[UIImage imageNamed:@"Check_on.png"]];
    [vImageNoCach setImage:[UIImage imageNamed:@"Check_off.png"]];
    bCach.enabled=NO;
    bNonCach.enabled=YES;
    
    [bCach setBackgroundImage:[UIImage imageNamed:@"bg-selest-green.png"] forState:UIControlStateNormal];
    [bCach setBackgroundImage:[UIImage imageNamed:@"bg-selest-green.png"]forState:UIControlStateHighlighted];
    [bNonCach setBackgroundImage:nil forState:UIControlStateNormal];
    [bNonCach setBackgroundImage:nil forState:UIControlStateHighlighted];

}

-(IBAction)aEditMyData:(UIButton *)sender
{
    self.title = @"РЕДАКТИРОВАНИЕ";
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int Border=25;

    [UIView animateWithDuration:0.5 animations:^{
        
        bEdit.alpha=0;
        lMyDataNameUp.alpha=0;
        lMyDataNameDown.alpha=0;
        lMyDataPhoneUp.alpha=0;
        lMyDataPhoneDown.alpha=0;
        lMyDataMailUp.alpha=0;
        lMyDataMailDown.alpha=0;
        lMyDataAdresUp.alpha=0;
        lMyDatadresDown.alpha=0;
        
        fMyDataName.alpha=1;
        fMyDataPhone.alpha=1;
        fMyDataEmail.alpha=1;
        fMyDataSity.alpha=1;
        fMyDataAdress.alpha=1;

        int offset=20;
        vMyparWhiteSQR.frame=CGRectMake(25,25,screenRect.size.width-Border*2,256+offset);
        vDownWhiteSQR.frame = CGRectMake(25,280+offset,screenRect.size.width-Border*2,9);
    }
    completion:^(BOOL completed)
    {
        [UIView animateWithDuration:0.5 animations:^{
            bSave.alpha=1;
            bCansel.alpha=1;
        }];
    }];
}

-(IBAction)aCanselEditMyData:(UIButton *)sender
{
    self.title = @"МОИ ДАННЫЕ";
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int Border=25;

    [UIView animateWithDuration:0.5 animations:^{
        
        bSave.alpha=0;
        bCansel.alpha=0;
        
        lMyDataNameUp.alpha=1;
        lMyDataNameDown.alpha=1;
        lMyDataPhoneUp.alpha=1;
        lMyDataPhoneDown.alpha=1;
        lMyDataMailUp.alpha=1;
        lMyDataMailDown.alpha=1;
        lMyDataAdresUp.alpha=1;
        lMyDatadresDown.alpha=1;

        fMyDataName.alpha=0;
        fMyDataPhone.alpha=0;
        fMyDataEmail.alpha=0;
        fMyDataSity.alpha=0;
        fMyDataAdress.alpha=0;
        
        vMyparWhiteSQR.frame=CGRectMake(25,25,screenRect.size.width-Border*2,256);
        vDownWhiteSQR.frame = CGRectMake(25,280,screenRect.size.width-Border*2,9);
    }
    completion:^(BOOL completed)
    {
        [UIView animateWithDuration:0.5 animations:^{
            bEdit.alpha=1;
        }];
    }];
}

-(IBAction)SendFeedBack:(id)btn
{
    NSString *urlString = @"http://web-air.ru:8082/delivery_mail/";

    NSString *parameter = [NSString stringWithFormat:
                           @"type=%@&email=%@&title=%@&name=%@&phone=%@&address=%@&message=%@",
                           @"client_support",@[E_MAIL],@"Feed Back",_fMyFeedBackName.text,
                           _fMyFeedPhone.text,_fMyFeedBackEmail.text
                           ,_fMyFeedMessage.text];

    [pClient PostSend:urlString Params:parameter
          competition:^(NSData *result,NSURLResponse *response,NSError *error) {
      
      if(result != nil && [result length]>0)
      {
//          NSJSONSerialization *ArrJsonSales = [NSJSONSerialization JSONObjectWithData:result
//                                                                              options:NSJSONReadingMutableContainers error:nil];
          NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"mailsent" ofType:@"mp3"];
          SystemSoundID soundID;
          AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
          AudioServicesPlaySystemSound (soundID);
      }
    }];

    
}
-(IBAction)SaveOptions:(id)btn
{
    sName=fMyDataName.text;
    sPhone=fMyDataPhone.text;
    sEmail=fMyDataEmail.text;
    sCity=fMyDataSity.text;
    sAdress=fMyDataAdress.text;

    [self updateMyData];
    //    [self Options:btn];
    
    [self aCanselEditMyData:nil];
    bInMyDataSave=YES;
    [self SaveData];
}


-(IBAction)aToDay:(UIDatePicker *)sender
{
    if(bFilterOpen==YES)
    {
        [vImageCachGrey setImage:[UIImage imageNamed:@"Check-grey-on.png"]];
        bFilterOpen=NO;
    }
    else
    {
        bFilterOpen=YES;
        [vImageCachGrey setImage:[UIImage imageNamed:@"Check_gray_off@2x.png"]];
    }
  //  [pDateDelivery setDate:[NSDate date]];
}


-(IBAction)aNonCach:(UISlider*)sender
{
    [vImageCach setImage:[UIImage imageNamed:@"Check_off.png"]];
    [vImageNoCach setImage:[UIImage imageNamed:@"Check_on.png"]];
    bCach.enabled=YES;
    bNonCach.enabled=NO;
    
    [bNonCach setBackgroundImage:[UIImage imageNamed:@"bg-selest-green.png"] forState:UIControlStateNormal];
    [bNonCach setBackgroundImage:[UIImage imageNamed:@"bg-selest-green.png"]forState:UIControlStateHighlighted];
    [bCach setBackgroundImage:nil forState:UIControlStateNormal];
    [bCach setBackgroundImage:nil forState:UIControlStateHighlighted];

}


- (void)UpdateInterfaceBuyFinish
{
    //очистить экран
    imageLine.hidden=YES;
    bShoppingCart.hidden=YES;
    bNext.hidden=YES;
    iStep.hidden=YES;
    bToDay.hidden=YES;
    lAdressDelivery.hidden=YES;
    tAdresTable.hidden=YES;
    bNewAdress.hidden=YES;
    bCalendar.hidden=YES;
    bEditAdress.hidden=YES;
    lDateDelivery.hidden=YES;
    pDateDelivery.hidden=YES;

    bCach.hidden=YES;
    bNonCach.hidden=YES;
    imageLineOn3step.hidden=YES;
    tMessage.hidden=YES;
    ivPostard.hidden=YES;
    
    lFourStepHeader.hidden=YES;
    lFourNameShop.hidden=YES;
    tMessageUp.hidden=YES;
    tMessageDown.hidden=YES;

    imageLine1.hidden=YES;
    
    tMessagePost.hidden=YES;
    imageLine2.hidden=YES;
    
    imageLine1Shop.hidden=YES;

    fDateDeliv.hidden=YES;
    fTimeDeliv.hidden=YES;
////////////////////////////////////////////////////////////////////////////////////////////////
    float CenterXInside=vInsideFinishShop.frame.size.width/2;
    
    imageLine.center=CGPointMake(CenterXInside,302);

    iStep.frame=CGRectMake(0,0,257,41);
    iStep.center=CGPointMake(CenterXInside,27);

    bToDay.frame=CGRectMake(0,0,257,30);
    bToDay.center=CGPointMake(CenterXInside,205);

    tAdresTable.frame=CGRectMake(0,0,260,SIZE_ADRES_CELL*2);
    tAdresTable.center=CGPointMake(CenterXInside,108);

    bNewAdress.frame=CGRectMake(0,0,134,24);
    bNewAdress.center=CGPointMake(CenterXInside-66,158);
    
    bEditAdress.frame=CGRectMake(0,0,120,33);
    bEditAdress.center=CGPointMake(CenterXInside+90,210);

    lFourStepHeader.frame=CGRectMake(36,0,300,33);
 //   lFourStepHeader.center=CGPointMake(CenterXInside,20);
    
    lFourNameShop.frame=CGRectMake(36,19,300,33);
  //  lFourNameShop.center=CGPointMake(CenterXInside,50);

    lDateDelivery.frame=CGRectMake(0,0,260,33);
    lDateDelivery.center=CGPointMake(CenterXInside,183);
    
    pDateDelivery.frame=CGRectMake(0,0,300,100);
    pDateDelivery.center=CGPointMake(CenterXInside,345);
    

    
    bCach.frame=CGRectMake(0,0,258,30);
    bCach.center=CGPointMake(CenterXInside,90);

    bNonCach.frame=CGRectMake(0,0,258,30);
    bNonCach.center=CGPointMake(CenterXInside,120);
    
    imageLine1.center=CGPointMake(CenterXInside,105);
    imageLine2.center=CGPointMake(CenterXInside,135);
    imageLine1Shop.center=CGPointMake(CenterXInside,220);


    tMessage.frame=CGRectMake(0,0,250,62);
    tMessage.center=CGPointMake(CenterXInside,106);

    tMessageUp.frame=CGRectMake(36,60,248,60);
 //   tMessageUp.center=CGPointMake(CenterXInside,100);

    tMessageDown.frame=CGRectMake(36,110,248,60);
//    tMessageDown.center=CGPointMake(CenterXInside,140);

    imageLineOn3step.frame=CGRectMake(0,0,248,11);
    imageLineOn3step.center=CGPointMake(CenterXInside,150);

    ivPostard.frame=CGRectMake(0,0,211,133);
    ivPostard.center=CGPointMake(CenterXInside,230);

    fDateDeliv.frame=CGRectMake(0,0,250,32);
    fDateDeliv.center=CGPointMake(CenterXInside,244);
    bCalendar.frame=CGRectMake(0,0,32,32);
    bCalendar.center=CGPointMake(CenterXInside+110,245);

    fTimeDeliv.frame=CGRectMake(0,0,250,32);
    fTimeDeliv.center=CGPointMake(CenterXInside,278);

    
    float fBorder=12;
    tMessagePost.frame=CGRectMake(ivPostard.frame.origin.x+fBorder,ivPostard.frame.origin.y+fBorder
                                  ,ivPostard.frame.size.width-fBorder,ivPostard.frame.size.height-fBorder);
    tMessagePost.center=ivPostard.center;

    bNext.frame=CGRectMake(215,311,75,24);
////////////////////////////////////////////////////////////////////////////////////////////////
    switch (iCurrentStep) {
        case 0://первый шаг
        {
            [bNext setImage:[UIImage imageNamed:@"continue1.png"] forState:UIControlStateNormal];
            [bNext setImage:[UIImage imageNamed:@"continue1.png"] forState:UIControlStateHighlighted];

            UIImage *pImage = [UIImage imageNamed:@"Step1.png"];
            [iStep setImage:pImage];

            imageLine.hidden=NO;
            bShoppingCart.hidden=NO;
            bNext.hidden=NO;
            iStep.hidden=NO;
            bToDay.hidden=NO;
            lAdressDelivery.hidden=NO;
            tAdresTable.hidden=NO;
            bNewAdress.hidden=NO;
            imageLine1Shop.hidden=NO;
    //        bEditAdress.hidden=NO;
            lDateDelivery.hidden=NO;
//            pDateDelivery.hidden=NO;
            fDateDeliv.hidden=NO;
            fTimeDeliv.hidden=NO;
            
            bCalendar.hidden=NO;
            bNewAdress.enabled=YES;
            
            lAdressDelivery.text=@"Адрес доставки:";
            lDateDelivery.text=@"Дата доставки:";
            
            lAdressDelivery.frame=CGRectMake(30,45,180,33);
            
            [vArrAdressTableTmp removeAllObjects];
            
            if(bInMyDataSave==YES)
                [vArrAdressTableTmp insertObject:sAdress atIndex:0];

            [vArrAdressTableTmp addObjectsFromArray:vArrAdressTable];

            [tAdresTable setEditing: NO animated: NO];
            [bEditAdress setTitle:@"Изменить" forState:UIControlStateNormal];
            [bEditAdress setTitle:@"Изменить" forState:UIControlStateHighlighted];

       //     [SelectAdress removeAllObjects];
            
            [tAdresTable reloadData];
        }
        break;
 
        case 1://второй шаг
        {
            UIImage *pImage = [UIImage imageNamed:@"Step2.png"];
            [iStep setImage:pImage];
            
            imageLine.hidden=NO;
            bShoppingCart.hidden=NO;
            bNext.hidden=NO;
            iStep.hidden=NO;
            bCach.hidden=NO;
            bNonCach.hidden=NO;
            lAdressDelivery.hidden=NO;
            imageLine1.hidden=NO;
            imageLine2.hidden=NO;

            
            lAdressDelivery.text=@"Оплата:";
            lAdressDelivery.frame=CGRectMake(30,45,180,33);
        }
        break;

        case 2://второй шаг
        {
            UIImage *pImage = [UIImage imageNamed:@"Step3.png"];
            [iStep setImage:pImage];
            
            imageLine.hidden=NO;
            bShoppingCart.hidden=NO;
            bNext.hidden=NO;
            iStep.hidden=NO;
            lAdressDelivery.hidden=NO;
            imageLineOn3step.hidden=NO;
            tMessage.hidden=NO;
            ivPostard.hidden=NO;
            tMessagePost.hidden=NO;
            
            [bNext setImage:[UIImage imageNamed:@"CONFIRM1.png"] forState:UIControlStateNormal];
            [bNext setImage:[UIImage imageNamed:@"CONFIRM1.png"] forState:UIControlStateHighlighted];
            bNext.frame=CGRectMake(160,311,130,24);
            
            tMessage.textColor = [UIColor blackColor];
            tMessage.text = @"Дополнительная информация";
            
            
            lAdressDelivery.text=@"Подтвердить";
            lAdressDelivery.frame=CGRectMake(34,45,180,33);
        }
        break;
            
        case 3://третий шаг
        {
            UIImage *pImage = [UIImage imageNamed:@"Step3.png"];
            [iStep setImage:pImage];
//            [bNext setTitle:@"ПОДТВЕРДИТЬ" forState:UIControlStateNormal];
//            [bNext setTitle:@"ПОДТВЕРДИТЬ" forState:UIControlStateHighlighted];
            
            [bNext setImage:[UIImage imageNamed:@"CONFIRM1.png"] forState:UIControlStateNormal];
            [bNext setImage:[UIImage imageNamed:@"CONFIRM1.png"] forState:UIControlStateHighlighted];
            bNext.frame=CGRectMake(160,311,130,24);

            bShoppingCart.hidden=NO;
            bNext.hidden=NO;
            iStep.hidden=NO;
            lAdressDelivery.hidden=NO;
            imageLineOn3step.hidden=NO;
            tMessage.hidden=NO;
            ivPostard.hidden=NO;
            imageLine.hidden=NO;
            tMessagePost.hidden=NO;
            
//отсылаем письмо заказа====================================
            NSString *TmpAdres=@"не задано";
            
            if([vArrAdressTableTmp count]>0)
                TmpAdres=[vArrAdressTableTmp objectAtIndex:0];

            NSString *urlString = @"http://web-air.ru:8082/delivery_mail/";
            
            NSString *StringSoon=@"Soon";
            if(![bToDay isEnabled])StringSoon=@"no";

            NSString *StringPay=@"Наличные";

            NSString *parameter = [NSString stringWithFormat:
            @"type=%@&address=%@&email=%@&title=%@&delivery_address=%@&products=%@&soon=%@\
            &delivery_date=%@&delivery_time=%@&payment=%@&message=%@&message_for_card=%@",

            @"order",@"адрес",@[E_MAIL],@"Order",TmpAdres,
                @"{\"1\": 2, \"2\": 3}",StringSoon,fDateDeliv.text,
                        fTimeDeliv.text,StringPay,tMessage.text,tMessagePost.text];
            
            [pClient PostSend:urlString Params:parameter
                  competition:^(NSData *result,NSURLResponse *response,NSError *error) {
                      
                      if(result != nil && [result length]>0)
                      {
//                        NSJSONSerialization *ArrJsonSales = [NSJSONSerialization JSONObjectWithData:result
//                                                    options:NSJSONReadingMutableContainers error:nil];
                          
                          NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"mailsent" ofType:@"mp3"];
                          SystemSoundID soundID;
                          AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
                          AudioServicesPlaySystemSound (soundID);
                      }
                  }];
//=======================================================================
            
            
//            if ([MFMailComposeViewController canSendMail])
//            {
//                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
//                mail.mailComposeDelegate = self;
//                [mail setSubject:@"Сообщение"];
//                
//                NSString *GeneralStr=[NSString
//                                      stringWithFormat:@"Сообщение:%@\n",tMessage.text];
//                
//                GeneralStr=[GeneralStr stringByAppendingString:@"адрес:"];
//                
//                for (int i=0; i<[SelectAdress count]; i++)
//                {
//                    NSIndexPath * Num=(NSIndexPath *)[SelectAdress objectAtIndex:i];
//                    NSString *TmpStr=[vArrAdressTableTmp objectAtIndex:Num.row];
//                    
//                    GeneralStr=[GeneralStr stringByAppendingString:TmpStr];
//                    GeneralStr=[GeneralStr stringByAppendingString:@"\n"];
//                }
//                
//       //         int discreteValue = roundl([sPostCard value]);
////                NSString *NamePostart=[NSString stringWithFormat:@"postcard%d.png",(int)(discreteValue+1)];
////                NSData *ImageData = UIImagePNGRepresentation([UIImage imageNamed:NamePostart]);
////                [mail addAttachmentData:ImageData mimeType:@"image/png" fileName:NamePostart];
//                
//                [mail setMessageBody:GeneralStr isHTML:NO];
//                
//                [mail setToRecipients:@[E_MAIL]];
//
//                [self presentViewController:mail animated:YES completion:NULL];
//            }
//            else
//            {
//                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Сообщение"
//                                                                     message:@"К сожалению сейчас невозможно послать письмо. Попробуйте изменить насройки почты  или интернета."
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"OK"
//                                                           otherButtonTitles:nil];
//                [errorAlert show];
//            }
            
            bShoppingCart.hidden=NO;
            bNext.hidden=NO;
            iStep.hidden=NO;
            
            iCurrentStep=4;
            [self UpdateInterfaceBuyFinish];

        }
        break;
            
        case 4://четвёртый шаг
        {
            lFourStepHeader.hidden=NO;
            lFourNameShop.hidden=NO;

            lFourStepHeader.text=@"Заказ отправлен в магазин";
            lFourNameShop.text=@"'Название магазина'";

            
            tMessageUp.hidden=NO;

            tMessageUp.backgroundColor = TileColor;
            tMessageUp.textColor = [UIColor blackColor];
            tMessageUp.text = @"В ближайшее время менеджер свяжется с вами.";

            tMessageDown.hidden=NO;
            
            tMessageDown.backgroundColor = TileColor;
            tMessageDown.textColor = [UIColor blackColor];
            tMessageDown.text = @"Позвонить нам (с 10.00 до 21.00) 8-800-000-00-00";

            
            self.title = @"ЗАКАЗ ОТПРАВЛЕН";
            [pDataFlowers->pDataCellsShops removeAllObjects];
            [self ChangeIconBuy];
        }
        break;
            
        default:
            break;
    }
}


-(void)ClearAllFavorits:(UIButton*)button
{
    if([pDataFlowers->pDataCellsFavorits count]>0)
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Подтверждение"
                                                             message:@"Вы действительно хотите очистить избранное?"
                                                            delegate:self
                                                   cancelButtonTitle:@"Да"
                                                   otherButtonTitles:@"Нет",nil];
        
        [errorAlert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)//да
    {
        [pDataFlowers->pDataCellsFavorits removeAllObjects];
        [vFavoritsTable reloadData];
    }
    if (buttonIndex == 1)
    {
    }
}

-(void)PutToFavorits:(UIButton*)button
{
    FlowersDataCell *pCell=nil;
    
    switch(iCurSel)
    {
        case I_PAGE_CATALOG:
        {
            pCell=[pDataFlowers->pDataCellsCatalog objectAtIndex:button.tag];
        }
        break;
            
        case I_PAGE_SALES:
        {
            pCell=[pDataFlowers->pDataCellsSales objectAtIndex:button.tag];
        }
        break;
    }
    
    BOOL isFind=NO;
    for (FlowersDataCell *tCell in pDataFlowers->pDataCellsFavorits)
    {
        if(tCell==pCell)
        {
            isFind=YES;
            break;
        }
    }
    
    if(isFind==NO)
    {
        [pDataFlowers->pDataCellsFavorits addObject:pCell];
        [self setNeedsDisplay];
    }

//анимационный спрайт////////////////////////////////////////////////
    UIImageView *TmpImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-create-hover@180.png"]];
    
    CGPoint rootViewPoint = [[button superview] convertPoint:button.center toView:vMain];
    
    TmpImage.frame=CGRectMake(rootViewPoint.x,rootViewPoint.y, 150, 150);
    TmpImage.center=CGPointMake(rootViewPoint.x, rootViewPoint.y);
    [vMain addSubview:TmpImage];
    
    [UIView animateWithDuration:1.0 animations:^{
         TmpImage.frame = CGRectMake(vMain.center.x+100,vMain.frame.size.height, 10, 10);
     }
     completion:^(BOOL completed)
     {
         [TmpImage removeFromSuperview];
     }];
///////////////////////////////////////////////
}

-(void)ButtonBuy:(UIButton*)button
{
    int row = (int)button.tag;
    id ob=nil;
    
    switch(iCurSel)
    {
        case I_PAGE_CATALOG:
        {
            ob=[pDataFlowers->pDataCellsCatalog objectAtIndex:row];
        }
        break;
            
        case I_PAGE_SALES:
        {
            ob=[pDataFlowers->pDataCellsSales objectAtIndex:row];
        }
        break;

        case I_PAGE_FAVORITS:
        {
            ob=[pDataFlowers->pDataCellsFavorits objectAtIndex:row];
        }
        break;

        default:
            break;
    }
    
    bool bFind=NO;
    for(id pTmp in pDataFlowers->pDataCellsShops)
    {
        if (pTmp==ob) {
            bFind=YES;
            break;
        }
    }
    
    if(bFind==NO)
        [pDataFlowers->pDataCellsShops addObject:ob];
//анимационный спрайт////////////////////////////////////////////////
    UIImageView *TmpImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-create-hover@180.png"]];
    
    CGPoint rootViewPoint = [[button superview] convertPoint:button.center toView:vMain];

    TmpImage.frame=CGRectMake(rootViewPoint.x,
                              rootViewPoint.y, 150, 150);
    TmpImage.center=CGPointMake(rootViewPoint.x-100, rootViewPoint.y-50);
    [vMain addSubview:TmpImage];

    [UIView animateWithDuration:1.0 animations:^
     {
         TmpImage.frame = CGRectMake(vMain.frame.size.width-40,0, 10, 10);
     }
     completion:^(BOOL completed)
     {
         [TmpImage removeFromSuperview];
         
         if([pDataFlowers->pDataCellsShops count]>0)
         {
             UIImage *faceImage = [UIImage imageNamed:@"Icon-cart-green.png"];
             UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
             [face addTarget:self action:@selector(ShopithCart:) forControlEvents:UIControlEventTouchDown];
             face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
             [face setImage:faceImage forState:UIControlStateNormal];
             
             ShopithCart = [[UIBarButtonItem alloc] initWithCustomView:face];
             self.navigationItem.rightBarButtonItem = ShopithCart;
         }
     }];
///////////////////////////////////////////////
    
    [self setNeedsDisplay];
}

-(void) ButtonCloseDetails:(UIButton*)button
{
    int selectedRow = (int)button.tag;
    
    switch(iCurSel)
    {
        case I_PAGE_CATALOG:
        {
            NSString *KeyRow = [NSString stringWithFormat:@"%d",selectedRow];
            UITableViewCell *cell=[vArrCatalog objectForKey:KeyRow];

            ManyFlowersCell *pDataCell=(ManyFlowersCell *)cell;
            
            [UIView animateWithDuration:0.5 animations:^{pDataCell.bCloseDetails.alpha = 0.0;}];
            
            [UIView animateWithDuration:0.5 animations:^{pDataCell.lPrice.alpha = 1.0;}];
            [UIView animateWithDuration:0.5 animations:^{pDataCell.lSend.alpha = 1.0;}];
            [UIView animateWithDuration:0.5 animations:^{pDataCell.bBuy.alpha = 1.0;}];
            [UIView animateWithDuration:0.5 animations:^{pDataCell.vViewDetails.alpha = 0.0;}];
            
            [UIView animateWithDuration:0.5 animations:^{
                pDataCell.vFon.frame = CGRectMake(0,0,272, 214);
            }];

            [UIView animateWithDuration:0.5 animations:^{
                pDataCell.vBottomFrame.center=CGPointMake(pDataCell.vBottomFrame.center.x,
                                                          217);
            }];

            [UIView animateWithDuration:0.5 animations:^{vCatalogFon.alpha = 1;}];

            pDataCell.Big=NO;
            [vCatalogTable beginUpdates];
            [vCatalogTable endUpdates];
        }
        break;
            
        case I_PAGE_SALES:
        {
            NSString *KeyRow = [NSString stringWithFormat:@"%d",selectedRow];
            UITableViewCell *cell=[vArrSales objectForKey:KeyRow];
            
            ManyFlowersCell *pDataCell=(ManyFlowersCell *)cell;
            
            [UIView animateWithDuration:0.5 animations:^{pDataCell.bCloseDetails.alpha = 0.0;}];
            
            [UIView animateWithDuration:0.5 animations:^{pDataCell.lPrice.alpha = 1.0;}];
            [UIView animateWithDuration:0.5 animations:^{pDataCell.lSend.alpha = 1.0;}];
            [UIView animateWithDuration:0.5 animations:^{pDataCell.bBuy.alpha = 1.0;}];
            [UIView animateWithDuration:0.5 animations:^{pDataCell.vViewDetails.alpha = 0.0;}];
            
            [UIView animateWithDuration:0.5 animations:^{
                pDataCell.vFon.frame = CGRectMake(0,0,272, 214);
            }];

            [UIView animateWithDuration:0.5 animations:^{
                pDataCell.vBottomFrame.center=CGPointMake(pDataCell.vBottomFrame.center.x,
                                                          217);
            }];

            [UIView animateWithDuration:0.5 animations:^{vSalesFon.alpha = 1;}];

            pDataCell.Big=NO;
            [vSalesTable beginUpdates];
            [vSalesTable endUpdates];

        }
        break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClearViews
{
    vCatalog.hidden=YES;
    vCreate.hidden=YES;
    vSales.hidden=YES;
    vFavorits.hidden=YES;
    vDel_Pay.hidden=YES;
    vShoping.hidden=YES;
    vOptions.hidden=YES;
    vFAQ.hidden=YES;
    vClients.hidden=YES;
    vAbout.hidden=YES;
    vMypar.hidden=YES;
    vFinishShop.hidden=YES;
    vInsideFinishShop.hidden=YES;
    _vFeedBack.hidden=YES;
    _vAboutText.hidden=YES;
    
    UIImage *btnImage = [UIImage imageNamed:@"Icon-catalog.png"];
    [bCatalog setImage:btnImage forState:UIControlStateNormal];
    btnImage = [UIImage imageNamed:@"Icon-create.png"];
    [bCreate setImage:btnImage forState:UIControlStateNormal];
    btnImage = [UIImage imageNamed:@"Icon-sale.png"];
    [bSales setImage:btnImage forState:UIControlStateNormal];
    btnImage = [UIImage imageNamed:@"Icon-favorit.png"];
    [bFavorits setImage:btnImage forState:UIControlStateNormal];

}

- (IBAction)Catalog:(id)sender
{
    if(iCurSel!=I_PAGE_CATALOG)
    {
        iCurSel=I_PAGE_CATALOG;
        
        [self ClearViews];
        UIImage *btnImage = [UIImage imageNamed:@"Icon-catalog-hover.png"];
        [bCatalog setImage:btnImage forState:UIControlStateNormal];
        
        self.title = @"ГОТОВЫЕ БУКЕТЫ";
        
        vCatalog.hidden=NO;
//        [vMain addSubview:vCatalog];
        [vCatalogTable reloadData];
        
//        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.0f];
    }
}
- (IBAction)Create:(id)sender
{
    if(iCurSel!=I_PAGE_CREATE)
    {
        iCurSel=I_PAGE_CREATE;
        
        [self ClearViews];
        
        UIImage *btnImage = [UIImage imageNamed:@"Icon-create-hover.png"];
        [bCreate setImage:btnImage forState:UIControlStateNormal];
        
        self.title = @"СОЗДАТЬ БУКЕТ";
        
        vCreate.hidden=NO;
//        [vMain addSubview:vCreate];
        [self setNeedsDisplay];
    }
}
- (IBAction)Sales:(id)sender
{
    if(iCurSel!=I_PAGE_SALES)
    {
        iCurSel=I_PAGE_SALES;

        [self ClearViews];
        
        UIImage *btnImage = [UIImage imageNamed:@"Icon-sale-hover.png"];
        [bSales setImage:btnImage forState:UIControlStateNormal];
        
        self.title = @"АКЦИИ";
        [vSalesTable reloadData];
        
        vSales.hidden=NO;
    //    [vMain addSubview:vSales];
        [self setNeedsDisplay];
    }
}
- (IBAction)Favorit:(id)sender
{
    if(iCurSel!=I_PAGE_FAVORITS)
    {
        iCurSel=I_PAGE_FAVORITS;
        
        [self ClearViews];
        
        UIImage *btnImage = [UIImage imageNamed:@"Icon-favorit-hover.png"];
        [bFavorits setImage:btnImage forState:UIControlStateNormal];
        
        self.title = @"ИЗБРАННОЕ";
        [vFavoritsTable reloadData];
        vFavorits.hidden=NO;
   //     [vMain addSubview:vFavorits];
        [self setNeedsDisplay];
    }
}

-(IBAction)Options:(id)btn
{
    [pParent movePanelRight];
//    return;
//    
//    if(iCurSel!=I_PAGE_OPTIONS)
//    {
//        self.title = @"НАСТРОЙКИ";
//        iCurSel=I_PAGE_OPTIONS;
//
//        [self ClearViews];
//        vOptions.hidden=NO;
//    //    [vMain addSubview:vOptions];
//        [bSwitchInMoscow setOn:bInMoscow];
//        
//        [self setNeedsDisplay];
//    }
}

-(void)UpdatePrieceInfo
{
    NSInteger iCount=[pDataFlowers->pDataCellsShops count];
    NSInteger ISales=0;
    if(iCount>0)
    {
        if(iCount<2)
        {
            ISales=0;
        }
        if (iCount==2) {
            ISales=10;
        }
        else if(iCount>2 && iCount<5)
        {
            ISales=20;
        }
        else if(iCount>=5)
        {
            ISales=30;
        }
        
        NSInteger Row=0;
        NSInteger Sum=0;

        for (FlowersDataCell *TmpCell in pDataFlowers->pDataCellsShops) {
            
            NSString *KeyRow = [NSString stringWithFormat:@"%d",(int)Row];
            
            id ob=[vArrShop objectForKey:KeyRow];

            if(ob!=nil)
            {
                CellShop1 *TmpCellInTable=(CellShop1 *)ob;
                
                NSUInteger value = [TmpCellInTable.valueLabel.text intValue];
                NSInteger iPrice=[TmpCell->Price integerValue];

                Sum+=value*iPrice;
            }
            Row++;
        }
        
        if([pDataFlowers->pDataCellsShops count]==1)
        {
            Sum+=200;
        }
        
        id ob=[vArrShop objectForKey:ELEMAX];
        
        if(ob!=nil)
        {
            CellShop2 *TmpCellInTable=(CellShop2 *)ob;
            
            NSString *Sales2=@"Скидка ";
            Sales2=[Sales2 stringByAppendingString:[@(ISales) stringValue]];
            TmpCellInTable.lSaleLeft.text=[Sales2 stringByAppendingString:@"%"];
            
            
            int SalesValue=(int)((float)ISales*(float)Sum*0.01f);
            
            if(ISales>0)
            {
                TmpCellInTable.lSaleRight.text=[NSString stringWithFormat:@"-%d Р",SalesValue];
            }
            else TmpCellInTable.lSaleRight.text=@"0 Р";
            
            int AllSumm=(int)Sum-(int)SalesValue;
            TmpCellInTable.lSumaryPrice.text=[NSString stringWithFormat:@"%d Р",AllSumm];
        }
    }
}

-(IBAction)ShopithCart:(id)btn
{
    if(iCurSel!=I_PAGE_SHOPING)
    {
        self.title = @"КОРЗИНА";
        iCurSel=I_PAGE_SHOPING;
        
        [self ClearViews];
        vShoping.hidden=NO;
//        [vMain addSubview:vShoping];
        [self setNeedsDisplay];

        [vShopTable reloadData];
    }
}


-(IBAction)del_and_pay:(id)btn
{
    if(iCurSel!=I_PAGE_DEL_PAY)
    {
        self.title = @"Доставка и оплата";
        iCurSel=I_PAGE_DEL_PAY;
        
        [self ClearViews];
//        [vMain addSubview:vDel_Pay];
        vDel_Pay.hidden=NO;
        [self setNeedsDisplay];
    }
}

-(IBAction)FAQ:(id)btn
{
    if(iCurSel!=I_PAGE_FAQ)
    {
        self.title = @"F.A.Q";
        iCurSel=I_PAGE_FAQ;
        
        [self ClearViews];
//        [vMain addSubview:vFAQ];
        vFAQ.hidden=NO;
        
        [self setNeedsDisplay];
    }
}


-(IBAction)CLient:(id)btn
{
    if(iCurSel!=I_PAGE_CLIENT)
    {
        self.title = @"Корпоративным клиентам";
        iCurSel=I_PAGE_CLIENT;
        
        [self ClearViews];
//        [vMain addSubview:vClients];
        vClients.hidden=NO;
        
        [self setNeedsDisplay];
    }
}

-(IBAction)About:(id)btn
{
    if(iCurSel!=I_PAGE_ABOUT)
    {
        self.title = @"O MANYFLOWER";
        iCurSel=I_PAGE_ABOUT;
        
        [self ClearViews];
        _vAboutText.hidden=NO;
        
        [self setNeedsDisplay];
    }
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
        {
            NSLog(@"You sent the email.");
            
            if(iCurSel==I_PAGE_FINISH_BUY)
            {
                iCurrentStep=4;
                [self UpdateInterfaceBuyFinish];
            }
            if(iCurSel==I_PAGE_CREATE)
            {
                textFieldFor.text=@"Кому: любимой, жене, коллеге...";
                textFieldCase.text=@"По какому случаю";
                tfCreatePrice.text=@"Стоимость до...";
                textFieldWich.text=@"Пожелание к букету: цвет,состав";
                textFieldPhone.text=@"+7 (___) ___-__-__";
            }
        }
            break;
        case MFMailComposeResultSaved:
        {
            if(iCurSel==I_PAGE_FINISH_BUY)
            {
                iCurrentStep=2;
                //                [self UpdateInterfaceBuyFinish];
            }

            NSLog(@"You saved a draft of this email");
        }
            break;
        case MFMailComposeResultCancelled:
        {
            if(iCurSel==I_PAGE_FINISH_BUY)
            {
                iCurrentStep=2;
//                [self UpdateInterfaceBuyFinish];
            }

            NSLog(@"You cancelled sending this email.");
        }
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Сообщение"
                                                                 message:@"К сожалению сейчас невозможно послать письмо. Попробуйте изменить насройки почты или интернета."
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
            [errorAlert show];

            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
        }
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)FeedBack:(id)btn
{
    if(iCurSel!=I_PAGE_FEEDBACK)
    {
        self.title = @"ОБРАТНАЯ СВЯЗЬ";
        iCurSel=I_PAGE_FEEDBACK;
        
        [self ClearViews];
        _vFeedBack.hidden=NO;
    
//        if(bInMyDataSave==YES)
 //       {
////            [self ClearViews];
//            
//            if ([MFMailComposeViewController canSendMail])
//            {
//                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
//                mail.mailComposeDelegate = self;
//                [mail setSubject:@"Сообщение"];
//        
//                NSString *GeneralStr=[NSString
//                stringWithFormat:@"Имя:%@\nтелефон:%@\nE-mail:%@\nВаше сообщение:",sName,sPhone,sEmail];
//                
//                [mail setMessageBody:GeneralStr isHTML:NO];
//                
//                [mail setToRecipients:@[E_MAIL]];
////                [mail addAttachmentData:nil mimeType:@"" fileName:@""];
//                
////                [mail se]
//                [self presentViewController:mail animated:YES completion:NULL];
//            }
//            else
//            {
//                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Сообщение"
//                                        message:@"К сожалению сейчас невозможно послать письмо. Попробуйте изменить насройки почты или интернета."
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"OK"
//                                                           otherButtonTitles:nil];
//                [errorAlert show];
//            }
//            
//        }
//        else
//        {
//            [self MyPar:btn];
//            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Сообщение"
//                                    message:@"Пожалуйста заполните информацию о себе."
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"OK"
//                                                       otherButtonTitles:nil];
//            [errorAlert show];
//        }
        
        [self setNeedsDisplay];
    }
}

-(IBAction)SendMessageCreate:(id)btn
{
    NSString *urlString = @"http://web-air.ru:8082/delivery_mail/";
    
    NSString *parameter = [NSString stringWithFormat:
               @"type=%@&email=%@&title=%@&for_whom=%@&cause=%@&phone=%@&message=%@&max_price=%@&address=%@",
               @"exclusive_flavor",@[E_MAIL],@"exclusive flavor",textFieldFor.text,
               textFieldCase.text,textFieldPhone.text,textFieldWich.text,tfCreatePrice.text,@"адрес"];
    
    [pClient PostSend:urlString Params:parameter
          competition:^(NSData *result,NSURLResponse *response,NSError *error) {
        
        if(result != nil && [result length]>0)
        {
//            NSJSONSerialization *ArrJsonSales = [NSJSONSerialization JSONObjectWithData:result
//                                                           options:NSJSONReadingMutableContainers error:nil];
            NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"mailsent" ofType:@"mp3"];
            SystemSoundID soundID;
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
            AudioServicesPlaySystemSound (soundID);
        }
    }];
        
    

    return;
    
    
    [self.view endEditing:YES];
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Сообщение"];
        
        NSString *GeneralStr=[NSString
                    stringWithFormat:@"Для кого:%@\nПо какому случаю:%@\nтелефон:%@\nПожелание:%@\nСтоимость до:%@\n",
                    textFieldFor.text,textFieldCase.text,textFieldPhone.text,textFieldWich.text,tfCreatePrice.text];
        
        [mail setMessageBody:GeneralStr isHTML:NO];
        
//        mail.modalPresentationStyle = UIModalPresentationFormSheet;
        [mail setToRecipients:@[E_MAIL]];
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Сообщение"
                                                             message:@"К сожалению сейчас невозможно послать письмо. Попробуйте изменить насройки почты или интернета."
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
    }
}

-(IBAction)MyPar:(id)btn
{
    if(iCurSel!=I_PAGE_MY_PARAMETR)
    {
        [fMyDataName setText:sName];
        [fMyDataPhone setText:sPhone];
        [fMyDataEmail setText:sEmail];
        [fMyDataSity setText:sCity];
        
        [bCity selectRow:iNumCity inComponent:0 animated:NO];

        [fMyDataAdress setText:sAdress];

        self.title = @"МОИ ДАННЫЕ";
        iCurSel=I_PAGE_MY_PARAMETR;
        [self updateMyData];
        
        [self ClearViews];
        vMypar.hidden=NO;
        
        float CenterX=vMain.frame.size.width/2;
        float CenterY=(vMain.frame.size.height)/2;
        [vMypar setFrame:CGRectMake(0,0,vMain.bounds.size.width,vMain.bounds.size.height)];
        vMyparInside.center=CGPointMake(CenterX, CenterY);

        [self setNeedsDisplay];
    }
}
//методы для эдитбоксов в настойках-Start----------------------------------------------------------------
-(IBAction)OnDidEdit:(id)textFiled
{
    TmpTextFieldFocus=(UITextField*)textFiled;
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validatePhoneWithString:(NSString*)phone
{
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:phone];
    valid = [alphaNums isSupersetOfSet:inStringSet];
        
    return ([phone length]>5)&&valid;
}

-(IBAction)OnDidBeginEnterAdress:(UITextField *)textFiled{}

-(IBAction)OnDidEnterAdress:(UITextField *)textFiled
{
    if(TmpTextFieldT==textFiled)
    {
        NSString *Tmp= textFiled.text;
        
        if([Tmp isEqualToString:@""])
        {
            int v1=(int)[vArrAdressTable count]-1;
            int v2=(int)TmpTextFieldT.tag;
            if(v1>=v2)
                [vArrAdressTable removeObjectAtIndex:TmpTextFieldT.tag];
        }
        else
        {            
            [vArrAdressTable replaceObjectAtIndex:textFiled.tag withObject:Tmp];
            TmpTextFieldT.userInteractionEnabled = NO;
            bNewAdressInTable=NO;
        }
        
        [self UpdateAdres];
        [tAdresTable reloadData];
    }

}
//-(IBAction)OnDidEnter:(id)textFiled
//{
//    UITextField *TmpTextField=(UITextField*)textFiled;
//    if(TmpTextField==fName)
//    {
//        if([fName.text isEqual:@""])
//        {
//            fName.text=@"Не заполнено";
//            [TmpTextField setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
//        }
//        
//   //     [fPhone becomeFirstResponder];
//    }
//    
//    if(TmpTextField==fPhone)
//    {
//        if([fPhone.text isEqual:@""])
//        {
//            TmpTextField.text=@"Не заполнен";
//        }
//        
//        if(![self validatePhoneWithString:fPhone.text])
//        {
//            [TmpTextField setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
//        }
//  //      [fEmail becomeFirstResponder];
//    }
//    
//    if(TmpTextField==fEmail)
//    {
//        if(![self validateEmailWithString:fEmail.text])
//        {
//            [TmpTextField setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
//        }
//
//        if([fEmail.text isEqual:@""])
//        {
//            fEmail.text=@"Не заполнен";
//            [TmpTextField setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
//        }
//
//   //     [fAdress becomeFirstResponder];
//    }
//    
//    if(TmpTextField==fAdress)
//    {
//        if([fAdress.text length]==0)
//        {
//            [TmpTextField setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
//            fAdress.text=@"Не заполнен";
//        }
//        OffsetY_In_myPar=0;
//    }
//    [self setNeedsDisplay];
//}
//
//-(IBAction)OnFocusEditBox:(id)textFiled
//{
//    TmpTextFieldFocus=(UITextField*)textFiled;
//    
////    NSDictionary* info = [aNotification userInfo];
////    CGRect keyPadFrame=[[UIApplication sharedApplication].keyWindow convertRect:[[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue] fromView:self.view];
////    CGSize kbSize =keyPadFrame.size;
//
//    [TmpTextFieldFocus setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
//    
//    if(TmpTextFieldFocus==fName)
//    {
//        if([fName.text isEqual:@"Не заполнено"])
//        {
//            fName.text=@"";
//        }
//    }
//    
//    if(TmpTextFieldFocus==fPhone)
//    {
//        if([fPhone.text isEqual:@"Не заполнен"])
//        {
//            fPhone.text=@"";
//        }
//    }
//
//    if(TmpTextFieldFocus==fEmail)
//    {
//        if([fEmail.text isEqual:@"Не заполнен"])
//        {
//            fEmail.text=@"";
//        }
//    }
//
//    if(TmpTextFieldFocus==fAdress)
//    {
//        if([fAdress.text isEqual:@"Не заполнен"])
//        {
//            fAdress.text=@"";
//        }
//    }
//}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView==tMessage)
    {
        if([textView.text isEqual:@"Дополнительная информация"])
            textView.text=@"";
    }

    if(textView==tMessagePost)
    {
        if([textView.text isEqual:@"Добавить открытку"])
            textView.text=@"";
        
  //      CGPoint rootViewPoint = [[textView superview] convertPoint:textView.center toView:vCreate];
   //     int TmpY=textView.frame.size.height/2+10;
  //      int Delta=rootViewPoint.y-TmpY;
        
        [UIView animateWithDuration:0.5 animations:^{
            vInsideFinishShop.center = CGPointMake(vInsideFinishShop.center.x,
                                                   vInsideFinishShop.center.y-150);
        }];
    }

    if(textView==textFieldWich)
    {
        if([textView.text isEqual:@"Пожелание к букету: цвет,состав"])
            textFieldWich.text=@"";
        
        CGPoint rootViewPoint = [[textView superview] convertPoint:textView.center toView:vFinishShop];
        int TmpY=textView.frame.size.height/2+10;
        int Delta=rootViewPoint.y-TmpY;
        
        [UIView animateWithDuration:0.5 animations:^{
            scrollviewCreate.contentOffset = CGPointMake(0, scrollviewCreate.contentOffset.y+Delta);
        }];
    }
    
    if(textView==_fMyFeedMessage)
    {
        if([_fMyFeedMessage.text isEqual:@"Текст"])
            _fMyFeedMessage.text=@"";
        
        CGPoint rootViewPoint = [[textView superview] convertPoint:textView.center toView:_vFeedBack];
        int TmpY=textView.frame.size.height/2+10;
        int Delta=rootViewPoint.y-TmpY;

        [UIView animateWithDuration:0.5 animations:^{
            _vFeedBackInside.contentOffset = CGPointMake(0, _vFeedBackInside.contentOffset.y+Delta);
        }];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView==tMessagePost)
    {
    //    CGPoint rootViewPoint = [[textView superview] convertPoint:textView.center toView:vCreate];
    //    int TmpY=textView.frame.size.height/2+10;
   //     int Delta=rootViewPoint.y-TmpY;
        
        [UIView animateWithDuration:0.5 animations:^{
            vInsideFinishShop.center = CGPointMake(vInsideFinishShop.center.x,
                                                   vInsideFinishShop.center.y+150);
        }];

        if([tMessage.text isEqual:@""])
            tMessage.text=@"Дополнительная информация";
    }

    if(textView==tMessage)
    {
        if([tMessage.text isEqual:@""])
            tMessage.text=@"Дополнительная информация";
    }

    if(textView==textFieldWich)
    {
        if([textFieldWich.text isEqual:@""])
            textFieldWich.text=@"Пожелание к букету: цвет,состав";
    }

    if(textView==_fMyFeedMessage)
    {
        if([_fMyFeedMessage.text isEqual:@""])
            _fMyFeedMessage.text=@"Текст";
    }
}

//обрабатываем у textview нажатие enter
- (BOOL) textView: (UITextView*) textView shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    if(textView==textFieldWich)
    {
        if ([text isEqualToString:@"\n"])
        {
            if([textView.text isEqualToString:@""])
                textView.text=@"Пожелание к букету: цвет,состав";

            [textView resignFirstResponder];
            return NO;
        }
    }

    if(textView==_fMyFeedMessage)
    {
        if ([text isEqualToString:@"\n"])
        {
            if([textView.text isEqualToString:@""])
                textView.text=@"Текст";
            
            [textView resignFirstResponder];
            return NO;
        }
    }

    if(textView==tMessage)
    {
        if ([text isEqualToString:@"\n"])
        {
            if([textView.text isEqualToString:@""])
                textView.text=@"Дополнительная информация";
            
            [textView resignFirstResponder];
            return NO;
        }
    }

    if(textView==tMessagePost)
    {
        if ([text isEqualToString:@"\n"])
        {
            if([textView.text isEqualToString:@""])
                textView.text=@"Добавить открытку";
            
            [textView resignFirstResponder];
            return NO;
        }
    }
return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if(textField==textFieldFor)
    {
        if([textFieldFor.text isEqualToString:@""])
            textFieldFor.text=@"Кому: любимой, жене, коллеге...";
    }
    
    if(textField==textFieldFor)
    {
        if([textFieldFor.text isEqualToString:@""])
            textFieldFor.text=@"Кому: любимой, жене, коллеге...";
    }

    if(textField==textFieldCase)
    {
        if([textFieldCase.text isEqualToString:@""])
            textFieldCase.text=@"По какому случаю";
    }
    
    if(textField==tfCreatePrice)
    {
        if([tfCreatePrice.text isEqualToString:@""])
            tfCreatePrice.text=@"Стоимость до...";
    }
    
    if(textField==fMyDataName)
    {
        if([fMyDataName.text isEqual:@""])
        {
            fMyDataName.text=@"Не заполнено";
        }
    }
    
    if(textField==fMyDataEmail)
    {
        if(![self validateEmailWithString:fMyDataEmail.text])
        {
            fMyDataEmail.text=@"Не заполнен";
        }
        else if([fEmail.text isEqual:@""])
        {
            fMyDataEmail.text=@"Не заполнен";
        }
    }

    if(textField==fMyDataSity)
    {
        if([fMyDataSity.text length]==0)
        {
            fMyDataSity.text=@"Не заполнен";
        }
    }

    if(textField==fMyDataAdress)
    {
        if([fMyDataAdress.text length]==0)
        {
            fMyDataAdress.text=@"Не заполнен";
        }
    }

    
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField*) tf{

    if(tf==fMyDataEmail || tf==fMyDataName || tf==fMyDataSity || tf==fMyDataAdress)
    {
        tf.text=@"";
    }
    
    if(tf==textFieldFor || tf==textFieldCase || tf==tfCreatePrice)
    {
        tf.text=@"";
        CGPoint rootViewPoint = [[tf superview] convertPoint:tf.center toView:vCreate];
        int TmpY=30;
        int Delta=rootViewPoint.y-TmpY;
        
        [UIView animateWithDuration:0.5 animations:^{
            scrollviewCreate.contentOffset = CGPointMake(0, scrollviewCreate.contentOffset.y+Delta);
        }];
    }

    if(tf==textFieldPhone)
    {
        tf.text=@"+7 ";
        
        CGPoint rootViewPoint = [[tf superview] convertPoint:tf.center toView:vCreate];
        int TmpY=30;
        int Delta=rootViewPoint.y-TmpY;
        
        [UIView animateWithDuration:0.5 animations:^{
            scrollviewCreate.contentOffset = CGPointMake(0, scrollviewCreate.contentOffset.y+Delta);
        }];
    }

    if(tf==_fMyFeedBackName || tf==_fMyFeedBackEmail)
    {
        tf.text=@"";
        
        CGPoint rootViewPoint = [[tf superview] convertPoint:tf.center toView:_vFeedBack];
        int TmpY=30;
        int Delta=rootViewPoint.y-TmpY;
        
        [UIView animateWithDuration:0.5 animations:^{
            _vFeedBackInside.contentOffset = CGPointMake(0, _vFeedBackInside.contentOffset.y+Delta);
        }];
    }
    
    if(tf==_fMyFeedPhone)
    {
        tf.text=@"+7 ";
        
        CGPoint rootViewPoint = [[tf superview] convertPoint:tf.center toView:_vFeedBack];
        int TmpY=30;
        int Delta=rootViewPoint.y-TmpY;
        
        [UIView animateWithDuration:0.5 animations:^{
            _vFeedBackInside.contentOffset = CGPointMake(0, _vFeedBackInside.contentOffset.y+Delta);
        }];
    }

    if(tf==fMyDataPhone)
    {
        tf.text=@"+7 ";
    }

    if(tf==fDateDeliv)
    {
        fDateDeliv.text=@"";
        bCalendar.enabled=NO;
        
        [UIView animateWithDuration:0.5 animations:^{
            vInsideFinishShop.center = CGPointMake(vInsideFinishShop.center.x,78);
        }];
    }

    if(tf==fTimeDeliv)
    {
        fTimeDeliv.text=@"";
        
        [UIView animateWithDuration:0.5 animations:^{
            vInsideFinishShop.center = CGPointMake(vInsideFinishShop.center.x,78);
        }];
    }
}

-(void)textFieldDidEndEditing:(UITextField*) tf
{
    if(tf==textFieldFor)
    {
        if([textFieldFor.text isEqualToString:@""])
            textFieldFor.text=@"Кому: любимой, жене, коллеге...";
    }
    
    if(tf==textFieldCase)
    {
        if([textFieldCase.text isEqualToString:@""])
            textFieldCase.text=@"По какому случаю";
    }
    
    if(tf==tfCreatePrice)
    {
        if([tfCreatePrice.text isEqualToString:@""])
            tfCreatePrice.text=@"Стоимость до...";
    }
    
    if(tf==textFieldPhone)
    {
        if([textFieldPhone.text isEqualToString:@"+7 "])
            textFieldPhone.text=@"+7 (___) ___-__-__";
    }

    if(tf==fDateDeliv)
    {
        bCalendar.enabled=YES;
        [UIView animateWithDuration:0.5 animations:^{
            vInsideFinishShop.center = CGPointMake(vInsideFinishShop.center.x,
                                                   228.5);
        }];

        if([fDateDeliv.text isEqualToString:@""])
            fDateDeliv.text=@"17 мая 2005";
    }

    if(tf==fTimeDeliv)
    {
        [UIView animateWithDuration:0.5 animations:^{
            vInsideFinishShop.center = CGPointMake(vInsideFinishShop.center.x,
                                                   228.5);
        }];

        if([fTimeDeliv.text isEqualToString:@""])
            fTimeDeliv.text=@"Укажите время";
    }
    
    if(tf==_fMyFeedPhone)
    {
        if([tf.text isEqualToString:@"+7 "])
            tf.text=@"+7 (___) ___-__-__";
    }

    if(tf==_fMyFeedBackName)
    {
        if([tf.text isEqualToString:@""])
            tf.text=@"Ваше имя";
    }
    
    if(tf==_fMyFeedBackEmail)
    {
        if([tf.text isEqualToString:@""])
            tf.text=@"E-mail";
    }
}

//- (void)keyboardWillHide:(NSNotification *)n
//{
//    OffsetY_In_myPar=0;
//
//    [self setNeedsDisplay];
//    
//    bkeyboardIsShown = NO;
//}
//
//-(void)keyboardWillShow:(NSNotification *)n
//{
//    if (bkeyboardIsShown) {
//        return;
//    }
//
//    NSDictionary* userInfo = [n userInfo];
//
//    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    float DownPoint=keyboardSize.height;
//
//    float Tmp=(vMain.frame.size.height-vMyparInside.frame.size.height)/2+72;
//    float Tmp2=vMyparInside.frame.size.height-TmpTextFieldFocus.center.y+Tmp;
//    float OffsetAbs=Tmp2-TmpTextFieldFocus.frame.size.height/2-10;
//
//    if(OffsetAbs<DownPoint)
//        OffsetY_In_myPar=OffsetAbs-DownPoint;
//    else OffsetY_In_myPar=0;
//
//    [self setNeedsDisplay];
//    
//    bkeyboardIsShown = YES;
//}
//методы для эдитбоксов в настойках-End----------------------------------------------------------------
@end
