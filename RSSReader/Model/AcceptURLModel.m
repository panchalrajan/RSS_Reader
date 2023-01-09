//
//  AcceptURLModel.m
//  RSSReader
//
//  Created by Rajan Panchal on 30/12/22.
//

#import "AcceptURLModel.h"

@implementation AcceptURLModel

- (instancetype) init {
    self = [super init];
    if (self != nil) {
        [self customInit];
    }
    return self;
}

- (void) customInit {
    //Alternative : NSMutableOrderedSet to Prevent Duplicate Entries
    _listOfURL = [[NSMutableArray alloc] init];
    [self addTestLinks];
}

- (void) addTestLinks {
    [_listOfURL addObject:@"https://images.apple.com/main/rss/hotnews/hotnews.rss"];
    [_listOfURL addObject:@"https://vnexpress.net/rss/the-thao.rss"];
    [_listOfURL addObject:@"https://news.un.org/feed/subscribe/en/news/region/asia-pacific/feed/rss.xml"];
}


@end
