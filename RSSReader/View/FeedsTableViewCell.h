//
//  FeedsTableViewCell.h
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageHolder;
@property(nonatomic) UILabel *feedTitle;
@property(nonatomic) UILabel *feedDescription;


@end

NS_ASSUME_NONNULL_END
