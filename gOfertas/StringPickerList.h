//
//  StringPickerList.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 31/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StringPickerList : UIView

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *pickerBack;
@property (strong, nonatomic) UIPickerView *pickerView;

-(id)initWithDelegate:(id)delegate andTarget:(SEL)selector;

-(void)showInView:(UIView*)view;
-(void)close;

@end
