//
//  LoadingView.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 01/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

-(id)init{
    
    if(self = [super init]) {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        self.frame = CGRectMake(0, 0, screenWidth,screenHeight);
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _spinner.color = [UIColor whiteColor];
        [_spinner startAnimating];
        _spinner.frame = CGRectMake(0, screenHeight/2, 320, 44);
        
        [self addSubview:_spinner];
    }
    
    return self;
}

@end
