//
//  AcceptURLView.m
//  RSSReader
//
//  Created by Rajan Panchal on 30/12/22.
//

#import "AcceptURLView.h"

@interface AcceptURLView()

@property (nonatomic, strong) UILabel *enterURLLabel;
@property (nonatomic, strong) UILabel *recentlyAddedLabel;

@end

@implementation AcceptURLView

- (instancetype)initWithFrame:(CGRect)frame {
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
    _enterURLLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _enterURLLabel.text = @"Please Enter the URL Below";
    _enterURLLabel.textAlignment = NSTextAlignmentCenter;
    [_enterURLLabel setFont:[UIFont  systemFontOfSize:24]];
    _enterURLLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_enterURLLabel];
    
    _enterURLTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _enterURLTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _enterURLTextField.backgroundColor = UIColor.systemGray4Color;
    _enterURLTextField.layer.cornerRadius = 15;
    _enterURLTextField.textAlignment = NSTextAlignmentCenter;
    [_enterURLTextField setFont:[UIFont  systemFontOfSize:24]];
    [self addSubview:_enterURLTextField];
    
    _fetchDataButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_fetchDataButton setTitle:@"Add" forState:UIControlStateNormal];
    [_fetchDataButton setBackgroundColor:UIColor.systemBlueColor];
    _fetchDataButton.titleLabel.font = [UIFont systemFontOfSize:20];
    _fetchDataButton.layer.cornerRadius = 15;
    _fetchDataButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_fetchDataButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_fetchDataButton];
    
    _recentlyAddedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _recentlyAddedLabel.text = @"Recently Added Feeds";
    _recentlyAddedLabel.textAlignment = NSTextAlignmentCenter;
    [_recentlyAddedLabel setFont:[UIFont systemFontOfSize:24]];
    _recentlyAddedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_recentlyAddedLabel];
    
    _urlTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _urlTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_urlTableView];
    [self applyConstraints];
}

- (void) addButtonClicked {
    [self.delegate addURLToTable];
}

- (void) applyConstraints {
    [_enterURLLabel.centerXAnchor constraintEqualToAnchor: self.centerXAnchor ].active = YES;
    [_enterURLLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:100].active = YES;
    
    [_enterURLTextField.centerXAnchor constraintEqualToAnchor: self.centerXAnchor].active = YES;
    [_enterURLTextField.topAnchor constraintEqualToAnchor:_enterURLLabel.bottomAnchor constant:30].active = YES;
    [_enterURLTextField.widthAnchor constraintEqualToConstant:300].active = YES;
    [_enterURLTextField.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [_fetchDataButton.centerXAnchor constraintEqualToAnchor: self.centerXAnchor].active = YES;
    [_fetchDataButton.topAnchor constraintEqualToAnchor:_enterURLTextField.bottomAnchor constant:30].active = YES;
    [_fetchDataButton.widthAnchor constraintGreaterThanOrEqualToConstant:150].active = YES;
    [_fetchDataButton.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [_recentlyAddedLabel.centerXAnchor constraintEqualToAnchor: self.centerXAnchor ].active = YES;
    [_recentlyAddedLabel.topAnchor constraintEqualToAnchor:_fetchDataButton.bottomAnchor constant:50].active = YES;
    
    [_urlTableView.topAnchor constraintEqualToAnchor:_recentlyAddedLabel.bottomAnchor constant:30].active = YES;
    [_urlTableView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [_urlTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
}

@end
