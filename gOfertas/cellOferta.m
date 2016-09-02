//
//  cellOferta.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 30/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "cellOferta.h"
#import "Declarations.h"

@implementation cellOferta

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(-10, 10);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;

    _stars = [[NSMutableArray alloc] init];
    
    UIImage *star = [UIImage imageNamed:@"star.png"];
    UIImage *starg = [UIImage imageNamed:@"starg.png"];

    for (int i=0; i < 5; i++) {
        
        UIImageView *starv = [[UIImageView alloc] init];

        
        if(i < _calificacion){
            starv.image = star;
        }else{
            starv.image = starg;
        }
        
        starv.frame = CGRectMake(115+(20*i),87, 20, 20);
        
        [_stars addObject:starv];
        
        [_content addSubview:starv];
        
    }
    
    
}

-(void)setCalificacion:(NSInteger)calificacion{
    
    _calificacion = calificacion;
    
    print(NSLog(@"Calificacion %i",calificacion))
    
    UIImage *star = [UIImage imageNamed:@"star.png"];
    UIImage *starg = [UIImage imageNamed:@"starg.png"];
    
    for (int i=0; i < 5; i++) {
        
        UIImageView *starv = _stars[i];
        
        
        if(i < calificacion){
            starv.image = star;
        }else{
            starv.image = starg;
        }
        
        //starv.frame = CGRectMake(115+(20*i),87, 20, 20);
        
        //[_stars addObject:starv];
        
        //[_content addSubview:starv];
        
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
