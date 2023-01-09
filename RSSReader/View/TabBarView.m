//
//  BackButtonBarView.m
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import "TabBarView.h"

@implementation TabBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if(self) {
        [self customInit];
    }
    return self;
}

- (void) customInit {
    _myTabBar = [[UITabBar alloc] initWithFrame:CGRectZero];
    _myTabBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_myTabBar];
    [self applyConstraints];
}

- (void) applyConstraints {
    [_myTabBar.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_myTabBar.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_myTabBar.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [_myTabBar.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
}


@end
