//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Daniel Flores Garcia on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "Tweet.h"
#import "APIManager.h"

@interface TweetDetailsViewController ()

// TODO: At the moment both TweetCell.m and TweetDetailsViewController.m share much of the same code. A way to avoid this repeat code is to create a customView called TweetContents view, and wrap all of the code in TweetCell.m and TweetDetailsViewController.m in that view.

@property (weak, nonatomic) IBOutlet UIImageView *userProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UILabel *favCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;


@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    // Note that the type of request (whether retweeet or unretweet) depends on the state
    // of the button previous to the tap
    [[APIManager shared] retweetToggle:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error updating retweet status of tweet: %@", error.localizedDescription);
         }
         else{
             if (self.tweet.retweeted){
                 self.tweet.retweeted = NO;
                 self.tweet.retweetCount -= 1;
                 NSLog(@"Successfully UNretweeted the following Tweet: %@", tweet.text);
             }
             else{
                 self.tweet.retweeted = YES;
                 self.tweet.retweetCount += 1;
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
             [self refreshData];
         }
     }];
}

- (IBAction)didTapFavorite:(id)sender {
    // Note that the type of request (whether destroy or create) depends on the state
    // of the button previous to the tap
    [[APIManager shared] favoriteToggle:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error updating favorite status of tweet: %@", error.localizedDescription);
         }
         else{
             if (self.tweet.favorited){
                 self.tweet.favorited = NO;
                 self.tweet.favoriteCount -= 1;
                 NSLog(@"Successfully UNfavorited the following Tweet: %@", tweet.text);
             }
             else{
                 self.tweet.favorited = YES;
                 self.tweet.favoriteCount += 1;
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
             [self refreshData];
         }
     }];
}

- (void)refreshData{
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
