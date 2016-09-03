//
//  Configuracion.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "Configuracion.h"
#import "SWRevealViewController.h"
#import "Declarations.h"

@interface Configuracion ()

@end

@implementation Configuracion

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    _distanciasLbl = [NSArray arrayWithObjects:@"500m",@"1Km",@"2Km",@"5Km",@"10Km", nil];
    _distancias = [NSArray arrayWithObjects:@"500",@"1000",@"2000",@"5000",@"10000", nil];
    
    _categorias = [NSArray arrayWithObjects: @"Abarrotes y alimentos",@"Autos",@"Bebés y Niños",@"Celulares",@"Restaurantes",@"Computadoras",@"Deportes y Ejercicio",@"Entretenimiento",@"Hogar y Jardín",@"Ropa y accesorios",@"Salud y Belleza",@"Servicios",@"Tecnología",@"Televisiones",@"Viajes",@"Videojuegos",nil];
    
    _favoritos = [NSMutableArray arrayWithObjects: @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    
    _distanciaId = [[NSUserDefaults standardUserDefaults] integerForKey:@"distanciaId"];
    
    _favoritos = (NSMutableArray*)[[[NSUserDefaults standardUserDefaults] objectForKey:@"favoritos"] mutableCopy];
    
    _distanciaTxt.text = _distanciasLbl[_distanciaId];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_categorias count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
 
    cell.textLabel.text = _categorias[indexPath.row];
    
    if([_favoritos[indexPath.row] integerValue]==0){
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }else{
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([_favoritos[indexPath.row] integerValue]==0){
        _favoritos[indexPath.row] = @"1";

        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    }else{
        _favoritos[indexPath.row] = @"0";
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];

    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:_favoritos forKey:@"favoritos"];
    
    NSLog(@"%@",_favoritos);
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _distanciaId = row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_distanciasLbl count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return _distanciasLbl[row];
    
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

- (IBAction)distancia:(id)sender {
    
    _distanciaPicker = [[StringPickerList alloc] initWithDelegate:self andTarget:@selector(seleccionar)];
    
    [_distanciaPicker showInView:self.navigationController.view];
}

-(void)seleccionar{
    _distanciaTxt.text = _distanciasLbl[_distanciaId];
    [_distanciaPicker close];
    
    [[NSUserDefaults standardUserDefaults] setInteger:[_distancias[_distanciaId] integerValue] forKey:@"radio"];
    [[NSUserDefaults standardUserDefaults] setInteger:_distanciaId forKey:@"distanciaId"];

}
@end
