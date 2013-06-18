//
//  VWWGOLLIfeRule2Tests.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/17/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VWWGOLLIfe.h"

@interface VWWGOLLIfeRule2Tests : XCTestCase
@property (nonatomic, strong) VWWGOLLife *life;
@end

@implementation VWWGOLLIfeRule2Tests

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


//Any live cell with two or three live neighbours lives on to the next generation.
// Cell lives
// xxxxxx
// x123xx
// xx04xx
// xxxxxx
// xxxxxx
- (void)testRule2a
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:1 andY:1 alive:YES];
    [self.life addCell:cell1];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:2 andY:1 alive:YES];
    [self.life addCell:cell2];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:3 andY:1 alive:YES];
    [self.life addCell:cell3];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:3 andY:2 alive:YES];
    [self.life addCell:cell4];

    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
}


// Cell lives
// xxxxxx
// xx12xx
// xx03xx
// xxx4xx
// xxxxxx
// xxxxxx
- (void)testRule2b
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:1 alive:YES];
    [self.life addCell:cell1];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:1 alive:YES];
    [self.life addCell:cell2];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:3 andY:2 alive:YES];
    [self.life addCell:cell3];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell4];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
}

// Cell lives
// xxxxxx
// xxx1xx
// xx02xx
// xx43xx
// xxxxxx
- (void)testRule2c
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:3 andY:1 alive:YES];
    [self.life addCell:cell1];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:2 alive:YES];
    [self.life addCell:cell2];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell4];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
}

// Cell lives
// xxxxxx
// xxxxxx
// xx01xx
// x432xx
// xxxxxx
- (void)testRule2d
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:3 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell4];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
}

// Cell lives
// xxxxxx
// xxxxxx
// x40xxx
// x321xx
// xxxxxx
- (void)testRule2e
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:3 andY:3 alive:YES];
    [self.life addCell:cell1];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell3];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:1 andY:2 alive:YES];
    [self.life addCell:cell4];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
}


// Cell lives
// xxxxxx
// x4xxxx
// x30xxx
// x21xxx
// xxxxxx
- (void)testRule2f
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:2 andY:3 alive:YES];
    [self.life addCell:cell1];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell2];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:2 alive:YES];
    [self.life addCell:cell3];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:1 andY:1 alive:YES];
    [self.life addCell:cell4];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
}



// Cell lives
// xxxxxx
// x34xxx
// x20xxx
// x1xxxx
// xxxxxx
- (void)testRule2g
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:1 andY:3 alive:YES];
    [self.life addCell:cell1];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:1 andY:2 alive:YES];
    [self.life addCell:cell2];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:1 andY:1 alive:YES];
    [self.life addCell:cell3];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:2 andY:1 alive:YES];
    [self.life addCell:cell4];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
}


// Cell lives
// xxxxxx
// x234xx
// x10xxx
// xxxxxx
// xxxxxx
- (void)testRule2h
{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:2 andY:2 alive:YES];
    [self.life addCell:cell];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell1 = [[VWWGOLCell alloc]initWithPositionX:1 andY:2 alive:YES];
    [self.life addCell:cell1];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell2 = [[VWWGOLCell alloc]initWithPositionX:1 andY:1 alive:YES];
    [self.life addCell:cell2];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell3 = [[VWWGOLCell alloc]initWithPositionX:2 andY:1 alive:YES];
    [self.life addCell:cell3];
    
    XCTAssertTrue([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);
    
    VWWGOLCell *cell4 = [[VWWGOLCell alloc]initWithPositionX:3 andY:1 alive:YES];
    [self.life addCell:cell4];
    
    XCTAssertFalse([self.life cellPassesRule2:cell], @"failed to pass test for rule 2. %s", __func__);

}




@end
