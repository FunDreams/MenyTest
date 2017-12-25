//
//  ViewControllerListFlower.h
//  ManyFlowers
//
//  Created by Konstantin on 04.02.16.
//  Copyright © 2016 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerListFlower : UIViewController
{
    int flowerNumber;

    int pageNumber;
    UIColor *pageControlColorWithIndex;
    UIImageView *Image;
}
@property (nonatomic, retain) UILabel *pageNumberLabel;
@property (nonatomic, retain) UIImageView *Image;

- (id)initWithPageNumber:(int)page flowerNumber:(int)flower;


@end
