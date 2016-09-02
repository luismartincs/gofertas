//
//  OfertasCercanas.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 30/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "Declarations.h"

@interface OfertasCercanas : UITableViewController<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@property (nonatomic,strong) UIActivityIndicatorView *spinner;
@property (nonatomic,strong) NSArray *ofertas;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) ObjectOferta *ofertaSelect;
@property (nonatomic) BOOL hasLoaded;

@end
