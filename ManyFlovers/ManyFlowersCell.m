//
//  ManyFlowersCell.m
//  ManyFlowers
//
//  Created by Konstantin on 02.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import "ManyFlowersCell.h"
#import "ListFlower.h"
#import "ViewControllerListFlower.h"

@implementation ManyFlowersCell

@synthesize lName,lPrice,lSend,bBuy,bFavorits,bCloseDetails,Big,vViewDetails;
@synthesize lArticle,lpackage,lDxH,lInMCAD,lOUTMCAD,lFlowers,ldelivery,viewControllers;
@synthesize scrollView,pageControl,kNumberOfPages,vFon,vBottomFrame,bBuy2,lPrice2;

- (id)init {
    self = [super init];
    if (self) {
        Big=NO;
    }
    
    return self;
}

- (void)viewDidLoad {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)InitAllPages:(int)CountPages
{
    [vFon setTranslatesAutoresizingMaskIntoConstraints:YES];
    [vBottomFrame setTranslatesAutoresizingMaskIntoConstraints:YES];

    kNumberOfPages=CountPages;
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++)
    {
        [controllers addObject:[NSNull null]];
    }
    
    //    scrollView.frame=CGRectMake(0, 0, 400, 400);
    viewControllers = controllers;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages,
                                    scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    //    scrollView.delegate = self;
    
    pageControl.numberOfPages = kNumberOfPages;
    
    pageControl.currentPage = 0;
    [self loadScrollViewWithPage:0];
    //    [self loadScrollViewWithPage:1];
}

- (id)loadScrollViewWithPage:(int)page
{
    if (page < 0) return nil;
    if (page >= kNumberOfPages) return nil;
    
    ViewControllerListFlower *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[ViewControllerListFlower alloc] initWithPageNumber:page flowerNumber:3];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        CGRect frameImage = scrollView.frame;
        frameImage.origin.x=0;
        frameImage.origin.y=0;
        [controller.Image setImage:nil];
        controller.Image.frame = frameImage;
        [scrollView addSubview:controller.view];
    }
    
    return controller;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}
- (IBAction)changePage:(id)sender {
    int page = (int)pageControl.currentPage;
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
}

@end
