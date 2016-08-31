//
//  StringPickerList.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 31/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "StringPickerList.h"

@implementation StringPickerList

-(id)initWithDelegate:(id)delegate andTarget:(SEL)selector{
    
    if(self = [super init]) {
        
        UIView *backView = [[UIView alloc] init];
        UIView *window = [[UIView alloc] init];

        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        self.frame = CGRectMake(0, 0, screenWidth,screenHeight);
        
        backView.frame = self.frame;
        
        window.frame = CGRectMake(0, screenHeight-250, screenWidth, 250);
        window.backgroundColor = [UIColor whiteColor];
        
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.5;
        
        UIButton *cancel = [[UIButton alloc] init];
        cancel.frame = CGRectMake(10, 0, 40, 40);
        cancel.backgroundColor = [UIColor lightGrayColor];
        
        [cancel setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *choose = [[UIButton alloc] init];
        choose.frame = CGRectMake(screenWidth-50, 0, 40, 40);
        choose.backgroundColor = [UIColor lightGrayColor];
        
        [choose setImage:[UIImage imageNamed:@"ok.png"] forState:UIControlStateNormal];
        [choose addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,40,screenWidth,200)];
        //_categoriasPicker.backgroundColor = [UIColor redColor];
        
        [_pickerView setDataSource: delegate];
        [_pickerView setDelegate: delegate];
        _pickerView.showsSelectionIndicator = YES;
        
        [self addSubview:backView];
        [self addSubview:window];
        
        [window addSubview:cancel];
        [window addSubview:choose];
        [window addSubview:_pickerView];
        
        self.backView = backView;
        self.pickerBack = window;
        
        self.pickerBack.alpha = 0;
        self.backView.alpha = 0;
        
    }
    
    return  self;
}

-(void)showInView:(UIView*)view{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;

    
    self.backView.alpha = 0.5;
    
    [view addSubview:self];
    
    self.pickerBack.alpha = 0;
    self.pickerBack.frame = CGRectMake(0,screenHeight,self.pickerBack.frame.size.width, self.pickerBack.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.pickerBack.alpha = 1;
    self.pickerBack.frame = CGRectMake(0,screenHeight-250,self.pickerBack.frame.size.width, self.pickerBack.frame.size.height);
    [UIView commitAnimations];
    
}

-(void)close{
    [self removeFromSuperview];
}

@end
