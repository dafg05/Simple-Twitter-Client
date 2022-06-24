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

@interface ComposeViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *composeTextField;
@property (weak, nonatomic) IBOutlet UILabel *charCountLabel;
@property NSString *defaultPlaceholder;



@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.composeTextField.delegate = self;
    self.composeTextField.text = @"Write your tweet here...";
    self.composeTextField.textColor = UIColor.lightGrayColor;
    int charCount = 0;
    
    [self updateCharCountLabel:charCount];
}

- (BOOL)textView:(UITextField *)textField shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Check the proposed new text character count
    int characterLimit = CHARLIMIT;
    NSString *newText = [self.composeTextField.text stringByReplacingCharactersInRange:range withString:text];
    
    // Allow or disallow the new text
    return newText.length < characterLimit;
}

- (void)updateCharCountLabel:(int)charCount{
    self.charCountLabel.text = [NSString stringWithFormat:@"%d/%D", charCount, CHARLIMIT];
}

- (IBAction)closeCompose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.composeTextField.textColor == UIColor.lightGrayColor){
        self.composeTextField.textColor = UIColor.blackColor;
        self.composeTextField.text = @"";
    }
    int charCount = [self.composeTextField.text length];
    [self updateCharCountLabel:charCount];
}

//- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;

//[[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error)
- (IBAction)sendTweet:(id)sender {
    NSString *tweetContent =  self.composeTextField.text;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
