//
//  Configuracion.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StringPickerList.h"


@interface Configuracion : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) StringPickerList *distanciaPicker;
@property (strong, nonatomic) NSArray *distancias;
@property (strong, nonatomic) NSArray *distanciasLbl;
@property (strong, nonatomic) IBOutlet UILabel *distanciaTxt;
@property (nonatomic,strong) NSArray *categorias;
@property (nonatomic,strong) NSMutableArray *favoritos;

@property (nonatomic) NSInteger distanciaId;
- (IBAction)distancia:(id)sender;

@end
