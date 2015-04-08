//
//  HistoryCardGameViewController.m
//  Matchismo
//
//  Created by Gaurav Verma on 7/25/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@end

@implementation HistoryViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSMutableAttributedString *returnString = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    
    NSMutableAttributedString *finalString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    for (id obj in self.previousMessages) {
        if ([obj isKindOfClass:[NSAttributedString class]]){
            
            [finalString appendAttributedString:obj];
            [finalString appendAttributedString:returnString];
            
            
        }
    }
    
    /*NSRange range = {0, [finalString length]};
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;*/
    //paragraph.lineHeightMultiple = ;
    
    
    
    
    
    
    
    //[finalString addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
    
    self.messageTextView.attributedText = finalString;
    self.messageTextView.backgroundColor = self.backgroundColor;
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
