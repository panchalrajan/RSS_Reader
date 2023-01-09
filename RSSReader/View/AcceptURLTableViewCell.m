//
//  AcceptURLTableViewCell.m
//  RSSReader
//
//  Created by Rajan Panchal on 30/12/22.
//

#import "AcceptURLTableViewCell.h"

@implementation AcceptURLTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _url = [[UILabel alloc] init];
        _url.font = [UIFont systemFontOfSize:24];
        _url.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_url];
        [self applyConstraints];
    }
    return self;
}

- (void) applyConstraints {
    [_url.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [_url.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor].active = YES;
    [_url.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide. trailingAnchor].active = YES;
}

@end
