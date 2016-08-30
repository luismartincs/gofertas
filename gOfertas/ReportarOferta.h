//
//  ReportarOferta.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 30/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportarOferta : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageOferta;


- (IBAction)cancelar:(id)sender;
- (IBAction)foto:(id)sender;
- (IBAction)seleccionar:(id)sender;

@end
