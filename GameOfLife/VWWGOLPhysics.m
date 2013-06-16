//
//  VWWGOLPhysics.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//




#import "VWWGOLPhysics.h"


#define VWW_VERBOSE_LOGGING 1


@interface VWWGOLPhysics ()
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;
@property (nonatomic, strong) NSMutableArray *cells;
@property (nonatomic, strong) NSMutableArray *evolvedCells;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) BOOL running;

@end

@implementation VWWGOLPhysics


// http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life




#pragma mark Public methods

-(id)initWithWidth:(NSInteger)width height:(NSInteger)height{
    self = [super init];
    if(self){
        _cells = [@[]mutableCopy];
        _evolvedCells = [@[]mutableCopy];
        _width = width;
        _height = height;
        _running = NO;
        
    }
    return self;
}


-(VWWGOLCell*)cellAtIndex:(NSInteger)index{
    NSInteger row = index / self.width;
    NSInteger column = index - row * self.width;
    for(VWWGOLCell *cell in self.cells){
        if(cell.x == row && cell.y == column) return cell;
    }
    return nil;
}




-(VWWGOLCell*)cellAtX:(NSInteger)x andY:(NSInteger)y{
    for(VWWGOLCell *cell in self.cells){
        if(cell.x == x && cell.y == y) return cell;
    }
    return nil;
}



// Return NO if there is already a cell there
-(BOOL)addCell:(VWWGOLCell*)newCell{
    for(VWWGOLCell *cell in self.cells){
        if(cell.x == newCell.x && cell.y == newCell.y){
            NSLog(@"***** ERROR: Failed to add new cell at %d %d", newCell.x, newCell.y);
            return NO;
        }
        
    }
    
    [self.cells addObject:newCell];
    return YES;
}

-(void)start{
    if(_running == YES) return;
    _running = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.10 target:self selector:@selector(processTimer) userInfo:nil repeats:YES];
    NSLog(@"******************* BEGIN");
}
-(void)stop{
    if(_running == NO) return;
    _running = NO;
    [self.timer invalidate];
    NSLog(@"******************* END");
}


#pragma mark Private methods


-(void)dealloc{
    [self.timer invalidate];
    _timer = nil;
}



// 0 1 2
// 3 X 4
// 5 6 7

-(VWWGOLCell*)neighborCell0FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x - 1;
    NSInteger y = cell.y - 1;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)neighborCell1FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x;
    NSInteger y = cell.y - 1;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)neighborCell2FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x + 1;
    NSInteger y = cell.y - 1;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)neighborCell3FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x - 1;
    NSInteger y = cell.y;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)neighborCell4FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x + 1;
    NSInteger y = cell.y;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)neighborCell5FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x - 1;
    NSInteger y = cell.y + 1;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)neighborCell6FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x;
    NSInteger y = cell.y + 1;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)neighborCell7FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x + 1;
    NSInteger y = cell.y + 1;
    return [self cellAtX:x andY:y];
}

-(NSArray*)getNeightborCellsFromCell:(VWWGOLCell*)cell{
    NSMutableArray *neightborCells = [@[]mutableCopy];
    
    VWWGOLCell *cell0 = [self neighborCell0FromCell:cell];
    if(cell0) [neightborCells addObject:cell0];
    
    VWWGOLCell *cell1 = [self neighborCell1FromCell:cell];
    if(cell1) [neightborCells addObject:cell1];
    
    VWWGOLCell *cell2 = [self neighborCell2FromCell:cell];
    if(cell2) [neightborCells addObject:cell2];
    
    VWWGOLCell *cell3 = [self neighborCell3FromCell:cell];
    if(cell3) [neightborCells addObject:cell3];
    
    VWWGOLCell *cell4 = [self neighborCell4FromCell:cell];
    if(cell4) [neightborCells addObject:cell4];
    
    VWWGOLCell *cell5 = [self neighborCell5FromCell:cell];
    if(cell5) [neightborCells addObject:cell5];
    
    VWWGOLCell *cell6 = [self neighborCell6FromCell:cell];
    if(cell6) [neightborCells addObject:cell6];
    
    VWWGOLCell *cell7 = [self neighborCell7FromCell:cell];
    if(cell7) [neightborCells addObject:cell7];
    
    return [NSArray arrayWithArray:neightborCells];
}

