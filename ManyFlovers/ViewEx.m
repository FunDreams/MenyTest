//
//  ViewEx.m
//  ManyFlowers
//
//  Created by Konstantin on 17.06.16.
//  Copyright © 2016 Olga. All rights reserved.
//

#import "ViewEx.h"

@implementation ViewEx
@synthesize  tvTextInside,WitdhConstrain;
-(void)InitData
{
    bCheck=NO;
    _bOpen = [UIButton buttonWithType:UIButtonTypeCustom];
    _bOpen.frame = CGRectMake(self.frame.size.width-30,1,28,28);
    [_bOpen setImage:[UIImage imageNamed:@"b_open_close.png"] forState:UIControlStateNormal];
    [_bOpen setImage:[UIImage imageNamed:@"b_open_close.png"] forState:UIControlStateHighlighted];
    [_bOpen addTarget:self action:@selector(PushButton:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bOpen];
    
    
    tvTextInside = [[UITextView alloc] initWithFrame:CGRectMake(-4, -2, self.frame.size.width, 40)];
    tvTextInside.text = @"Здесь будет текст";
    
    tvTextInside.backgroundColor=[UIColor clearColor];
    tvTextInside.textColor=[UIColor colorWithRed:108.0/255.0
                                           green:106.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    tvTextInside.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    tvTextInside.userInteractionEnabled=NO;
    [self addSubview:tvTextInside];
    
    
    _imageLine = [[UIImageView alloc] init];
    
    _imageLine.frame=CGRectMake(0,self.frame.size.height-1,self.frame.size.width,1);
    [_imageLine setImage:[UIImage imageNamed:@"LineCell.png"]];
    [self addSubview:_imageLine];

}

-(IBAction)PushButton:(id)sender
{
    if(bCheck==YES)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            WitdhConstrain.constant=30;

            [self.superview layoutIfNeeded];

            self.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width, 30);
            _imageLine.frame=CGRectMake(0,self.frame.size.height-1,self.frame.size.width,1);
            tvTextInside.alpha=1;
            
        }
        completion:^(BOOL completed)
        {
            _bOpen.transform = CGAffineTransformMakeScale(1,1);
            bCheck=NO;
        }];
    }
    else
    {

        [UIView animateWithDuration:0.5 animations:^{
            
            WitdhConstrain.constant=100;

            [self.superview layoutIfNeeded];

            self.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width, 100);
            _imageLine.frame=CGRectMake(0,self.frame.size.height-1,self.frame.size.width,1);
            tvTextInside.alpha=0;
            
        }
        completion:^(BOOL completed)
        {
            _bOpen.transform = CGAffineTransformMakeScale(1,-1);
            bCheck=YES;
        }];
    }
};

@end
