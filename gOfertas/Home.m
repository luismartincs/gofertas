//
//  ViewController.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 29/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "Home.h"
#import "SWRevealViewController.h"

@interface Home ()

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
