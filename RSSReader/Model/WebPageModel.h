//
//  WebPageModel.h
//  RSSReader
//
//  Created by Rajan Panchal on 02/01/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebPageModel : NSObject

@property (nonatomic, strong) NSURL *webPageURL;

- (instancetype) initWithArticleURL:(NSString *)articleURL;

@end

NS_ASSUME_NONNULL_END
