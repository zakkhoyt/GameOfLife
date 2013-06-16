//
//  VWWCGView.h
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VWWGOLPhysics;

@interface VWWCGView : UIView
@property (nonatomic, strong) VWWGOLPhysics *physics;
@end
