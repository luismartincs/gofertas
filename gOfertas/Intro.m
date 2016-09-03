//
//  Intro.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "Intro.h"
#import "Declarations.h"

@interface Intro ()

@end

@implementation Intro

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
   _lblIntro.text = maIntroTitles[_pageIndex];
   _imgIntro.image = [UIImage imageNamed:maIntroImgs[_pageIndex]];
    
    
    if (self.pageIndex == 2) {
        _btnIntro.hidden = NO;
    }
    
}

- (IBAction)goHome:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorial"];

    
}
@end
