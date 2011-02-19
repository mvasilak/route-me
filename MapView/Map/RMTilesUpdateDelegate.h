//
//  RMTilesUpdateDelegate.h
//
//  Created by Olivier Brand.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "RMLatLong.h"

@protocol RMTilesUpdateDelegate 

@required

- (void) regionUpdate: (RMSphericalTrapezium) region;

@end
