//
//  OfertasCercanas.m
//  gOfertas
//
//  Created by Luis de Jesus Martin Castillo on 30/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "OfertasCercanas.h"
#import "cellOferta.h"
#import "IconDownloader.h"

@implementation OfertasCercanas

#pragma mark - Web Services

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _ofertas = [[NSArray alloc] init];
    _imageDownloadsInProgress = [NSMutableDictionary dictionary];

}

// -------------------------------------------------------------------------------
//	terminateAllDownloads
// -------------------------------------------------------------------------------
- (void)terminateAllDownloads
{
    // terminate all pending download connections
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [self.imageDownloadsInProgress removeAllObjects];
}

// -------------------------------------------------------------------------------
//	dealloc
//  If this view controller is going away, we need to cancel all outstanding downloads.
// -------------------------------------------------------------------------------
- (void)dealloc
{
    // terminate all pending download connections
    [self terminateAllDownloads];
}

// -------------------------------------------------------------------------------
//	didReceiveMemoryWarning
// -------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // terminate all pending download connections
    [self terminateAllDownloads];
}


-(void)viewWillAppear:(BOOL)animated{
    [self queueLoadData];

     _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_spinner startAnimating];
    _spinner.frame = CGRectMake(0, 20, 320, 44);
    [self.tableView addSubview:_spinner];
    
}

-(void)queueLoadData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[_indicator startAnimating];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadData) object:nil];
    
    [queue addOperation:opGet];
    
    NSInvocationOperation *opDidGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(didLoadData) object:nil];
    
    [opDidGet addDependency:opGet];
    
    [queue addOperation:opDidGet];
    
    
}

-(void)loadData{
    mjsonGeo = [WebServices getOfertasCercanasWithLatitude:_latitude AndLongitude:_longitude];
}

-(void)didLoadData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [_spinner removeFromSuperview];

        ObjectResponse *object  = [Parser parseGeoObject];
        
        _ofertas = object.ofertas;
        
        [self.tableView reloadData];
        
    });
}

#pragma mark - TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_ofertas count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.4];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    
    //Reassure that cell its in its place (WaGo)
    cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView commitAnimations];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cellOferta *cell = (cellOferta*)[tableView dequeueReusableCellWithIdentifier:@"cellOferta"];

    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"cellOferta" bundle:nil] forCellReuseIdentifier:@"cellOferta"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellOferta"];
    }
    
    ObjectOferta *oferta = _ofertas[indexPath.row];
    
    cell.titulo.text = oferta.titulo;
    
    [cell setCalificacion:oferta.calificacion];
    
    if(!oferta.imageSource){
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
        {
            [self startIconDownload:oferta forIndexPath:indexPath];
        }
        // if a download is deferred or in progress, return a placeholder image
        cell.picture.image = [UIImage imageNamed:@"camera.png"];
        
    }else{
        cell.picture.image = oferta.imageSource;
    }
    
    return cell;
    
}


#pragma mark - Table cell image support

// -------------------------------------------------------------------------------
//	startIconDownload:forIndexPath:
// -------------------------------------------------------------------------------
- (void)startIconDownload:(ObjectOferta *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        [iconDownloader setCompletionHandler:^{
            
            cellOferta *cell = (cellOferta*)[self.tableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.picture.image = appRecord.imageSource;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        [iconDownloader startDownload];
    }
}

// -------------------------------------------------------------------------------
//	loadImagesForOnscreenRows
//  This method is used in case the user scrolled into a set of cells that don't
//  have their app icons yet.
// -------------------------------------------------------------------------------
- (void)loadImagesForOnscreenRows
{
    if (self.ofertas.count > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            ObjectOferta *appRecord = _ofertas[indexPath.row];
            
            if (!appRecord.imageSource)
                // Avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:appRecord forIndexPath:indexPath];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}


@end
