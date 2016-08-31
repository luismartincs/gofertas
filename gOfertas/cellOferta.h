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

@property(nonatomic) NSInteger calificacion;

@end
