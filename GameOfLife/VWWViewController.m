//
//  VWWViewController.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWViewController.h"
#import "VWWCollectionViewCell.h"
#import "VWWGOLPhysics.h"
#import "VWWGOLCell.h"
#import "VWWCollectionViewFlowLayout.h"

#define WIDTH 20
#define HEIGHT 20



@interface VWWViewController () <VWWGOLPhysicsDelegate>
@property (nonatomic, strong) VWWGOLPhysics *physics;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, strong) VWWCollectionViewFlowLayout *flowLayout;
@end

@implementation VWWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.flowLayout = [[VWWCollectionViewFlowLayout alloc]init];
    self.collectionView.collectionViewLayout = self.flowLayout;
    self.physics = [[VWWGOLPhysics alloc]initWithWidth:WIDTH height:HEIGHT];
    self.physics.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    
    [self.collectionView reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"segueMainToDetail"]){
//        VWWDetailViewController *vc = segue.destinationViewController;
//        vc.colors = self.colors;
//    }
//}







#pragma mark IBActions

- (IBAction)startButtonTouchUpInside:(id)sender {
    if(self.physics.running == NO){
        [self.physics start];
        [self.startButton  setTitle:@"Stop" forState:UIControlStateNormal];
    }
    else{
        [self.physics stop];
        [self.startButton  setTitle:@"Evolve!" forState:UIControlStateNormal];
    }
    
}


#pragma mark UICollectionViewDatasource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.physics.width * self.physics.height;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VWWCollectionViewCell *cell = (VWWCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"VWWCollectionViewCell" forIndexPath:indexPath];
    VWWGOLCell *golCell = [self.physics cellAtIndex:indexPath.item];
    if(golCell){
        cell.backgroundColor = golCell.color;
    }
    else{
        cell.backgroundColor = [UIColor blackColor];
    }
    
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger x = 0, y = 0;
    x = indexPath.item / self.physics.width;
    y = indexPath.item - x * self.physics.width;
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:YES];
    
    if([self.physics addCell:cell]){
        [self.collectionView reloadData];
    }
}

#pragma mark UICollectionViewLayout

- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout*)cvl sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize retval = CGSizeZero;
//    NSLog(@"frame=%@", NSStringFromCGRect(self.collectionView.frame));
    CGFloat contentWidth = (self.collectionView.frame.size.width - (self.physics.width - 1) * 2);
    CGFloat width = contentWidth / self.physics.width;
//    CGFloat width = self.collectionView.frame.size.width / (float)self.physics.width;
//    CGFloat width = 22;
    retval = CGSizeMake(width, width);
    return retval;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout*)cvl insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsZero;
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



//- (CGFloat)collectionView:(UICollectionView *)collectionView
//                    ayout:(UICollectionViewLayout*)collectionViewLayout
//minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0; // This is the minimum inter item spacing, can be more
//}

#pragma makr Implements VWWGOLPhysicsDelegate
-(void)renderCells{
    
    [self.collectionView reloadData];
    
    if(self.physics.cells.count == 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"DEAD!" message:@"All cells died. Lame." delegate:nil cancelButtonTitle:@"alright" otherButtonTitles:nil, nil];
        [alert show];
        [self startButtonTouchUpInside:nil];
    }
}

@end
