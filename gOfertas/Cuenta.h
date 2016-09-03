//
//  Cuenta.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cuenta : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UILabel *usernameTxt;
@property (strong, nonatomic) IBOutlet UILabel *emailTxt;
- (IBAction)logout:(id)sender;

@end
