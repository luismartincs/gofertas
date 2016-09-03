//
//  ReportarOferta.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 30/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "ReportarOferta.h"
#import "AgregarLugar.h"

@implementation ReportarOferta


-(void)viewDidLoad{
    [super viewDidLoad];
    [self config];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [self queueLoadData];
}

-(void)config{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    /*
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    */
    _categorias = [NSArray arrayWithObjects: @"Abarrotes y alimentos",@"Autos",@"Bebés y Niños",@"Celulares",@"Restaurantes",@"Computadoras",@"Deportes y Ejercicio",@"Entretenimiento",@"Hogar y Jardín",@"Ropa y accesorios",@"Salud y Belleza",@"Servicios",@"Tecnología",@"Televisiones",@"Viajes",@"Videojuegos",nil];
    
    _calificaciones = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
    _selectedCatId = 0;
    _calificacion = 5;
    
    _loadingView = [[LoadingView alloc] init];
    
    [self refreshCalificaciones];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - Web Services

-(void)queueSubirFoto{
    [self dismissKeyboard];
    
    [self.navigationController.view addSubview:_loadingView];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadFoto) object:nil];
    
    [queue addOperation:opGet];
    
    NSInvocationOperation *opDidGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(didLoadFoto) object:nil];
    
    [opDidGet addDependency:opGet];
    
    [queue addOperation:opDidGet];
    
}

-(void)loadFoto{
    
    UIImage *reduced = [self resizeImage:_imageOferta.image];
    _base64 = [UIImagePNGRepresentation(reduced) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
   
    mjsonGeo = [WebServices subirFoto:_base64 andName:_ofertaObject.foto];
}

-(void)didLoadFoto{
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        ObjectResponse *object  = [Parser parseGeoObject];
        
        if([object.state isEqualToString:@"SUCCESS POST IMAGE"]){
            
            [self queueReportar];
            
        }else{
            [AlertProvider showMessage:object.message andTitle:ERROR inController:self];
            
            [_loadingView removeFromSuperview];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        }

        
    });
}


-(void)queueLoadData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadData) object:nil];
    
    [queue addOperation:opGet];
    
    NSInvocationOperation *opDidGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(didLoadData) object:nil];
    
    [opDidGet addDependency:opGet];
    
    [queue addOperation:opDidGet];
    
}

-(void)loadData{
    mjsonGeo = [WebServices getLugaresCercanosWithLatitude:_latitude AndLongitude:_longitude];
}

-(void)didLoadData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        ObjectResponse *object  = [Parser parseGeoObject];
        
        _lugares = object.stores;
        
        for (ObjectLugar *lugar in object.stores) {
            print(NSLog(@"%li %@",(long)lugar.storeid,lugar.name))
        }
        
        
    });
}

-(void)queueReportar{
    
    [self dismissKeyboard];
    
    [self.navigationController.view addSubview:_loadingView];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(wsAddReporte) object:nil];
    
    [queue addOperation:opGet];
    
    NSInvocationOperation *opDidGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(didReportar) object:nil];
    
    [opDidGet addDependency:opGet];
    
    [queue addOperation:opDidGet];
    
}

-(void)wsAddReporte{
    mjsonGeo = [WebServices reportarOferta:_ofertaObject];
}

-(void)didReportar{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
       [_loadingView removeFromSuperview];
        
        ObjectResponse *object  = [Parser parseGeoObject];
        
        if([object.state isEqualToString:@"SUCCESS POST"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESH_HOME" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            print(NSLog(@"ERROR %@",object.message))
        }
        
    });
}

//=======


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

- (IBAction)lugar:(id)sender {
    
    [self.view endEditing:YES];
    
    _lugaresPicker = [[StringPickerList alloc] initWithDelegate:self andTarget:@selector(lugarAccept)];
    
    [_lugaresPicker showInView:self.navigationController.view];
}

