//
//  ListFlower.h
//  ManyFlovers
//
//  Created by Konstantin on 23.08.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "FlowersData.h"
#import "PlManager.h"
#import "httpClient.h"
#import "ViewController.h"
#import "SHSPhoneLibrary.h"
#import "ViewEx.h"

//#define E_MAIL @"maximovka@bk.ru"
#define E_MAIL @"ya.olgadesign@yandex.ru"

#define I_PAGE_CATALOG      0
#define I_PAGE_CREATE       1
#define I_PAGE_SALES        2
#define I_PAGE_FAVORITS     3
#define I_PAGE_OPTIONS      4
#define I_PAGE_SHOPING      5
#define I_PAGE_DEL_PAY      6
#define I_PAGE_FAQ          7
#define I_PAGE_CLIENT       8
#define I_PAGE_ABOUT        9
#define I_PAGE_MY_PARAMETR  10
#define I_PAGE_FEEDBACK     11
#define I_PAGE_FINISH_BUY   12

#define IPAD     UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface ListFlower : UIViewController <UITableViewDelegate, UITableViewDataSource,
                    UIPickerViewDataSource,UIPickerViewDelegate,MFMailComposeViewControllerDelegate,
            UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIPopoverPresentationControllerDelegate>
{
    //для экрана создать
    UIScrollView *scrollviewCreate;
    UITextView *TextViewCreateUp;
    UITextField *textFieldFor;
    UITextField *textFieldCase;
    SHSPhoneTextField *textFieldPhone;
    UITextView *textFieldWich;
    UITextField *tfCreatePrice;
    UIButton *bCreateSendButton;
    //
    
    UIBarButtonItem *ShopithCart;
    UIBarButtonItem *optionButton;

    int iCurSel;
    
    CPlManager *pPlFileManager;
    BOOL bFilterOpen;
    int iButtonH;
    float OffsetY_In_myPar;
    
    UITextField *TmpTextFieldFocus;
    UIColor *TileColor;//цвет для тайла
    int iCurrentStep;
    int iCurrentActive;

    UIImageView *vImageCachGrey;
    BOOL iCheck;
    UIImageView *vImageCach;
    UIImageView *vImageNoCach;
    
    UITextField *TmpTextFieldT;
    
    NSMutableArray * SelectAdress;
    bool bNewAdressInTable;
    UITextField *tTmpSelect;
    NSMutableArray *pQueueDownLoad;

    UIImageView *PlusSign;
    
    UIViewController *viewControllerData;//контроллер для даты
    UIView *blockView;//блокирующий затемняющий экран
    
@public
    FlowersData *pDataFlowers;
}

@property (strong, retain) ViewController *pParent;
@property (strong, retain) httpClient *pClient;

#define ELEMAX @"max"

@property (strong, nonatomic) IBOutlet UISwitch *bSwitchInMoscow;
//данные пользователя========================================================
@property(nonatomic, assign) BOOL bFirstRun;
@property(nonatomic, assign) BOOL bInMoscow;
@property(nonatomic, assign) BOOL bInMyDataSave;
@property(nonatomic, assign) int iNumCity;
@property(copy) NSString *sName;
@property(copy) NSString *sPhone;
@property(copy) NSString *sCity;
@property(copy) NSString *sEmail;
@property(copy) NSString *sAdress;
//===========================================================================
@property(nonatomic, assign) NSInteger iNumFilerFlowers;
@property(nonatomic, assign) NSInteger iNumFilerToMan;
@property(nonatomic, assign) NSInteger iNumFilerPrice;

@property (strong, nonatomic) NSMutableArray *vArrCatalogFilter;
@property (strong, nonatomic) NSMutableDictionary *vArrCatalog;
@property (strong, nonatomic) NSMutableDictionary *vArrSales;
@property (strong, nonatomic) NSMutableDictionary *vArrShop;
@property (strong, nonatomic) NSMutableArray *vArrAdressTable;
@property (strong, nonatomic) NSMutableArray *vArrAdressTableTmp;

@property (strong, nonatomic) IBOutlet UITableView *vCatalogTable;
@property (strong, nonatomic) IBOutlet UITableView *vSalesTable;
@property (strong, nonatomic) IBOutlet UITableView *vFavoritsTable;
@property (strong, nonatomic) IBOutlet UITableView *vShopTable;
//различные окна
@property (strong, nonatomic) IBOutlet UIView *vMain;//главный вьювер с меню
@property (strong, nonatomic) IBOutlet UIView *vCatalog;
@property (strong, nonatomic) IBOutlet UIView *vCatalogFon;
@property (strong, nonatomic) IBOutlet UIView *vCreate;
@property (strong, nonatomic) IBOutlet UIView *vSales;
@property (strong, nonatomic) IBOutlet UIView *vSalesFon;
@property (strong, nonatomic) IBOutlet UIView *vFavorits;

