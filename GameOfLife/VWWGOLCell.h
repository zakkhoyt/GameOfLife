//
//  VWWGOLCell.h
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VWWGOLCell : NSObject
@property (nonatomic, readonly) NSInteger x;
@property (nonatomic, readonly) NSInteger y;
@property (nonatomic, readonly) BOOL alive;
@property (nonatomic, strong, readonly) UIColor *color;

-(id)initWithPositionX:(NSInteger)x andY:(NSInteger)y alive:(BOOL)alive;
-(NSString*)description;
-(NSString*)key;
+(NSString*)keyFromX:(NSInteger)x andY:(NSInteger)y;
@end

