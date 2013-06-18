//
//  VWWGOLLife.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWGOLLife.h"

//#define VWW_VERBOSE_LOGGING 1

@interface VWWGOLLife ()
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;
@property (nonatomic, strong) NSMutableDictionary *cells; 
@property (nonatomic, strong) NSMutableDictionary *evolvedCells;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) BOOL running;
@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic, strong) NSMutableDictionary *examinedDeadCells;
@end



@implementation VWWGOLLife
// http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life




#pragma mark Public methods

-(id)initWithWidth:(NSInteger)width height:(NSInteger)height{
    self = [super init];
    if(self){
        _queue = dispatch_queue_create("com.vaporwareworld.gameoflife", NULL);
        _cells = [@{}mutableCopy];
        _evolvedCells = [@{}mutableCopy];
        _width = width;
        _height = height;
        _running = NO;
        _examinedDeadCells = [@{}mutableCopy];
        
    }
    return self;
}


-(VWWGOLCell*)cellAtIndex:(NSInteger)index{
    NSInteger y = index / self.width;
    NSInteger x = index - y * self.width;
    return [self.cells objectForKey:[VWWGOLCell keyFromX:x andY:y]];
}


-(VWWGOLCell*)cellAtX:(NSInteger)x andY:(NSInteger)y{
    return [self.cells objectForKey:[VWWGOLCell keyFromX:x andY:y]];
}



-(BOOL)addCell:(VWWGOLCell*)cell{
    if([self.cells objectForKey:cell.key]){
        // cell already exists
        return NO;
    }
    
    [self.cells setObject:cell forKey:cell.key];
    return YES;
}

-(void)killAllCells{
    [self stop];
    [self.cells removeAllObjects];
    [self.evolvedCells removeAllObjects];
}

-(void)start{
    if(_running == YES) return;
    _running = YES;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:.20 target:self selector:@selector(processTimer) userInfo:nil repeats:YES];
    NSLog(@"******************* BEGIN");
    [self processTimer];
}
-(void)stop{
    if(_running == NO) return;
    _running = NO;
//    [self.timer invalidate];
    NSLog(@"******************* END");
}


#pragma mark Private methods


-(void)dealloc{
    [self.timer invalidate];
    _timer = nil;
    
    [self.cells removeAllObjects];
    [self.evolvedCells removeAllObjects];
    
}



// 0 1 2
// 3 X 4
// 5 6 7

-(VWWGOLCell*)livingNeighborCell0FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x - 1;
    NSInteger y = cell.y - 1;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)livingNeighborCell1FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x;
    NSInteger y = cell.y - 1;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)livingNeighborCell2FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x + 1;
    NSInteger y = cell.y - 1;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)livingNeighborCell3FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x - 1;
    NSInteger y = cell.y;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)livingNeighborCell4FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x + 1;
    NSInteger y = cell.y;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)livingNeighborCell5FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x - 1;
    NSInteger y = cell.y + 1;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)livingNeighborCell6FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x;
    NSInteger y = cell.y + 1;
    return [self cellAtX:x andY:y];
}
-(VWWGOLCell*)livingNeighborCell7FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x + 1;
    NSInteger y = cell.y + 1;
    return [self cellAtX:x andY:y];
}

-(NSArray*)getLivingNeighborCellsFromCell:(VWWGOLCell*)cell{
    NSMutableArray *neightborCells = [@[]mutableCopy];
    
    VWWGOLCell *cell0 = [self livingNeighborCell0FromCell:cell];
    if(cell0) [neightborCells addObject:cell0];
    
    VWWGOLCell *cell1 = [self livingNeighborCell1FromCell:cell];
    if(cell1) [neightborCells addObject:cell1];
    
    VWWGOLCell *cell2 = [self livingNeighborCell2FromCell:cell];
    if(cell2) [neightborCells addObject:cell2];
    
    VWWGOLCell *cell3 = [self livingNeighborCell3FromCell:cell];
    if(cell3) [neightborCells addObject:cell3];
    
    VWWGOLCell *cell4 = [self livingNeighborCell4FromCell:cell];
    if(cell4) [neightborCells addObject:cell4];
    
    VWWGOLCell *cell5 = [self livingNeighborCell5FromCell:cell];
    if(cell5) [neightborCells addObject:cell5];
    
    VWWGOLCell *cell6 = [self livingNeighborCell6FromCell:cell];
    if(cell6) [neightborCells addObject:cell6];
    
    VWWGOLCell *cell7 = [self livingNeighborCell7FromCell:cell];
    if(cell7) [neightborCells addObject:cell7];
    
    return [NSArray arrayWithArray:neightborCells];
}




