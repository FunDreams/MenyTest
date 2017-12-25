//
//  ManyFlowersCell.h
//  ManyFlowers
//
//  Created by Konstantin on 02.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManyFlowersCell : UITableViewCell <UIScrollViewDelegate>
{
    BOOL pageControlUsed;
}
@property (strong, nonatomic) IBOutlet UIView *vViewDetails;
@property (strong, nonatomic) IBOutlet UIView *vFon;
@property (strong, nonatomic) IBOutlet UIView *vBottomFrame;

@property (strong, nonatomic) IBOutlet UILabel *lName;
@property (strong, nonatomic) IBOutlet UILabel *lPrice;
@property (strong, nonatomic) IBOutlet UILabel *lPrice2;
@property (strong, nonatomic) IBOutlet UILabel *lSend;

@property (strong, nonatomic) IBOutlet UIButton *bFavorits;
@property (strong, nonatomic) IBOutlet UIButton *bBuy;
@property (strong, nonatomic) IBOutlet UIButton *bBuy2;
@property (strong, nonatomic) IBOutlet UIButton *bCloseDetails;

@property (strong, nonatomic) IBOutlet UILabel *ldelivery;
@property (strong, nonatomic) IBOutlet UILabel *lFlowers;
@property (strong, nonatomic) IBOutlet UILabel *lArticle;
@property (strong, nonatomic) IBOutlet UILabel *lpackage;
@property (strong, nonatomic) IBOutlet UILabel *lDxH;
@property (strong, nonatomic) IBOutlet UILabel *lInMCAD;
@property (strong, nonatomic) IBOutlet UILabel *lOUTMCAD;

@property (strong, nonatomic)IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)IBOutlet UIPageControl *pageControl;
@property (nonatomic) unsigned kNumberOfPages;
@property (nonatomic, retain) NSMutableArray *viewControllers;

- (void)InitAllPages:(int)CountPages;
- (id)loadScrollViewWithPage:(int)page;


@property(nonatomic, assign) int Big;

@end
