//
//  VWWCGLifeViewController.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWCGLifeViewController.h"
#import "VWWCGLifeView.h"
#import "VWWGOLLife.h"

@interface VWWCGLifeViewController ()

@end


//#define WIDTH 20
//#define HEIGHT 20
static NSInteger kGOLWidth = 64;
static NSInteger kGOLHeight = 92;

//static NSInteger kGOLWidth = 200;
//static NSInteger kGOLHeight = 200;

//static NSInteger kGOLWidth = 320;
//static NSInteger kGOLHeight = 320;


static float kInitialFrequency = 0.1;

@interface VWWCGLifeViewController ()<VWWGOLLifeDelegate>
@property (nonatomic, strong) VWWGOLLife *life;
@property (strong, nonatomic) IBOutlet VWWCGLifeView *cgLifeView;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *generateButton;
@property (strong, nonatomic) IBOutlet UISlider *frequencySlider;
@property (nonatomic) float generateFrequency;
@end

@implementation VWWCGLifeViewController

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
    self.life = [[VWWGOLLife alloc]initWithWidth:kGOLWidth height:kGOLHeight];
    self.life.delegate = self;
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
    if(self.life.running == NO){
        [self.life start];
        [self.startButton  setTitle:@"Stop" forState:UIControlStateNormal];
    }
    else{
        [self.life stop];
        [self.startButton  setTitle:@"Evolve!" forState:UIControlStateNormal];
    }
    
}


- (IBAction)generateButtonTouchUpInside:(id)sender {
    [self.life killAllCells];
    
    NSInteger t = self.life.width * self.life.height;
    NSInteger requiredCellCount = t * self.generateFrequency;
    
    while(self.life.cells.count < requiredCellCount){
        // generate a cell at random and insert it
        //        NSInteger index = random()%t;
        NSInteger index = arc4random()%t;
        NSInteger y = index / self.life.width;
        NSInteger x = index - self.life.width * y;
        VWWGOLCell *newCell = [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:YES];
        [self.life addCell:newCell];
    }
    
    [self renderCells];
    
    NSLog(@"added %d cells. Actual count:%d", requiredCellCount, self.life.cells.count);
}

- (IBAction)frequencySliderValueChanged:(UISlider*)sender {
    self.generateFrequency = sender.value;
    //    NSLog(@"changed generate frequency to %f", self.generateFrequency);
}

- (IBAction)oneGenerationButtonTouchUpInside:(id)sender {
    [self.life processTimer];
}

#pragma mark Implements VWWGOLLifeDelegate
-(void)renderCells{
    
    self.cgLifeView.life = self.life;
    [self.cgLifeView setNeedsDisplay];
    
    if(self.life.cells.count == 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"DEAD!" message:@"All cells died. Lame." delegate:nil cancelButtonTitle:@"alright" otherButtonTitles:nil, nil];
        [alert show];
        [self startButtonTouchUpInside:nil];
    }
}

@end
