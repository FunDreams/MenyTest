//
//  ViewControllerListFlower.m
//  ManyFlowers
//
//  Created by Konstantin on 04.02.16.
//  Copyright © 2016 Olga. All rights reserved.
//

#import "ViewControllerListFlower.h"

@interface ViewControllerListFlower ()

@end

@implementation ViewControllerListFlower
@synthesize pageNumberLabel,Image;


+ (UIColor *)pageControlColorWithIndex:(NSUInteger)index {
    
    NSArray *pageControlColorList;
    
    if (pageControlColorList == nil) {
        pageControlColorList = [[NSArray alloc] initWithObjects:[UIColor grayColor], [UIColor greenColor],
                                [UIColor magentaColor],[UIColor blueColor], [UIColor orangeColor], [UIColor brownColor],
                                [UIColor redColor], nil];
    }
    
    return [UIColor clearColor];//[pageControlColorList objectAtIndex:index % [pageControlColorList count]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [ViewControllerListFlower pageControlColorWithIndex:pageNumber];
    
 //   UIImage* myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flower.png"]];
//    UIImage* myImage = [UIImage imageNamed:@"flower.png"];

    Image = [[UIImageView alloc] initWithImage:nil];
    Image.frame=self.view.frame;
    Image.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:Image];
        
    [self.view addSubview:pageNumberLabel];

}

- (id)initWithPageNumber:(int)page flowerNumber:(int)flower {
    if (self = [super initWithNibName:nil bundle:nil]) {
        pageNumber = page;
        flowerNumber = flower;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
