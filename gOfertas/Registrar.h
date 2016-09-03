//
//  Registrar.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"
#import "WebServices.h"
#import "Declarations.h"

@interface Registrar : UIViewController <UITextFieldDelegate>

@property (strong,nonatomic) LoadingView *loadingView;
@property (nonatomic) BOOL userNameValido;
@property (strong, nonatomic) IBOutlet UITextField *usernameTxt;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;
@property (strong, nonatomic) IBOutlet UITextField *password2Txt;

- (IBAction)registrarse:(id)sender;
- (IBAction)cancelar:(id)sender;

@end
