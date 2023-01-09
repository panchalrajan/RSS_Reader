//
//  WebPageView.h
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "TabBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebPageView : UIView

@property (nonatomic,strong) TabBarView *tabBarView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) WKWebView  *articleView;

@end

NS_ASSUME_NONNULL_END
