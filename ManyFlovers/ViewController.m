//
//  ViewController.m
//  TEst
//
//  Created by Konstantin on 10.02.16.
//  Copyright © 2016 Olga. All rights reserved.
//

#import "ViewController.h"
#import "ListFlower.h"

@implementation ViewController

@synthesize InMoscow,NotMoscow,pListFlowerController;

- (void)SynData
{
    [pListFlowerController->pDataFlowers SynData];
}
- (void)SaveData
{
    [pListFlowerController SaveData];
}

- (void)LoadData
{
    [pListFlowerController LoadData];
}

- (void)ShowButton
{
    InMoscow.hidden=NO;
    NotMoscow.hidden=NO;
}

- (void)viewDidLoad {

    [self LoadData];
    pOptionsMenu=[[OptionsMenu alloc] initWithNibName:@"OptionsMenu" bundle:nil];
    [self.view addSubview:pOptionsMenu.view];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float HeightStatusBar=[UIApplication sharedApplication].statusBarFrame.size.height;

    pOptionsMenu.view.frame=CGRectMake(0, HeightStatusBar, screenRect.size.width,
                                       screenRect.size.height-HeightStatusBar);
    
    pOptionsMenu.view.hidden=YES;
    pOptionsMenu.pParent=self;

    pListFlowerController=[[ListFlower alloc] init];
    [self LoadData];

    pListFlowerController.pParent=self;

    [Fon setTranslatesAutoresizingMaskIntoConstraints:YES];
    Fon.frame=CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    
    navCon = [[UINavigationController alloc]
                                      initWithRootViewController:pListFlowerController];
}

-(void)movePanelRight {

    pOptionsMenu.view.hidden=NO;
    
    navCon.tabBarController.view.userInteractionEnabled = NO;
    navCon.view.userInteractionEnabled = NO;

    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
    animations:^
    {
        navCon.view.frame = CGRectMake(self.view.frame.size.width - 40,
                0, self.view.frame.size.width, self.view.frame.size.height);
    }
    completion:^(BOOL finished)
    {
         if (finished)
         {
         }
    }];
}

-(void)movePanelCenter{
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^
     {
         navCon.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
     }
     completion:^(BOOL finished)
     {
         if (finished)
         {
             pOptionsMenu.view.hidden=YES;
             navCon.tabBarController.view.userInteractionEnabled = YES;
             navCon.view.userInteractionEnabled = YES;
         }
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)YesInMoscow:(id)sender {
    
 //   [self presentViewController:navCon animated:YES completion:nil];
    
    [navCon willMoveToParentViewController:self];
    [self addChildViewController:navCon];
    [navCon didMoveToParentViewController:self];

    [UIView transitionWithView:self.view duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self.view addSubview:navCon.view]; }
                    completion:^(BOOL finished)
     {
         if (finished)
         {

         }
     }];


  //  [navCon pushViewController:self animated:YES];
//    [self.navigationController pushViewController:B animated:YES];
}

- (IBAction)NotMoscow:(id)sender {
    
    [navCon willMoveToParentViewController:self];
    [self addChildViewController:navCon];
    [navCon didMoveToParentViewController:self];
    
    [UIView transitionWithView:self.view duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self.view addSubview:navCon.view]; }
                    completion:nil];
}

@end
