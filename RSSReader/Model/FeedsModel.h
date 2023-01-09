//
//  TableOfFeedsModel.h
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol FeedsModelDelegate <NSObject>

- (void) invalidURL;

@end

@interface FeedsModel : NSObject

@property (nonatomic,weak) id<FeedsModelDelegate> delegate;
@property (nonatomic, strong) NSString *rssTitle;
@property (nonatomic, strong) NSArray *feeds;
@property (nonatomic, strong) NSMutableArray *feedLink;
@property (nonatomic, strong) NSMutableArray *feedTitle;
@property (nonatomic, strong) NSMutableArray *feedDescription;
@property (nonatomic, strong) NSMutableArray *feedThumbnail;
@property (nonatomic, strong) NSMutableArray *feedThumbnail2;
@property (nonatomic, strong) NSMutableArray *readStatus;

- (instancetype) initWithURL:(NSString *)url;
- (void) getJSONData;

@end

NS_ASSUME_NONNULL_END
