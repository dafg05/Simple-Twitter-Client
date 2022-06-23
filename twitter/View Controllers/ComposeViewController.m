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

static int const CHARLIMIT = 140;

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (weak, nonatomic) IBOutlet UILabel *charCountLabel;



@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.composeTextView.delegate = self;
    int charCount = [self.composeTextView.text length];
    [self updateCharCountLabel:charCount];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
    int characterLimit = CHARLIMIT;
    NSString *newText = [self.composeTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Allow or disallow the new text
    return newText.length < characterLimit;
}

- (void)updateCharCountLabel:(int)charCount{
    self.charCountLabel.text = [NSString stringWithFormat:@"%d/%D", charCount, CHARLIMIT];
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

- (void)textViewDidChange:(UITextView *)textView{
    int charCount = [self.composeTextView.text length];
    [self updateCharCountLabel:charCount];
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
