//
//  WebPageView.m
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import "WebPageView.h"
#import "TabBarView.h"

@implementation WebPageView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self customInit];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if(self) {
        [self customInit];
    }
    return self;
}

- (void) customInit {
    _tabBarView = [[TabBarView alloc] initWithFrame:CGRectZero];
    _tabBarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_tabBarView];
    
    _articleView = [[WKWebView alloc] initWithFrame:CGRectZero];
    _articleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_articleView];
            
    [self applyConstraints];
}
- (void) applyConstraints {
    [_articleView.topAnchor constraintEqualToAnchor:self.topAnchor constant:30].active = YES;
    [_articleView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [_articleView.bottomAnchor constraintEqualToAnchor:_tabBarView.topAnchor].active = YES;
    
    [_tabBarView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [_tabBarView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_tabBarView.heightAnchor constraintEqualToConstant:100].active = YES;
}

@end
