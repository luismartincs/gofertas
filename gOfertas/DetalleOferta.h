//
//  DetalleOferta.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "Declarations.h"
#import "LoadingView.h"

@interface DetalleOferta : UITableViewController

@property (strong,nonatomic) LoadingView *loadingView;

@property (nonatomic) NSUInteger ofertaid;
@property (strong, nonatomic) IBOutlet UILabel *categoriaTxt;
@property (strong, nonatomic) IBOutlet UILabel *ofertaTxt;
@property (strong, nonatomic) IBOutlet UILabel *lugarTxt;
@property (strong, nonatomic) IBOutlet UILabel *precioTxt;
@property (strong, nonatomic) IBOutlet UILabel *nacionalTxt;
@property (strong, nonatomic) IBOutlet UILabel *urlTxt;
@property (strong, nonatomic) IBOutlet UITextView *descripcionTxt;
@property (strong, nonatomic) IBOutlet UIView *rankContainer;
@property (strong, nonatomic) IBOutlet UIImageView *imagen;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
