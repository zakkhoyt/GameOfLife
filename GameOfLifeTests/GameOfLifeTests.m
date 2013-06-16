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


- (void)testRule1b
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.physics addCell:cell];
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.physics addCell:cell1];
    
    XCTAssertFalse([self.physics cellPassesRule1:cell], @"failed to pass test for rule 1");
}


- (void)testRule1c
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.physics addCell:cell];
    
    XCTAssertFalse([self.physics cellPassesRule1:cell], @"failed to pass test for rule 1");
}



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
