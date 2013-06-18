//
//  GameOfLifeTests.m
//  GameOfLifeTests
//
//  Created by Zakk Hoyt on 6/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VWWGOLPhysics.h"
@interface GameOfLifeTests : XCTestCase
@property (nonatomic, strong) VWWGOLPhysics *physics;
@end

@implementation GameOfLifeTests

- (void)setUp
{
    [super setUp];
    
    self.physics = [[VWWGOLPhysics alloc]initWithWidth:10 height:10];

}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}



//- (void)test3x1Line
//{
//    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:1 andY:2 alive:YES];
//    [self.physics addCell:cell];
//    
//    
//    
//    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
//    [self.physics addCell:cell1];
//    
//    
//    
//    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:2 alive:YES];
//    [self.physics addCell:cell2];
//    
//    
//    [self.physics processTimer];
//    
//    XCTAssertTrue((BOOL)(self.physics.cells.count == 3), @"failed to rotate 3x1 line. %s", __func__);
//    
//    
//    cell = self.physics.cells[0];
//    XCTAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//    
//    cell = self.physics.cells[1];
//    XCTAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//    
//    cell = self.physics.cells[2];
//    XCTAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//    
//    
//    [self.physics processTimer];
//    
//    XCTAssertTrue((self.physics.cells.count == 3), @"failed to rotate 3x1 line. %s", __func__);
//    
//    
//    cell = self.physics.cells[0];
//    XCTAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//    
//    cell = self.physics.cells[1];
//    XCTAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//    
//    cell = self.physics.cells[2];
//    XCTAssertTrue(cell, @"failed to rotate 3x1 line. %s", __func__);
//    
//    
//    NSLog(@"");
//    
//    
//    
//    
//}




//Any live cell with fewer than two live neighbours dies, as if caused by under-population.
// xxxxx
// x1xxx
// x02xx
// xxxxx
// xxxxx
- (void)testRule1a
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.physics addCell:cell];

    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.physics addCell:cell1];

    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.physics addCell:cell2];

    XCTAssertTrue([self.physics cellPassesRule1:cell], @"failed to pass test for rule 1");
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
    [self.physics addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.physics addCell:cell1];
    
    XCTAssertFalse([self.physics cellPassesRule1:cell], @"failed to pass test for rule 1");
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
    [self.physics addCell:cell];
    
    XCTAssertFalse([self.physics cellPassesRule1:cell], @"failed to pass test for rule 1");
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
    [self.physics addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.physics addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.physics addCell:cell2];
    
    XCTAssertTrue([self.physics cellPassesRule2:cell], @"failed to pass test for rule 2");
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
    [self.physics addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.physics addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.physics addCell:cell2];

    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.physics addCell:cell3];
    
    XCTAssertTrue([self.physics cellPassesRule2:cell], @"failed to pass test for rule 2");
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
    [self.physics addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.physics addCell:cell1];
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.physics addCell:cell2];
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.physics addCell:cell3];

    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:2 andY:4 alive:YES];
    [self.physics addCell:cell4];

    
    XCTAssertFalse([self.physics cellPassesRule2:cell], @"failed to pass test for rule 2");
}










@end
