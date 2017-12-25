//
//  ManyFlowersCell.m
//  ManyFlowers
//
//  Created by Konstantin on 02.09.15.
//  Copyright (c) 2015 Olga. All rights reserved.
//

#import "ManyFlowersCellIpad.h"
#import "ListFlower.h"
#import "ViewControllerListFlower.h"

@implementation ManyFlowersCellIpad

@synthesize lName,lPrice,bBuy,bFavorits,vViewDetails,lName0;
@synthesize lArticle,lpackage,lDxH,lInMCAD,lOUTMCAD,lFlowers,ldelivery;
@synthesize scrollView,pageControl,viewControllers,kNumberOfPages;

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)InitAllPages:(int)CountPages
{
    kNumberOfPages=CountPages;
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++)
    {
        [controllers addObject:[NSNull null]];
    }
    
    //    scrollView.frame=CGRectMake(0, 0, 400, 400);
    viewControllers = controllers;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
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
- (void)viewDidAppear:(BOOL)animated {

    if(IPAD)
    {
        float CenterX=self.frame.size.width/2;
        scrollView.center=CGPointMake(CenterX-164, scrollView.center.y);
        pageControl.center=CGPointMake(scrollView.center.x,
                                       scrollView.center.y+scrollView.frame.size.height/2-25);

        lName0.center=CGPointMake(CenterX+100, lName0.center.y);
        lName.center=CGPointMake(CenterX+260, lName.center.y);
        bFavorits.center=CGPointMake(CenterX-345, bFavorits.center.y);
        bBuy.center=CGPointMake(CenterX+270, bBuy.center.y);
        lPrice.center=CGPointMake(CenterX+115, lPrice.center.y);
        vViewDetails.center=CGPointMake(CenterX+220, vViewDetails.center.y);
    }
}

//-(void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    
//    if(IPAD)
//    {
//        float CenterX=frame.size.width/2;
//        scrollView.center=CGPointMake(CenterX-164, scrollView.center.y);
//        pageControl.center=CGPointMake(scrollView.center.x,
//                                       scrollView.center.y+scrollView.frame.size.height/2-25);
//        
//        lName0.center=CGPointMake(CenterX+100, lName0.center.y);
//        lName.center=CGPointMake(CenterX+260, lName.center.y);
//        bFavorits.center=CGPointMake(CenterX-345, bFavorits.center.y);
//        bBuy.center=CGPointMake(CenterX+270, bBuy.center.y);
//        lPrice.center=CGPointMake(CenterX+115, lPrice.center.y);
//        vViewDetails.center=CGPointMake(CenterX+220, vViewDetails.center.y);
//    }
//}
@end
