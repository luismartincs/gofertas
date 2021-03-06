//
//  Cuenta.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "Cuenta.h"
#import "SWRevealViewController.h"

@interface Cuenta ()

@end

@implementation Cuenta

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    _usernameTxt.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    _emailTxt.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logout:(id)sender {
    
    SWRevealViewController *main = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    
    [self presentViewController:main animated:YES completion:nil];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"logged"];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"email"];
}
@end
