//
//  TweetCell.m
//  twitter
//
//  Created by Daniel Flores Garcia on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    // TODO: Update cell UI
    // TODO: Send a POST request to the POST favorites/create endpoint
}



- (void)refreshData{
    // set up everything text
    self.userLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = self.tweet.user.screenName;
    self.createdAtLabel.text = self.tweet.createdAtString;
    self.tweetText.text = self.tweet.text;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%i",self.tweet.retweetCount];
    self.favCountLabel.text = [NSString stringWithFormat:@"%i",self.tweet.favoriteCount];
    
    // profile pic
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.userProfilePic.image = [UIImage imageWithData:urlData];
    
    // retweet
    UIImage *retweetImage = [UIImage imageNamed:@"retweet-icon.png"];
    [self.retweetButton setImage:retweetImage forState:UIControlStateNormal];
    [self.retweetButton setTitle:@"" forState:UIControlStateNormal];
    
    // favorite
    UIImage *favImage = [UIImage imageNamed:@"favor-icon.png"];
    [self.favButton setImage:favImage forState:UIControlStateNormal];
    [self.favButton setTitle:@"" forState:UIControlStateNormal];
    
    // reply
    UIImage *replyImage = [UIImage imageNamed:@"reply-icon.png"];
    [self.replyButton setImage:replyImage forState:UIControlStateNormal];
    [self.replyButton setTitle:@"" forState:UIControlStateNormal];
    
}

@end
