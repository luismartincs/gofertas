//
//  Registrar.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "Registrar.h"
#import "Declarations.h"
#import "NSString+ExtendedString.h"
#import "SWRevealViewController.h"

@interface Registrar ()

@end

@implementation Registrar

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    _loadingView = [[LoadingView alloc] init];
    _userNameValido = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self queueLoadData];
}

#pragma mark - web

-(void)queueLoadData{
    [self dismissKeyboard];
    [self.view addSubview:_loadingView];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[_indicator startAnimating];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadData) object:nil];
    
    [queue addOperation:opGet];
    
    NSInvocationOperation *opDidGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(didLoadData) object:nil];
    
    [opDidGet addDependency:opGet];
    
    [queue addOperation:opDidGet];
    
    
}

-(void)loadData{
    mjsonGeo = [WebServices checkUser:_usernameTxt.text];
}

-(void)didLoadData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        ObjectUsuario *object  = [Parser parseUsuario];
        
        if([object.state isEqualToString:@"empty"]){
            _usernameTxt.textColor = [UIColor whiteColor];
            _userNameValido = YES;

        }else{
            _usernameTxt.textColor = [UIColor redColor];
            _userNameValido = NO;
            [AlertProvider showMessage:object.message andTitle:ERROR inController:self];
        }
        
        [_loadingView removeFromSuperview];
        
    });
}


-(void)queueRegistrar{
    [self dismissKeyboard];
    [self.view addSubview:_loadingView];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[_indicator startAnimating];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadRegistrar) object:nil];
    
    [queue addOperation:opGet];
    
    NSInvocationOperation *opDidGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(didRegistrar) object:nil];
    
    [opDidGet addDependency:opGet];
    
    [queue addOperation:opDidGet];
    
    
}

-(void)loadRegistrar{
    mjsonGeo = [WebServices registrarWithUser:_usernameTxt.text AndEmail:_emailTxt.text AndPassword:_passwordTxt.text];
}

-(void)didRegistrar{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        ObjectUsuario *object  = [Parser parseUsuario];
        
        if([object.state isEqualToString:@"SUCCESS POST"]){
            
            [AlertProvider showMessage:object.message andTitle:REGISTRO_USUARIO inController:self andHide:YES];

            
        }else{
            [AlertProvider showMessage:object.message andTitle:ERROR inController:self];
        }
        
        [_loadingView removeFromSuperview];
        
    });
}


- (IBAction)registrarse:(id)sender {
    [self dismissKeyboard];
    
    if ([_usernameTxt.text isEqualToString:@""] || [_emailTxt.text isEqualToString:@""] || [_passwordTxt.text isEqualToString:@""] || [_password2Txt.text isEqualToString:@""]) {
        [AlertProvider showMessage:CAMPO_VACIO andTitle:ERROR inController:self];
        return;
    }else if(![_passwordTxt.text isEqualToString:_password2Txt.text]){
        [AlertProvider showMessage:PASSWORD_IGUALES andTitle:ERROR inController:self];
        return;
    }else if(![_emailTxt.text isValidEmail]){
        [AlertProvider showMessage:EMAIL_INCORRECTO andTitle:ERROR inController:self];
        return;
    }else if(!_userNameValido){
        [AlertProvider showMessage:USERNAME_INVALIDO andTitle:ERROR inController:self];

    }else{
        [self queueRegistrar];
    }
    
}

- (IBAction)cancelar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
