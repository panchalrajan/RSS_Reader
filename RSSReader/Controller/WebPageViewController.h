//
//  WebPageViewController.h
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebPageViewController : UIViewController

- (instancetype)initWithArticle:(NSString *)articleURL;

@end

NS_ASSUME_NONNULL_END