@property (strong, nonatomic) IBOutlet UIView *vOptions;//настройки
@property (strong, nonatomic) IBOutlet UIView *vShoping;//корзина
@property (strong, nonatomic) IBOutlet UIView *vOptionsInside;//Внутри настроек
@property (strong, nonatomic) IBOutlet UIView *vDel_Pay;//доставка и плата
@property (strong, nonatomic) IBOutlet UIView *vFAQ;//FAQ
@property (strong, nonatomic) IBOutlet UIView *vClients;//Clients
@property (strong, nonatomic) IBOutlet UIView *vAbout;//About

@property (strong, nonatomic) IBOutlet UIView *vMypar;//обо мне
@property (strong, nonatomic) IBOutlet UIView *vMyparInside;//Внутренний вьювер
@property (strong, nonatomic) IBOutlet UIView *vMyparWhiteSQR;//Внутренний вьювер
@property (strong, nonatomic) IBOutlet UIImageView *vUpWhiteSQR;
@property (strong, nonatomic) IBOutlet UIImageView *vDownWhiteSQR;

@property (strong, nonatomic) IBOutlet UIView *vFinishShop;//экраны покупки
@property (strong, nonatomic) IBOutlet UIView *vInsideFinishShop;
@property (strong, nonatomic) IBOutlet UIButton *bShoppingCart;
@property (strong, nonatomic) IBOutlet UIButton *bNext;
@property (strong, nonatomic) IBOutlet UIImageView *iStep;
@property (strong, nonatomic) IBOutlet UIImageView *imageLine;
@property (strong, nonatomic) IBOutlet UIImageView *imageLine1Shop;

@property (strong, nonatomic) IBOutlet UILabel *lAdressDelivery;
@property (strong, nonatomic) IBOutlet UILabel *lDateDelivery;
@property (strong, nonatomic) IBOutlet UIButton *bNewAdress;
@property (strong, nonatomic) IBOutlet UIButton *bEditAdress;
@property (strong, nonatomic) IBOutlet UITableView *tAdresTable;
@property (strong, nonatomic) IBOutlet UIDatePicker *pDateDelivery;
@property (strong, nonatomic) IBOutlet UIButton *bToDay;
@property (strong, nonatomic) IBOutlet UIButton *bCalendar;

//элементы для экрана для текстовой страницы
@property (strong, nonatomic) UIView *vAboutText;
@property (strong, nonatomic) UIScrollView *vAboutInside;
@property (strong, nonatomic) UITextView *tvAboutVUp1;
@property (strong, nonatomic) UITextView *tvAboutVUp2;
@property (strong, nonatomic) UITextView *tvAboutFAQ;
@property (strong, nonatomic) UIImageView *tvAboutLine;
@property (nonatomic,strong) ViewEx *view1;
@property (nonatomic,strong) ViewEx *view2;
@property (nonatomic,strong) ViewEx *view3;
@property (strong, nonatomic) UITextView *tvAboutDown;

//элементы для экрана обратная связь
@property (strong, nonatomic) UIView *vFeedBack;
@property (strong, nonatomic) UIScrollView *vFeedBackInside;
@property (strong, nonatomic) UITextView *vFeedBackTVUp1;
@property (strong, nonatomic) UITextView *vFeedBackTVUp2;
@property (strong, nonatomic) UITextView *vFeedBackTVUp3;
@property (strong, nonatomic) UITextView *vFeedBackTVUp4;
@property (strong, nonatomic) UIImageView *iFeedBackFeedBackImage;
@property (strong, nonatomic) UITextView *tvFeedBackHead;
@property (strong, nonatomic) UITextField *fMyFeedBackName;
@property (strong, nonatomic) SHSPhoneTextField *fMyFeedPhone;
@property (strong, nonatomic) UITextField *fMyFeedBackEmail;
@property (strong, nonatomic) UITextView *fMyFeedMessage;
@property (strong, nonatomic) UIImageView *iFeedBackBackMessage;
@property (strong, nonatomic)  UIButton *bFeedBackSent;

