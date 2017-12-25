//
//  ViewController.h
//  TEst
//
//  Created by Konstantin on 10.02.16.
//  Copyright © 2016 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionsMenu.h"

@class ListFlower;
@interface ViewController : UIViewController
{
    UINavigationController *navCon;
    OptionsMenu *pOptionsMenu;
    
    IBOutlet UIImageView *Fon;
}
- (void)SaveData;
- (void)LoadData;
- (void)SynData;

- (IBAction)YesInMoscow:(UIButton*)sender;
- (IBAction)NotMoscow:(UIButton*)sender;

@property (strong, nonatomic) IBOutlet UIButton *InMoscow;
@property (strong, nonatomic) IBOutlet UIButton *NotMoscow;
@property (nonatomic, strong) ListFlower *pListFlowerController;

- (void)ShowButton;
-(void)movePanelRight;
-(void)movePanelCenter;

@end

