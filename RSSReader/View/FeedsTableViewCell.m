//
//  FeedsTableViewCell.m
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import "FeedsTableViewCell.h"

@interface FeedsTableViewCell()


@end


@implementation FeedsTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageHolder = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageHolder.contentMode = UIViewContentModeScaleAspectFit;
        _imageHolder.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_imageHolder];
        
        _feedTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _feedTitle.font = [UIFont boldSystemFontOfSize:20];
        [_feedTitle sizeToFit];
        _feedTitle.numberOfLines = 2;
        _feedTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_feedTitle];
        
        _feedDescription = [[UILabel alloc] initWithFrame:CGRectZero];
        _feedDescription.translatesAutoresizingMaskIntoConstraints = NO;
        _feedDescription.numberOfLines = 3;
        [_feedDescription sizeToFit];
        [self.contentView addSubview:_feedDescription];

        [self applyConstraints];
    }
    return self;
}


- (void) applyConstraints {
    [_imageHolder.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15].active = YES;
    [_imageHolder.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [_imageHolder.trailingAnchor constraintEqualToAnchor:self.contentView.centerXAnchor constant: -50].active = YES;
    [_imageHolder.heightAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.widthAnchor multiplier:0.5].active = YES;
    
    [_feedTitle.topAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.topAnchor].active = YES;
    [_feedTitle.leadingAnchor constraintEqualToAnchor:_imageHolder.trailingAnchor constant:15].active = YES;
    [_feedTitle.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor].active = YES;
    
    [_feedDescription.topAnchor constraintEqualToAnchor:_feedTitle.bottomAnchor].active = YES;
    [_feedDescription.leadingAnchor constraintEqualToAnchor:_imageHolder.trailingAnchor constant:15].active = YES;
    [_feedDescription.trailingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.trailingAnchor].active = YES;
    [_feedDescription.bottomAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.bottomAnchor].active = YES;
}


@end