// 0 1 2
// 3 X 4
// 5 6 7

-(VWWGOLCell*)deadNeighborCell0FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x - 1;
    NSInteger y = cell.y - 1;
    if([self cellAtX:x andY:y] == nil){
        return [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:NO];
    }
    return nil;
}
-(VWWGOLCell*)deadNeighborCell1FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x;
    NSInteger y = cell.y - 1;
    if([self cellAtX:x andY:y] == nil){
        return [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:NO];
    }
    return nil;
}
-(VWWGOLCell*)deadNeighborCell2FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x + 1;
    NSInteger y = cell.y - 1;
    if([self cellAtX:x andY:y] == nil){
        return [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:NO];
    }
    return nil;
}
-(VWWGOLCell*)deadNeighborCell3FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x - 1;
    NSInteger y = cell.y;
    if([self cellAtX:x andY:y] == nil){
        return [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:NO];
    }
    return nil;
}
-(VWWGOLCell*)deadNeighborCell4FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x + 1;
    NSInteger y = cell.y;
    if([self cellAtX:x andY:y] == nil){
        return [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:NO];
    }
    return nil;
}
-(VWWGOLCell*)deadNeighborCell5FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x - 1;
    NSInteger y = cell.y + 1;
    if([self cellAtX:x andY:y] == nil){
        return [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:NO];
    }
    return nil;
}
-(VWWGOLCell*)deadNeighborCell6FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x;
    NSInteger y = cell.y + 1;
    if([self cellAtX:x andY:y] == nil){
        return [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:NO];
    }
    return nil;
}
-(VWWGOLCell*)deadNeighborCell7FromCell:(VWWGOLCell*)cell{
    NSInteger x = cell.x + 1;
    NSInteger y = cell.y + 1;
    if([self cellAtX:x andY:y] == nil){
        return [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:NO];
    }
    return nil;
}



-(NSDictionary*)getDeadNeighborCellsFromCell:(VWWGOLCell*)cell{
    NSMutableDictionary *deadNeighbors = [@{}mutableCopy];

    VWWGOLCell *cell0 = [self deadNeighborCell0FromCell:cell];
    if(cell0) [deadNeighbors setObject:cell0 forKey:cell0.key];
    
    VWWGOLCell *cell1 = [self deadNeighborCell1FromCell:cell];
    if(cell1) [deadNeighbors setObject:cell1 forKey:cell1.key];
    
    VWWGOLCell *cell2 = [self deadNeighborCell2FromCell:cell];
    if(cell2) [deadNeighbors setObject:cell2 forKey:cell2.key];
    
    VWWGOLCell *cell3 = [self deadNeighborCell3FromCell:cell];
    if(cell3) [deadNeighbors setObject:cell3 forKey:cell3.key];
    
    VWWGOLCell *cell4 = [self deadNeighborCell4FromCell:cell];
    if(cell4) [deadNeighbors setObject:cell4 forKey:cell4.key];
    
    VWWGOLCell *cell5 = [self deadNeighborCell5FromCell:cell];
    if(cell5) [deadNeighbors setObject:cell5 forKey:cell5.key];
    
    VWWGOLCell *cell6 = [self deadNeighborCell6FromCell:cell];
    if(cell6) [deadNeighbors setObject:cell6 forKey:cell6.key];
    
    VWWGOLCell *cell7 = [self deadNeighborCell7FromCell:cell];
    if(cell7) [deadNeighbors setObject:cell7 forKey:cell7.key];

    return [NSDictionary dictionaryWithDictionary:deadNeighbors];
}



