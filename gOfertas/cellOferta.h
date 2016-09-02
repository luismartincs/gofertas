//
//  cellOferta.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 30/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellOferta : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *picture;
@property (strong, nonatomic) IBOutlet UIView *content;
@property (strong, nonatomic) IBOutlet UILabel *titulo;
@property (strong, nonatomic) IBOutlet UILabel *precio;
@property (strong, nonatomic) IBOutlet UILabel *lugar;

@property(nonatomic) NSInteger calificacion;
@property(nonatomic,strong) NSMutableArray *stars;

-(void)setCalificacion:(NSInteger)calificacion;

@end
