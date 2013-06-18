//
//  VWWGOLCell.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWGOLCell.h"

@interface  VWWGOLCell ()
@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;
@property (nonatomic) BOOL alive;
@property (nonatomic, strong) UIColor *color;
@end



@implementation VWWGOLCell
-(id)initWithPositionX:(NSInteger)x andY:(NSInteger)y alive:(BOOL)alive{
    self = [super init];
    if(self){
        _x = x;
        _y = y;
        _alive = alive;
        _color = [self randomColor];
    }
    return self;
}


-(UIColor*)randomColor{
    
//    CGFloat red =  (CGFloat)rand()/(CGFloat)RAND_MAX;
//    CGFloat blue = (CGFloat)rand()/(CGFloat)RAND_MAX;
//    CGFloat green = (CGFloat  )rand()/(CGFloat)RAND_MAX;
//    CGFloat alpha = 0.0;
//    
    
    // Dont' use blackish colors.. that's the default background color
    UIColor *color;
    while(YES){
//        color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        CGFloat red, green, blue, alpha;
        color = [UIColor colorWithRed:(random()%100)/(float)100 green:(random()%100)/(float)100 blue:(random()%100)/(float)100 alpha:1];
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
        if(red > 0.10 && green > 0.10 && blue > 0.10){
            break;
        }
    }
    
    return color;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"%d %d %@", self.x, self.y, self.alive ? @"1" : @"0"];
}

-(NSString*)key{
    return [NSString stringWithFormat:@"%d,%d", self.x, self.y];
}

+(NSString*)keyFromX:(NSInteger)x andY:(NSInteger)y{
    return [NSString stringWithFormat:@"%d,%d", x, y];
}
@end