//Any live cell with fewer than two live neighbours dies, as if caused by under-population.
-(BOOL)cellPassesRule1:(VWWGOLCell*)cell{
    NSArray *neighborCells = [self getLivingNeighborCellsFromCell:cell];
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
    NSArray *neighborCells = [self getLivingNeighborCellsFromCell:cell];
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
    NSArray *neighborCells = [self getLivingNeighborCellsFromCell:cell];
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
    NSArray *neighborCells = [self getLivingNeighborCellsFromCell:cell];
    if(neighborCells.count == 3){
#if defined(VWW_VERBOSE_LOGGING)
        NSLog(@"%@ birthed from rule 4. %d (==3)", cell, neighborCells.count);
#endif
        
        return YES;
    }
    return NO;
}


-(void)evolveCell:(VWWGOLCell*)cell{
    [self.evolvedCells setObject:cell forKey:cell.key];
}



-(void)processLivingCells{
    
    for(VWWGOLCell *cell in self.cells.allValues){
        //VWWGOLCell *cell = self.cells[index];
        
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
    [self.examinedDeadCells removeAllObjects];
    
    // For each live cell
    for(VWWGOLCell *cell in [self.cells allValues]){
        // Get Dead neighbors
        NSDictionary *deadNeighbors = [self getDeadNeighborCellsFromCell:cell];
        // for each dn in dns
        for(VWWGOLCell *deadNeighbor in [deadNeighbors allValues]){
            if([self.examinedDeadCells objectForKey:deadNeighbor.key] == nil){
                [self.examinedDeadCells setObject:deadNeighbor forKey:deadNeighbor.key];
                // get live neighbors
                NSArray *liveNeighbors = [self getLivingNeighborCellsFromCell:deadNeighbor];
                // if ln.count == 3
                if(liveNeighbors.count == 3){
                    // spring to life
                    [self evolveCell:deadNeighbor];
                }
            }
            
        }
    }
}


-(void)processTimer{
    if(self.running == NO) return;
    dispatch_async(self.queue, ^{
        
        @autoreleasepool {
    
//#if defined(VWW_VERBOSE_LOGGING)
            NSLog(@"---------- Evolving a generation");
//#endif
            [self.evolvedCells removeAllObjects];
            [self processLivingCells];
            [self processDeadCells];
//
//            [self printCells];
//            
//            if([self checkForStaleGeneration] == YES){
//                // TODO:
//            }
            
            [self.cells removeAllObjects];
            self.cells = [[NSDictionary dictionaryWithDictionary:self.evolvedCells]mutableCopy];
            
        }
        
        if(self.running == NO) return;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate renderCells];
//            NSLog(@"");
        });
        [self processTimer];
    });
//    [self processTimer];
}

//-(BOOL)checkForStaleGeneration{
//    // Check if nothing has changed
//    if(self.cells.count == self.evolvedCells.count){
//        for(VWWGOLCell *cell in self.cells){
//            for(VWWGOLCell *evolvedCell in self.evolvedCells){
//                if(cell.x != evolvedCell.x || cell.y != evolvedCell.y) return NO;
//            }
//        }
//    }
//    
//    return YES;
//}
//
//-(void)printCells{
//    
//    NSLog(@"***** current *******************************");
//    for(NSInteger x = 0; x < self.width; x++){
//        NSMutableString *line = [[NSMutableString alloc]initWithString:@""];
//        for(NSInteger y = 0; y < self.height; y++){
//            if([self cellAtX:x andY:y]){
//                [line appendFormat:@"1"];
//            }
//            else{
//                [line appendFormat:@"0"];
//            }
//        }
//        NSLog(@"%@", line);
//    }
//    
//}

@end
