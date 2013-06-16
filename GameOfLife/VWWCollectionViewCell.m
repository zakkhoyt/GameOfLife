//
//  VWWCollectionViewCell.m
//  NewNav
//
//  Created by Zakk Hoyt on 6/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWCollectionViewCell.h"
#import "VWWGOLCell.h"

@implementation VWWCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)setCell:(VWWGOLCell *)cell{
    _cell = cell;
    self.backgroundColor = cell.color;
    [self setNeedsDisplay];
}

@end
