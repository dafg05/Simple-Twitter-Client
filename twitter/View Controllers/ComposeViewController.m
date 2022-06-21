//
//  ComposeViewController.m
//  twitter
//
//  Created by Daniel Flores Garcia on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"



@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *composeTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)closeCompose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

//- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;

//[[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error)
- (IBAction)sendTweet:(id)sender {
    NSString *tweetContent =  self.composeTextView.text;
    [[APIManager shared] postStatusWithText:tweetContent completion:^(Tweet *tweet, NSError *error) {
        if (error){
            NSLog(@"😫😫😫 Error posting tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"😎😎😎 Successfully posted tweet");
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
