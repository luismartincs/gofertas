//
//  ReportarOferta.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 30/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StringPickerList.h"

@interface ReportarOferta : UITableViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate>


@property (nonatomic,strong) NSArray *categorias;
@property (nonatomic,strong) NSArray *calificaciones;

@property (strong, nonatomic) IBOutlet UIImageView *imageOferta;
@property (strong, nonatomic) IBOutlet UIView *rankingPanel;

@property (strong, nonatomic) IBOutlet UIButton *categoriaButton;
@property (strong, nonatomic) StringPickerList *categoriasPicker;
@property (strong, nonatomic) StringPickerList *calificacionPicker;
@property (nonatomic) NSInteger categoriaId;
@property (nonatomic) NSInteger selectedCatId;
@property (nonatomic) NSInteger calificacionId;
@property (nonatomic) NSInteger calificacion;


- (IBAction)cancelar:(id)sender;
- (IBAction)foto:(id)sender;
- (IBAction)seleccionar:(id)sender;
- (IBAction)categoria:(id)sender;
- (IBAction)califica:(id)sender;

@end
