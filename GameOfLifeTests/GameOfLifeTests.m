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

- (void)testRule1
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    
    
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:3];
    [self.physics addCell:cell];

    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:2];
    [self.physics addCell:cell1];

    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3];
    [self.physics addCell:cell2];

    
    XCTAssertTrue([self.physics cellPassesRule1:cell], @"failed to pass test for rule 1");
}

@end
