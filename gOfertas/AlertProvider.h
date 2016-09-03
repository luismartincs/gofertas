//
//  AlertProvider.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertProvider : NSObject

+(void)showMessage:(NSString*)message andTitle:(NSString*)title inController:(UIViewController*)controller;
+(void)showMessage:(NSString*)message andTitle:(NSString*)title inController:(UIViewController*)controller andHide:(BOOL)hide;

@end
