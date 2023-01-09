//
//  TableOfFeedsView.m
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import "FeedsView.h"
#import "TabBarView.h"

@implementation FeedsView

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
    
    _feedsTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _feedsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_feedsTableView];
    
    [self applyConstraints];
}

- (void) applyConstraints {
    [_feedsTableView.topAnchor constraintEqualToAnchor:self.topAnchor constant:30].active = YES;
    [_feedsTableView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [_feedsTableView.bottomAnchor constraintEqualToAnchor:_tabBarView.topAnchor].active = YES;
    
    [_tabBarView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [_tabBarView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_tabBarView.heightAnchor constraintEqualToConstant:100].active = YES;
}

@end
