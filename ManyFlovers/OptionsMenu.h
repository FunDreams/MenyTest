//
//  OptionsMenu.h
//  ManyFlowers
//
//  Created by Konstantin on 12.05.16.
//  Copyright © 2016 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface OptionsMenu : UIViewController

@property (strong, retain) ViewController *pParent;
@property (strong, retain) IBOutlet UIButton *PanelButton;

@end