//элементы для экрана мои данные
@property (strong, nonatomic)  UIButton *bEdit;
@property (strong, nonatomic)  UIButton *bSave;
@property (strong, nonatomic)  UIButton *bCansel;
@property (strong, nonatomic)  UIButton *bCach;
@property (strong, nonatomic)  UIButton *bNonCach;
@property (strong, nonatomic)  UIImageView *imageLine1;
@property (strong, nonatomic)  UIImageView *imageLine2;
@property (strong, nonatomic)  UILabel *lMyDataNameUp;
@property (strong, nonatomic)  UILabel *lMyDataNameDown;
@property (strong, nonatomic)  UILabel *lMyDataPhoneUp;
@property (strong, nonatomic)  UILabel *lMyDataPhoneDown;
@property (strong, nonatomic)  UILabel *lMyDataMailUp;
@property (strong, nonatomic)  UILabel *lMyDataMailDown;
@property (strong, nonatomic)  UILabel *lMyDataAdresUp;
@property (strong, nonatomic)  UILabel *lMyDatadresDown;
@property (strong, nonatomic) UITextField *fMyDataName;
@property (strong, nonatomic) SHSPhoneTextField *fMyDataPhone;
@property (strong, nonatomic) UITextField *fMyDataEmail;
@property (strong, nonatomic) UITextField *fMyDataSity;
@property (strong, nonatomic) UITextField *fMyDataAdress;


@property (strong, nonatomic) IBOutlet UIImageView *imageLineOn3step;
//@property (strong, nonatomic) IBOutlet UISlider *sPostCard;
@property (strong, nonatomic) IBOutlet UITextView *tMessage;
@property (strong, nonatomic) IBOutlet UITextView *tMessagePost;
@property (strong, nonatomic) IBOutlet UIImageView *ivPostard;

@property (strong, nonatomic) IBOutlet UILabel *lFourStepHeader;
@property (strong, nonatomic) IBOutlet UILabel *lFourNameShop;
@property (strong, nonatomic) IBOutlet UITextView *tMessageUp;
@property (strong, nonatomic) IBOutlet UITextView *tMessageDown;

////

@property (strong, nonatomic) IBOutlet UIView *vFilter;
@property (strong, nonatomic) IBOutlet UIButton *bFilter;

@property (strong, nonatomic) IBOutlet UIPickerView *bWithFlowers;
@property (strong, nonatomic) IBOutlet UIPickerView *bToMan;
@property (strong, nonatomic) IBOutlet UIPickerView *bUpToPrice;
@property (strong, nonatomic) IBOutlet UIPickerView *bCity;
@property (strong, nonatomic) IBOutlet UIButton *bResetFilter;

@property (strong, nonatomic) IBOutlet UILabel *lWithFlowers;
@property (strong, nonatomic) IBOutlet UILabel *lToMan;
@property (strong, nonatomic) IBOutlet UILabel *lUpToPrice;

@property (strong, nonatomic) NSMutableArray *vArrWithFlower;
@property (strong, nonatomic) NSMutableArray *vArrTo;
@property (strong, nonatomic) NSMutableArray *vArrByPriece;
@property (strong, nonatomic) NSMutableArray *vArrCity;

@property (strong, nonatomic) IBOutlet UIButton *bCatalog;
@property (strong, nonatomic) IBOutlet UIButton *bCreate;
@property (strong, nonatomic) IBOutlet UIButton *bFavorits;
@property (strong, nonatomic) IBOutlet UIButton *bSales;

@property (strong, nonatomic) IBOutlet UIButton *bCloseOptions;
@property (strong, nonatomic) IBOutlet UIButton *bCloseOptionsFaq;
@property (strong, nonatomic) IBOutlet UIButton *bCloseClients;
@property (strong, nonatomic) IBOutlet UIButton *bCloseAbout;

@property (strong, nonatomic) IBOutlet UITextField *fName;
@property (strong, nonatomic) IBOutlet UITextField *fPhone;
@property (strong, nonatomic) IBOutlet UITextField *fEmail;

@property (strong, nonatomic) IBOutlet UITextField *fDateDeliv;
@property (strong, nonatomic) IBOutlet UITextField *fTimeDeliv;


//@property (strong, nonatomic) IBOutlet UITextField *fCity;
@property (strong, nonatomic) IBOutlet UITextField *fAdress;

- (void)SaveData;
- (void)LoadData;

-(void)UpdatePrieceInfo;

- (IBAction)Catalog:(id)sender;
- (IBAction)Create:(id)sender;
- (IBAction)Sales:(id)sender;
- (IBAction)Favorit:(id)sender;
- (IBAction)del_and_pay:(id)btn;
- (IBAction)FAQ:(id)btn;
- (IBAction)CLient:(id)btn;
- (IBAction)About:(id)btn;
- (IBAction)MyPar:(id)btn;
- (IBAction)ShopithCart:(id)btn;
- (IBAction)SendMessage:(id)btn;
- (IBAction)FeedBack:(id)btn;

-(void)updateMyData;


@end

