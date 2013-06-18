//
//  VWWCGLifeView.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWCGLifeView.h"
#import "VWWGOLLife.h"



@implementation VWWCGLifeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    NSLog(@"%s", __func__);
    
    //    self.backgroundColor = [UIColor clearColor];
    
    CGFloat cellWidth = self.bounds.size.width / self.life.width;
    CGFloat cellHeight = self.bounds.size.height / self.life.height;
    
    CGFloat red, green, blue, alpha;
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    for(NSInteger x = 0; x < self.physics.width; x++){
    //        for(NSInteger y = 0; y < self.physics.height; y++){
    //            VWWGOLCell *cell = [self.physics cellAtIndex:y + self.physics.width * x];
    //            if(cell){
    //                [cell.color getRed:&red green:&green blue:&blue alpha:&alpha];
    //                CGContextSetRGBFillColor(context, red, green, blue, alpha);
    //            }
    //            else{
    //                CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
    //            }
    //
    //            CGFloat rectX = cellWidth * x;
    //            CGFloat rectY = cellHeight * y;
    //
    //            CGRect cellRect = CGRectMake(rectX, rectY, cellWidth, cellHeight);
    ////            CGContextFillEllipseInRect(context, cellRect);
    //            CGContextFillRect(context, cellRect);
    //        }
    //    }
    
    
    for(VWWGOLCell *cell in [self.life.cells allValues]){
        [cell.color getRed:&red green:&green blue:&blue alpha:&alpha];
        CGContextSetRGBFillColor(context, red, green, blue, alpha);
        CGFloat rectX = cellWidth * cell.x;
        CGFloat rectY = cellHeight * cell.y;
        CGRect cellRect = CGRectMake(rectX, rectY, cellWidth, cellHeight);
        CGContextFillRect(context, cellRect);
    }
    
    
    
    
    CGContextDrawPath(context,kCGPathStroke);
    
}


@end