//Any live cell with fewer than two live neighbours dies, as if caused by under-population.
-(BOOL)cellPassesRule1:(VWWGOLCell*)cell{
    NSArray *neighborCells = [self getNeightborCellsFromCell:cell];
    if(neighborCells.count < 2){
#if defined(VWW_VERBOSE_LOGGING)
        NSLog(@"%@ died from rule 1. %d (<2)", cell, neighborCells.count);
#endif
        return NO;
    }
    return YES;
}

//Any live cell with two or three live neighbours lives on to the next generation.
-(BOOL)cellPassesRule2:(VWWGOLCell*)cell{
    NSArray *neighborCells = [self getNeightborCellsFromCell:cell];
    if(neighborCells.count == 2 || neighborCells.count == 3){
        return YES;
    }
    
#if defined(VWW_VERBOSE_LOGGING)
    NSLog(@"%@ died from rule 2. %d (!=2 !=3)", cell, neighborCells.count);
#endif
    return NO;
}

//Any live cell with more than three live neighbours dies, as if by overcrowding.
-(BOOL)cellPassesRule3:(VWWGOLCell*)cell{
    NSArray *neighborCells = [self getNeightborCellsFromCell:cell];
    if(neighborCells.count > 3){
#if defined(VWW_VERBOSE_LOGGING)
        NSLog(@"%@ died from rule 3. %d (>3)", cell, neighborCells.count);
#endif

        return NO;
    }
    return YES;
}

//Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
-(BOOL)cellPassesRule4:(VWWGOLCell*)cell{
    NSArray *neighborCells = [self getNeightborCellsFromCell:cell];
    if(neighborCells.count == 3){
#if defined(VWW_VERBOSE_LOGGING)
        NSLog(@"%@ birthed from rule 4. %d (==3)", cell, neighborCells.count);
#endif

        return YES;
    }
    return NO;
}


-(void)evolveCell:(VWWGOLCell*)cell{
    [self.evolvedCells addObject:cell];
}



-(void)processLivingCells{
    for(NSInteger index = 0; index < self.cells.count; index++){
        VWWGOLCell *cell = self.cells[index];
        if([self cellPassesRule1:cell] == YES &&
           [self cellPassesRule2:cell] == YES &&
           [self cellPassesRule3:cell] == YES){
            [self evolveCell:cell];
        }
    }
}


-(NSArray*)calculateDeadCells{
    NSMutableArray *deadCells = [@[]mutableCopy];
    for(NSInteger x = 0; x < self.width; x++){
        for(NSInteger y = 0; y < self.height; y++){
            VWWGOLCell *cell = [self cellAtX:x andY:y];
            if(cell == nil){
                cell = [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:NO];
                [deadCells addObject:cell];
            }
        }
    }
    return [NSArray arrayWithArray:deadCells];
}
-(void)processDeadCells{
    NSArray *deadCells = [self calculateDeadCells];
    
    NSLog(@"cells=%d alive=%d dead=%d", self.width * self.height, self.cells.count, deadCells.count);
    
    for(NSInteger d = 0; d < deadCells.count; d++){
        VWWGOLCell *cell = deadCells[d];
        if([self cellPassesRule4:cell] == YES){
            [self evolveCell:cell];
        }
    }
}


-(void)processTimer{

    NSLog(@"---------- Evolving a generation");
    [self.evolvedCells removeAllObjects];
    [self processLivingCells];
    [self processDeadCells];
    
//    [self printCells];
    
    if([self checkForStaleGeneration] == YES){
        // TODO: 
    }

    [self.cells removeAllObjects];
    self.cells = [[NSArray arrayWithArray:self.evolvedCells]mutableCopy];

    [self.delegate renderCells];
    NSLog(@"");
}

-(BOOL)checkForStaleGeneration{
    // Check if nothing has changed
    if(self.cells.count == self.evolvedCells.count){
        for(VWWGOLCell *cell in self.cells){
            for(VWWGOLCell *evolvedCell in self.evolvedCells){
                if(cell.x != evolvedCell.x || cell.y != evolvedCell.y) return NO;
            }
        }
    }
    
    return YES;
}

-(void)printCells{
    
    NSLog(@"***** current *******************************");
    for(NSInteger x = 0; x < self.width; x++){
        NSMutableString *line = [[NSMutableString alloc]initWithString:@""];
        for(NSInteger y = 0; y < self.height; y++){
            if([self cellAtX:x andY:y]){
                [line appendFormat:@"1"];
            }
            else{
                [line appendFormat:@"0"];
            }
        }
        NSLog(@"%@", line);
    }
    
}


@end
