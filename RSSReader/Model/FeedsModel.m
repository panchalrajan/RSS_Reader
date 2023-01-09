//
//  TableOfFeedsModel.m
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import "FeedsModel.h"

@interface FeedsModel()

@property (nonatomic, strong) NSDictionary *fullJSON;
@property (nonatomic, strong) NSURL *jsonURL;

@end

@implementation FeedsModel

- (instancetype) initWithURL:(NSString *)url {
    if( self = [super init]) {
        NSString *api = @"https://api.rss2json.com/v1/api.json?rss_url=";
        NSString *newURL = [NSString stringWithFormat:@"%@%@", api, url];
        newURL = [newURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        _jsonURL = [NSURL URLWithString:newURL];
    }
  return self;
}

//JSON will generate at viewWillAppear Call:
- (void) getJSONData {
    NSData *data = [[NSData alloc] initWithContentsOfURL:_jsonURL];
    if (data == nil) {
        [self.delegate invalidURL]; //Prevent Crash if Data is Invalid
    } else {
        NSError *err = nil;
        _fullJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"%@", err.description);
        } else {
            [self fetchTitle];
            [self generateData];
        }
    }
}

- (void) generateData {
    _feeds = [_fullJSON valueForKey:@"items"];
    _feedLink = [[NSMutableArray alloc] init];
    _feedTitle = [[NSMutableArray alloc] init];
    _feedDescription = [[NSMutableArray alloc] init];
    _feedThumbnail = [[NSMutableArray alloc] init];
    _feedThumbnail2 = [[NSMutableArray alloc] init];
    _readStatus = [[NSMutableArray alloc] init];

    NSArray *enclosure = [_feeds valueForKeyPath:@"enclosure"];

    for(NSDictionary *feedDict in _feeds) {
       [_feedLink addObject: feedDict[@"link"]];
       [_feedTitle addObject: feedDict[@"title"]];
       [_feedDescription addObject: feedDict[@"description"]];
       [_feedThumbnail addObject: feedDict[@"thumbnail"]];
        [_readStatus addObject:@"NO"];
    }
    
    //Fetching Image from Enclosure files
    for(NSDictionary *imageDict in enclosure) {
        if ([imageDict[@"type"] isEqualToString:@"image/jpeg"] ) {
            [_feedThumbnail2 addObject: imageDict[@"link"]];
        } else {
            [_feedThumbnail2 addObject: @""];
        }
    }
}

- (void) fetchTitle {
    NSArray *feedDetails = [_fullJSON valueForKey:@"feed"];
    _rssTitle = [feedDetails valueForKeyPath:@"title"];
}


@end
