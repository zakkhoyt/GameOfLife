//
//  VWWCGViewController.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWCGViewController.h"
#import "VWWCGView.h"
#import "VWWGOLPhysics.h"

//#define WIDTH 20
//#define HEIGHT 20
static NSInteger kGOLWidth = 100;
static NSInteger kGOLHeight = 100;


static float kInitialFrequency = 0.1;

@interface VWWCGViewController ()<VWWGOLPhysicsDelegate>
@property (nonatomic, strong) VWWGOLPhysics *physics;
@property (strong, nonatomic) IBOutlet VWWCGView *cgView;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *generateButton;
@property (strong, nonatomic) IBOutlet UISlider *frequencySlider;
@property (nonatomic) float generateFrequency;
@end

@implementation VWWCGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.physics = [[VWWGOLPhysics alloc]initWithWidth:kGOLWidth height:kGOLHeight];
    self.physics.delegate = self;
    self.generateFrequency = kInitialFrequency;
    self.frequencySlider.value = self.generateFrequency;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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


- (IBAction)generateButtonTouchUpInside:(id)sender {
    [self.physics killAllCells];
    
    NSInteger t = self.physics.width * self.physics.height;
    NSInteger requiredCellCount = t * self.generateFrequency;
    
    while(self.physics.cells.count < requiredCellCount){
        // generate a cell at random and insert it
//        NSInteger index = random()%t;
        NSInteger index = arc4random()%t;
        NSInteger y = index / self.physics.width;
        NSInteger x = index - self.physics.width * y;
        VWWGOLCell *newCell = [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:YES];
        [self.physics addCell:newCell];
    }
    
    [self renderCells];
    
    NSLog(@"added %d cells. Actual count:%d", requiredCellCount, self.physics.cells.count);
}

- (IBAction)frequencySliderValueChanged:(UISlider*)sender {
    self.generateFrequency = sender.value;
//    NSLog(@"changed generate frequency to %f", self.generateFrequency);
}


#pragma mark Implements VWWGOLPhysicsDelegate
-(void)renderCells{

    self.cgView.physics = self.physics;
    [self.cgView setNeedsDisplay];
    
    if(self.physics.cells.count == 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"DEAD!" message:@"All cells died. Lame." delegate:nil cancelButtonTitle:@"alright" otherButtonTitles:nil, nil];
        [alert show];
        [self startButtonTouchUpInside:nil];
    }
}

@end
