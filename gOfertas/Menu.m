//
//  Menu.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 30/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "Menu.h"
#import "Cuenta.h"
#import "Home.h"
#import "Configuracion.h"
#import "SWRevealViewController.h"

@implementation Menu

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _opciones = [NSArray arrayWithObjects:@"",@"Inicio",@"Cuenta",@"Configuración",@"Acerca De", nil];
    
    _images = [NSArray arrayWithObjects:@"",@"home.png",@"user.png",@"gears.png",@"thumb.png",@"acerca.png", nil];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
    [header setBackgroundColor:[UIColor colorWithRed:1.0 green:149.0/255.0 blue:0.0 alpha:1.0]];
    
    [self.view addSubview:header];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_opciones count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        return 44;
    }else{
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:149.0/255.0 blue:0.0 alpha:1.0];
    }else{
        cell.textLabel.text=_opciones[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
    }

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",
          [self.revealViewController.frontViewController class]);
        
    if(indexPath.row == 1){
    
        Home *c = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];

        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:c];
    
        nav.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:149.0/255.0 blue:0 alpha:1];
        
        nav.navigationBar.tintColor = [UIColor whiteColor];
        
        nav.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        
        [self.revealViewController pushFrontViewController:nav animated:YES];
    
    }else if(indexPath.row == 2){
        
        Cuenta *c = [self.storyboard instantiateViewControllerWithIdentifier:@"Cuenta"];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:c];
    
        nav.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:149.0/255.0 blue:0 alpha:1];
        
        nav.navigationBar.tintColor = [UIColor whiteColor];
        
        nav.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        
        [self.revealViewController pushFrontViewController:nav animated:YES];
    }else if(indexPath.row == 3){
        
        Configuracion *c = [self.storyboard instantiateViewControllerWithIdentifier:@"Configuracion"];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:c];
        
        nav.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:149.0/255.0 blue:0 alpha:1];

        nav.navigationBar.tintColor = [UIColor whiteColor];
        
        nav.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        
        [self.revealViewController pushFrontViewController:nav animated:YES];
    }
    
}

@end
