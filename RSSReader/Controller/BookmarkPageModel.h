//
//  BookmarkPageModel.h
//  RSSReader
//
//  Created by Rajan Panchal on 03/01/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookmarkPageModel : NSObject

@property (nonatomic, strong) NSMutableArray<NSString *> *listOfBookmarksURL;
@end

NS_ASSUME_NONNULL_END
