//
//  ReportarOferta.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 30/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "ReportarOferta.h"

@implementation ReportarOferta


-(void)viewDidLoad{
    [super viewDidLoad];
    [self config];
}

-(void)config{
    
    _categorias = [NSArray arrayWithObjects: @"Abarrotes y alimentos",@"Autos",@"Bebés y Niños",@"Celulares",@"Restaurantes",@"Computadoras",@"Deportes y Ejercicio",@"Entretenimiento",@"Hogar y Jardín",@"Ropa y accesorios",@"Salud y Belleza",@"Servicios",@"Tecnología",@"Televisiones",@"Viajes",@"Videojuegos",nil];
    
    _calificaciones = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
    _selectedCatId = 0;
    _calificacion = 5;
    
    [self refreshCalificaciones];
}

-(void)refreshCalificaciones{
    
    for (UIView *v in _rankingPanel.subviews) {
        [v removeFromSuperview];
    }
    
    UIImage *star = [UIImage imageNamed:@"star.png"];
    UIImage *starg = [UIImage imageNamed:@"starg.png"];
    
    for (int i=0; i < 5; i++) {
        
        UIImageView *starv = [[UIImageView alloc] init];
        
        
        if(i < _calificacion){
            starv.image = star;
        }else{
            starv.image = starg;
        }
        
        starv.frame = CGRectMake(0+(20*i),0, 20, 20);
        
        [_rankingPanel addSubview:starv];
        
    }
    
}

- (IBAction)cancelar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)foto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)seleccionar:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)categoria:(id)sender {
    
    [self.view endEditing:YES];
    
    _categoriasPicker = [[StringPickerList alloc] initWithDelegate:self andTarget:@selector(accept)];
    
    [_categoriasPicker showInView:self.navigationController.view];
    
}

- (IBAction)califica:(id)sender {
    
    [self.view endEditing:YES];
    
    _calificacionPicker = [[StringPickerList alloc] initWithDelegate:self andTarget:@selector(calificar)];
    
    [_calificacionPicker showInView:self.navigationController.view];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.imageOferta.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - Picker View

-(void)accept{
    _selectedCatId = _categoriaId;
    _categoriaButton.titleLabel.text = _categorias[_selectedCatId];
    [_categoriasPicker close];
}

-(void)calificar{
    _calificacion = [_calificaciones[_calificacionId] integerValue];
    [self refreshCalificaciones];
    [_calificacionPicker close];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(pickerView == _categoriasPicker.pickerView){
        _categoriaId = row;
    }else if(pickerView == _calificacionPicker.pickerView){
        _calificacionId = row;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView == _categoriasPicker.pickerView){
        
        return [_categorias count];
        
    }else if(pickerView == _calificacionPicker.pickerView){
        return [_calificaciones count];
        
    }else{
        return 1;
    }
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if(pickerView == _categoriasPicker.pickerView){
    
        return _categorias[row];
        
    }else if(pickerView == _calificacionPicker.pickerView){
        return _calificaciones[row];

    }else{
        return @"";
    }
    
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

@end
