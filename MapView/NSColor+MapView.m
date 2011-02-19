//
//  NSColor+MapView.m
//  MapViewMac
//
//  Created by Pierre Bernard on 7/6/10.
//  Copyright 2010 Houdah Software. All rights reserved.
//

#import "NSColor+MapView.h"

@implementation NSColor (MapView)

-(CGColorRef)CGColor {
    CGFloat colorComponents[4];
    [[self colorUsingColorSpaceName:NSCalibratedRGBColorSpace] getComponents:colorComponents];
    return (CGColorRef)[(id)CGColorCreateGenericRGB(colorComponents[0], 
                                                    colorComponents[1],
                                                    colorComponents[2],
                                                    colorComponents[3]
                                                    ) autorelease];
}

@end