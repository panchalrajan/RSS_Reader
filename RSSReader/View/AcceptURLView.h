//
//  AcceptURLView.h
//  RSSReader
//
//  Created by Rajan Panchal on 30/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AcceptURLViewDelegate <NSObject>

- (void) addURLToTable;

@end

@interface AcceptURLView : UIView

@property (nonatomic, weak) id <AcceptURLViewDelegate> delegate;
@property (nonatomic, strong) UITextField *enterURLTextField;
@property (nonatomic, strong) UIButton *fetchDataButton;
@property (nonatomic, strong) UITableView *urlTableView;

@end

NS_ASSUME_NONNULL_END
