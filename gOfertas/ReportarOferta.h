//
//  ReportarOferta.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 30/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StringPickerList.h"
#import "WebServices.h"
#import "Declarations.h"

@interface ReportarOferta : UITableViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>


@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;

@property (nonatomic,strong) NSArray *categorias;
@property (nonatomic,strong) NSArray *calificaciones;
@property (nonatomic,strong) NSArray *lugares;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (strong, nonatomic) IBOutlet UIImageView *imageOferta;
@property (strong, nonatomic) IBOutlet UIView *rankingPanel;

@property (strong, nonatomic) IBOutlet UILabel *categoriaLabel;
@property (strong, nonatomic) IBOutlet UILabel *lugarLabel;

@property (strong, nonatomic) StringPickerList *categoriasPicker;
@property (strong, nonatomic) StringPickerList *calificacionPicker;
@property (strong, nonatomic) StringPickerList *lugaresPicker;

@property (nonatomic) NSInteger categoriaId;
@property (nonatomic) NSInteger selectedCatId;
@property (nonatomic) NSInteger calificacionId;
@property (nonatomic) NSInteger calificacion;

@property (nonatomic) NSInteger lugarId;
@property (nonatomic) NSInteger lugar;

@property (strong, nonatomic) IBOutlet UITextField *ofertaTxt;
@property (strong, nonatomic) IBOutlet UITextField *precioTxt;
@property (strong, nonatomic) IBOutlet UISegmentedControl *nacionalChoose;
@property (strong, nonatomic) IBOutlet UITextField *urlTxt;
@property (strong, nonatomic) IBOutlet UITextView *descripcionTxt;

- (IBAction)cancelar:(id)sender;
- (IBAction)foto:(id)sender;
- (IBAction)seleccionar:(id)sender;
- (IBAction)categoria:(id)sender;
- (IBAction)califica:(id)sender;
- (IBAction)lugar:(id)sender;
- (IBAction)reportar:(id)sender;

@end
