//
//  TweetCell.h
//  twitter
//
//  Created by Daniel Flores Garcia on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) Tweet *tweet;

- (void)refreshData;

@end

NS_ASSUME_NONNULL_END
