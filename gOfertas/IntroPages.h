//
//  IntroPages.h
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 02/09/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroPages:UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic,strong) UIPageViewController *pageViewController;
@property (nonatomic,strong) NSMutableArray *maIntroTitles;
@property (nonatomic,strong) NSMutableArray *maIntroImgs;

@end
