//
//  TweetCell.m
//  twitter
//
//  Created by Daniel Flores Garcia on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@interface TweetCell ()

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
// TODO: add screen name
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
// TODO: add timestamp
// TODO: add images for buttons
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UILabel *favCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userProfilePic;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@end

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
    // Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    // Update cell UI
    [self refreshData];
    // Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
         }
     }];
}
- (IBAction)didTapRetweet:(id)sender {
    // Update the local tweet model
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    // Update cell UI
    [self refreshData];
    //Send a POST request to the POST retweets/create endpoint
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
         }
     }];
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
    UIImage *retweetImage;
    if (self.tweet.retweeted){
        retweetImage = [UIImage imageNamed:@"retweet-icon-green.png"];
    }
    else{
        retweetImage = [UIImage imageNamed:@"retweet-icon.png"];
    }
    [self.retweetButton setImage:retweetImage forState:UIControlStateNormal];
    [self.retweetButton setTitle:@"" forState:UIControlStateNormal];
    
    // favorite
    UIImage *favImage;
    if (self.tweet.favorited){
        favImage = [UIImage imageNamed:@"favor-icon-red.png"];
    }
    else{
        favImage = [UIImage imageNamed:@"favor-icon.png"];
    }
    [self.favButton setImage:favImage forState:UIControlStateNormal];
    [self.favButton setTitle:@"" forState:UIControlStateNormal];
    
    // reply
    UIImage *replyImage = [UIImage imageNamed:@"reply-icon.png"];
    [self.replyButton setImage:replyImage forState:UIControlStateNormal];
    [self.replyButton setTitle:@"" forState:UIControlStateNormal];
    
}

@end
