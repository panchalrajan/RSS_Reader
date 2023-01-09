//
//  BookmarkPageModel.m
//  RSSReader
//
//  Created by Rajan Panchal on 03/01/23.
//

#import "BookmarkPageModel.h"

@implementation BookmarkPageModel

- (instancetype) init {
    self = [super init];
    if (self != nil) {
        [self customInit];
    }
    return self;
}

- (void) customInit {
    //Alternative : NSMutableOrderedSet
    _listOfBookmarksURL = [[NSMutableArray alloc] init];

}@end
