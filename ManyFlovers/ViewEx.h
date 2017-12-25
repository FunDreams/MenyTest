//
//  ViewEx.h
//  ManyFlowers
//
//  Created by Konstantin on 17.06.16.
//  Copyright © 2016 Olga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewEx : UIView
{
    BOOL bCheck;
}

@property (strong, nonatomic) UIButton *bOpen;
@property (strong, nonatomic) UITextView *tvTextInside;
@property (strong, nonatomic) UIImageView *imageLine;
@property (weak, nonatomic) NSLayoutConstraint *WitdhConstrain;

-(void)InitData;

@end
