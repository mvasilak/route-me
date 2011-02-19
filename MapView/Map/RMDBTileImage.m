//
// RMDBTileImage.m
//
// Copyright (c) 2009, Frank Schroeder, SharpMind GbR
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

// RMDBTileImage is a tile image implementation for the RMDBMapSource.
// 
// See RMDBMapSource.m for a full documentation on the database schema.
//    


#import "RMDBTileImage.h"

#define FMDBErrorCheck(db)		{ if ([db hadError]) { NSLog(@"DB error %d on line %d: %@", [db lastErrorCode], __LINE__, [db lastErrorMessage]); } }

@implementation RMDBTileImage

- (id)initWithTile:(RMTile)_tile fromDB:(FMDatabase*)db {
	self = [super initWithTile:_tile];
	if (self != nil) {
		// get the unique key for the tile
		NSNumber* key = [NSNumber numberWithLongLong:RMTileKey(_tile)];
		RMLog(@"fetching tile %@ (y:%d, x:%d)@%d", key, _tile.y, _tile.x, _tile.zoom);
		
		// fetch the image from the db
		FMResultSet* rs = [db executeQuery:@"select image from tiles where tilekey = ?", key];
		FMDBErrorCheck(db);
		if ([rs next]) {
			[self updateImageUsingImage:[[[PLATFORM_IMAGE alloc] initWithData:[rs dataForColumn:@"image"]] autorelease]];
		}
		[rs close];
	}
	return self;
}

@end
