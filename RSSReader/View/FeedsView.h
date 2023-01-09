//
//  TableOfFeedsView.h
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedsView : UIView

@property (nonatomic, weak) id<UITableViewDelegate> delegate;
@property (nonatomic,strong) TabBarView *tabBarView;
@property (nonatomic, strong) UITableView *feedsTableView;

@end

NS_ASSUME_NONNULL_END
