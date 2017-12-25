//
//  SHSPhoneTextField.m
//  PhoneComponentExample
//
//  Created by Willy on 18.04.13.
//  Copyright (c) 2013 SHS. All rights reserved.
//

#import "SHSPhoneTextField.h"
#import "SHSPhoneNumberFormatter+UserConfig.h"

@implementation SHSPhoneTextField

-(void) logicInitialization
{
    _formatter = [[SHSPhoneNumberFormatter alloc] init];
    _formatter.textField = self;
    
    logicDelegate = [[SHSPhoneLogic alloc] init];
    
    [super setDelegate:logicDelegate];
    self.keyboardType = UIKeyboardTypeNumberPad;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[/*[[UIBarButtonItem alloc]initWithTitle:@"ЗАКРЫТЬ"
                        style:UIBarButtonItemStyleDone target:self action:@selector(cancelNumberPad)],*/
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"ГОТОВО" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    
    
    [numberToolbar sizeToFit];
    self.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad{
    [self resignFirstResponder];
    self.text = @"+7 (___) ___-__-__";
}

-(void)doneWithNumberPad{
    [self resignFirstResponder];

    NSString *numberFromTheKeyboard = self.text;
    
    if([numberFromTheKeyboard length]<18)
        self.text = @"+7 (___) ___-__-__";

//    [self resignFirstResponder];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self logicInitialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self logicInitialization];
    }
    return self;
}

#pragma mark -
#pragma mark Delegates

-(void) setDelegate:(id<UITextFieldDelegate>)delegate
{
    logicDelegate.delegate = delegate;
}

-(id<UITextFieldDelegate>) delegate
{
    return logicDelegate.delegate;
}

#pragma mark -
#pragma mark Additional Text Setter

-(void) setFormattedText:(NSString *)text
{
    [SHSPhoneLogic applyFormat:self forText:text];
}

-(NSString *) phoneNumber
{
    return [self.formatter digitOnlyString:self.text];
}

-(NSString *)phoneNumberWithoutPrefix
{
    return [self.formatter digitOnlyString:[self.text stringByReplacingOccurrencesOfString:self.formatter.prefix withString:@""]];
}

@end


