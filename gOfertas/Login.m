//
//  Login.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "Login.h"
#import "SWRevealViewController.h"

@interface Login ()

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    _loadingView = [[LoadingView alloc] init];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)login:(id)sender {
    
    if(![_usernameTxt.text isEqualToString:@""] || ![_passwordTxt.text isEqualToString:@""]){
        [self queueLoadData];
    }else{
        [AlertProvider showMessage:CAMPO_VACIO andTitle:ERROR inController:self];
        return;
    }

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
    mjsonGeo = [WebServices loginWithUser:_usernameTxt.text andPassword:_passwordTxt.text];
}

-(void)didLoadData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        ObjectUsuario *object  = [Parser parseUsuario];
        
        if([object.state isEqualToString:@"empty"]){
            
            [AlertProvider showMessage:object.message andTitle:ERROR inController:self];

        }else{
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"tutorial"];

            [[NSUserDefaults standardUserDefaults] setValue:_usernameTxt.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setValue:_passwordTxt.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setValue:object.email forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setInteger:object.usuarioid forKey:@"userid"];
            [[NSUserDefaults standardUserDefaults] setInteger:500 forKey:@"radio"];
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"distanciaId"];
             NSMutableArray *favoritos = [NSMutableArray arrayWithObjects: @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
            [[NSUserDefaults standardUserDefaults] setObject:favoritos forKey:@"favoritos"];
            
            
            SWRevealViewController *main = [self.storyboard instantiateViewControllerWithIdentifier:@"Reveal"];
            
            [self presentViewController:main animated:YES completion:nil];

        }
        
        
        
        [_loadingView removeFromSuperview];
        
    });
}
@end
