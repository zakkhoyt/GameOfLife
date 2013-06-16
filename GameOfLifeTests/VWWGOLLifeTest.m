//
//  VWWGOLLifeTest.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VWWGOLLIfe.h"


@interface VWWGOLLifeTest : XCTestCase
@property (nonatomic, strong) VWWGOLLife *life;
@end

@implementation VWWGOLLifeTest

- (void)setUp
{
    [super setUp];
    self.life = [[VWWGOLLife alloc]initWithWidth:10 height:10];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

//Any live cell with fewer than two live neighbours dies, as if caused by under-population.
// xxxxx
// x1xxx
// x02xx
// xxxxx
// xxxxx
- (void)testRule1a
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    XCTAssertTrue([self.life cellPassesRule1:cell], @"failed to pass test for rule 1");
}

//Any live cell with fewer than two live neighbours dies, as if caused by under-population.
// xxxxx
// x1xxx
// x0xxx
// xxxxx
// xxxxx
- (void)testRule1b
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    XCTAssertFalse([self.life cellPassesRule1:cell], @"failed to pass test for rule 1");
}

//Any live cell with fewer than two live neighbours dies, as if caused by under-population.
// xxxxx
// xxxxx
// x0xxx
// xxxxx
// xxxxx
- (void)testRule1c
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    XCTAssertFalse([self.life cellPassesRule1:cell], @"failed to pass test for rule 1");
}


//Any live cell with two or three live neighbours lives on to the next generation.
// xxxxx
// x1xxx
// x02xx
// xxxxx
// xxxxx

- (void)testRule2a
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2");
}

//Any live cell with two or three live neighbours lives on to the next generation.
// xxxxx
// x1xxx
// 302xx
// xxxxx
// xxxxx
- (void)testRule2b
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2");
}


//Any live cell with two or three live neighbours lives on to the next generation.
// xxxxx
// x1xxx
// 302xx
// x4xxx
// xxxxx
- (void)testRule2c
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:2 andY:4 alive:YES];
    [self.life addCell:cell4];
    
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2");
}










//Any live cell with more than three live neighbours dies, as if by overcrowding.
// xxxxx
// x1xxx
// 302xx
// x4xxx
// xxxxx
- (void)testRule3a
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:2 andY:4 alive:YES];
    [self.life addCell:cell4];
    
    
    XCTAssertFalse([self.life cellPassesRule3:cell], @"failed to pass test for rule 3");
}


//Any live cell with more than three live neighbours dies, as if by overcrowding.
// xxxxx
// x1xxx
// 302xx
// xxxxx
// xxxxx
- (void)testRule3b
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    
    XCTAssertTrue([self.life cellPassesRule3:cell], @"failed to pass test for rule 3");
}

//Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
// xxxxx
// x1xxx
// 302xx
// x4xxx
// xxxxx
- (void)testRule4a
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:2 andY:4 alive:YES];
    [self.life addCell:cell4];
    
    
    XCTAssertFalse([self.life cellPassesRule4:cell], @"failed to pass test for rule 4");
}



//Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
// xxxxx
// x1xxx
// 302xx
// xxxxx
// xxxxx
- (void)testRule4b
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    XCTAssertTrue([self.life cellPassesRule4:cell], @"failed to pass test for rule 4");
}

//Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
// xxxxx
// xxxxx
// 302xx
// x1xxx
// xxxxx
- (void)testRule4c
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:4 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    
    XCTAssertTrue([self.life cellPassesRule4:cell], @"failed to pass test for rule 4");
}


//Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
// xxxxx
// 1x2xx
// x03xx
// xxxxx
// xxxxx
- (void)testRule4d
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:1 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:2 alive:YES];
    [self.life addCell:cell2];
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    
    XCTAssertTrue([self.life cellPassesRule4:cell], @"failed to pass test for rule 4");
}


//Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
// xxxxx
// 1x2xx
// x0xxx
// xxxxx
// xxxxx
- (void)testRule4e
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:1 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:2 alive:YES];
    [self.life addCell:cell2];
    
    
    XCTAssertFalse([self.life cellPassesRule4:cell], @"failed to pass test for rule 4");
}

@end
