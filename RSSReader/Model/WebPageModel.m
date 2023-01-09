//
//  WebPageModel.m
//  RSSReader
//
//  Created by Rajan Panchal on 02/01/23.
//

#import "WebPageModel.h"

@implementation WebPageModel

- (instancetype) initWithArticleURL:(NSString *)articleURL {
    if( self = [super init]) {
        _webPageURL = [NSURL URLWithString:articleURL];
    }
  return self;
}

@end