- (IBAction)reportar:(id)sender {
    
    
    ObjectLugar *lugarObj = (ObjectLugar*)_lugares[_lugar];
    NSInteger lugId = lugarObj.storeid;
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"userid"] ;

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *formatString = @"yyyyMMddHHmmssSSS";
    [formatter setDateFormat:formatString];
    NSString *ff = [formatter stringFromDate:[NSDate date]];
    
    NSString *picName = [NSString stringWithFormat:@"USR_%i_IMG_%@.JPG",uid,ff];

    
    print(NSLog(@"%@",_ofertaTxt.text))
    print(NSLog(@"%@",_descripcionTxt.text))
    print(NSLog(@"%@",_precioTxt.text))
    print(NSLog(@"%i",_calificacion))
    print(NSLog(@"%i",_categoriaId+1))
    print(NSLog(@"%f",[_latitude doubleValue]))
    print(NSLog(@"%f",[_longitude doubleValue]))
    print(NSLog(@"%i",!_nacionalChoose.selectedSegmentIndex))
    print(NSLog(@"%i",lugId))
    print(NSLog(@"%i",uid))
    
    if ([_ofertaTxt.text isEqualToString:@""] || [_precioTxt.text isEqualToString:@""] || [_descripcionTxt.text isEqualToString:@""]) {
        [AlertProvider showMessage:CAMPO_VACIO andTitle:ERROR inController:self];
        return;
    }
    
    
    _ofertaObject = [[ObjectOferta alloc] init];
    
    _ofertaObject.titulo = _ofertaTxt.text;
    _ofertaObject.descripcion = _descripcionTxt.text;
    _ofertaObject.precio = [_precioTxt.text doubleValue];
    _ofertaObject.url = _urlTxt.text;
    _ofertaObject.calificacion = _calificacion;
    _ofertaObject.categoriaid = _categoriaId+1;
    _ofertaObject.tiendaid = lugId;
    _ofertaObject.latitud = lugarObj.latitud;
    _ofertaObject.longitud= lugarObj.longitud;
    _ofertaObject.esLocal = !_nacionalChoose.selectedSegmentIndex;
    _ofertaObject.usuarioid = uid;
    _ofertaObject.foto = picName;

    [self queueSubirFoto];
    

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.imageOferta.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(UIImage *)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 480.0;
    float maxWidth = 640.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - Picker View

-(void)accept{
    _selectedCatId = _categoriaId;
    _categoriaLabel.text = _categorias[_selectedCatId];
    [_categoriasPicker close];
}

-(void)calificar{
    _calificacion = [_calificaciones[_calificacionId] integerValue];
    [self refreshCalificaciones];
    [_calificacionPicker close];
}

-(void)lugarAccept{
    _lugar = _lugarId;
    _lugarLabel.text = ((ObjectLugar*)_lugares[_lugar]).name;
    [_lugaresPicker close];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(pickerView == _categoriasPicker.pickerView){
        _categoriaId = row;
    }else if(pickerView == _calificacionPicker.pickerView){
        _calificacionId = row;
    }else if(pickerView == _lugaresPicker.pickerView){
        _lugarId = row;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if(pickerView == _categoriasPicker.pickerView){
        
        return [_categorias count];
        
    }else if(pickerView == _calificacionPicker.pickerView){
        return [_calificaciones count];
        
    }else if(pickerView == _lugaresPicker.pickerView){
        return [_lugares count];
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

    }else if(pickerView == _lugaresPicker.pickerView){
        return ((ObjectLugar*)_lugares[row]).name;
    }else{
        return @"";
    }
    
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    
    UITableViewCell *cell = (UITableViewCell *)[textField.superview superview];
    
    _indexPath = [self.tableView indexPathForCell:cell];

}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    UITableViewCell *cell = (UITableViewCell *)[textView.superview superview];
    
    _indexPath = [self.tableView indexPathForCell:cell];
    print(NSLog(@"textf %i",_indexPath.row))

}

#pragma mark - Keyboard Events

- (void)keyboardWillShow:(NSNotification *)notification
{
    print(NSLog(@"willshow %i",_indexPath.row))

    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
    [self.tableView scrollToRowAtIndexPath:_indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    print(NSLog(@"close %i",_indexPath.row))

}

#pragma mark -segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.destinationViewController isKindOfClass:[AgregarLugar class]]){
        
        AgregarLugar *destination = [segue destinationViewController];
        
        destination.latitude = _latitude;
        destination.longitude = _longitude;
        
    }
}


@end
