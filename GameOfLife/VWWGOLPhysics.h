//
//  VWWGOLPhysics.h
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWGOLCell.h"

@class VWWGOLPhysics;


@protocol VWWGOLPhysicsDelegate <NSObject>
-(void)renderCells;
@end




@interface VWWGOLPhysics : NSObject
@property (nonatomic, weak) id <VWWGOLPhysicsDelegate> delegate;
@property (nonatomic, readonly) NSInteger width;
@property (nonatomic, readonly) NSInteger height;
@property (nonatomic, strong, readonly) NSMutableArray *cells;
@property (nonatomic, readonly) BOOL running;

-(id)initWithWidth:(NSInteger)width height:(NSInteger)height;
-(BOOL)addCell:(VWWGOLCell*)newCell;
-(VWWGOLCell*)cellAtIndex:(NSInteger)index;
-(void)start;
-(void)stop;
@end


@interface VWWGOLPhysics (tests)

//Any live cell with fewer than two live neighbours dies, as if caused by under-population.
-(BOOL)cellPassesRule1:(VWWGOLCell*)cell;

//Any live cell with two or three live neighbours lives on to the next generation.
-(BOOL)cellPassesRule2:(VWWGOLCell*)cell;

//Any live cell with more than three live neighbours dies, as if by overcrowding.
-(BOOL)cellPassesRule3:(VWWGOLCell*)cell;

//Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
-(BOOL)cellPassesRule4:(VWWGOLCell*)cell;

// Apply all rules
-(void)processTimer;

@end
