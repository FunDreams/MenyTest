//
//  OptionsMenu.m
//  ManyFlowers
//
//  Created by Konstantin on 12.05.16.
//  Copyright © 2016 Olga. All rights reserved.
//

#import "OptionsMenu.h"
#import "ViewController.h"
#import "ListFlower.h"

@interface OptionsMenu ()

@end

@implementation OptionsMenu
@synthesize pParent;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect ScreenRect=[[UIScreen mainScreen] bounds];
    [_PanelButton setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    _PanelButton.frame=CGRectMake(ScreenRect.size.width-40, 0, 40, ScreenRect.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PushBack:(id)sender {
    [pParent movePanelCenter];
}

- (IBAction)PushCatalog:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController Catalog:nil];
}

- (IBAction)PushSales:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController Sales:nil];
}

- (IBAction)PushFavorit:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController Favorit:nil];
}

- (IBAction)PushCreate:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController Create:nil];
}

- (IBAction)PushDelAndPay:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController About:nil];

 //   [pParent.pListFlowerController del_and_pay:nil];
}


- (IBAction)PushFAQ:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController About:nil];

 //   [pParent.pListFlowerController FAQ:nil];
}

- (IBAction)PushCLient:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController About:nil];

 //   [pParent.pListFlowerController CLient:nil];
}

- (IBAction)PushAbout:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController About:nil];
}

- (IBAction)PushMyPar:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController MyPar:nil];
}

- (IBAction)PushShopithCart:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController ShopithCart:nil];
}

- (IBAction)PushFeedBack:(id)sender {
    [pParent movePanelCenter];
    
    [pParent.pListFlowerController FeedBack:sender];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
