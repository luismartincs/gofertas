//
//  Intro.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Intro : UIViewController

@property (nonatomic) NSInteger pageIndex;
@property (strong, nonatomic) IBOutlet UILabel *lblIntro;
@property (strong, nonatomic) IBOutlet UIImageView *imgIntro;
@property (strong, nonatomic) IBOutlet UIButton *btnIntro;

- (IBAction)goHome:(id)sender;

@end
