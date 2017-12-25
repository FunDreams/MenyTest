//
//  ManyFlowersCell.h
//  ManyFlowers
//
//  Created by Konstantin on 02.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManyFlowersCellIpad : UITableViewCell <UIScrollViewDelegate>
{
    BOOL pageControlUsed;
    
//    unsigned kNumberOfPages;
}

@property (nonatomic) unsigned kNumberOfPages;

@property (strong, nonatomic) IBOutlet UIView *vViewDetails;

@property (strong, nonatomic) IBOutlet UILabel *lName0;
@property (strong, nonatomic) IBOutlet UILabel *lName;
@property (strong, nonatomic) IBOutlet UILabel *lPrice;

@property (strong, nonatomic) IBOutlet UILabel *ldelivery;
@property (strong, nonatomic) IBOutlet UILabel *lFlowers;
@property (strong, nonatomic) IBOutlet UILabel *lArticle;
@property (strong, nonatomic) IBOutlet UILabel *lpackage;
@property (strong, nonatomic) IBOutlet UILabel *lDxH;
@property (strong, nonatomic) IBOutlet UILabel *lInMCAD;
@property (strong, nonatomic) IBOutlet UILabel *lOUTMCAD;

@property (strong, nonatomic)IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)IBOutlet UIPageControl *pageControl;


@property (strong, nonatomic) IBOutlet UIButton *bFavorits;
@property (strong, nonatomic) IBOutlet UIButton *bBuy;

- (void)InitAllPages:(int)CountPages;

@property (nonatomic, retain) NSMutableArray *viewControllers;
- (id)loadScrollViewWithPage:(int)page;



@end
