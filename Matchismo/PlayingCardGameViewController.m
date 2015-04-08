//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Gaurav Verma on 7/23/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (void)updateUI
{
    [super updateUI];
    
}

- (void)extractCardContents:(NSMutableAttributedString *)genString usingCard:(Card *)card
{
    if ([card isMemberOfClass:[PlayingCard class]]) {
        
        PlayingCard *playingCard = (PlayingCard *) card;
        
        
        
        //SETTING UP ATTRIBUTES
        
        //SET UP COLOR OF SUIT
        UIColor *suitColor;
        UIColor *rankColor;
        
        NSDictionary *attributes = [super defaultGameMessageAttributes];
        
        UIFont *font = [attributes valueForKey:NSFontAttributeName];
        UIColor *color = [attributes valueForKey:NSForegroundColorAttributeName];
        
        if ([genString length]) {
            rankColor = color;
            suitColor = color;
        }
        else {
            rankColor = [UIColor blackColor];
            suitColor = [UIColor blackColor];
        }
        
        
        
        
        if ([playingCard.suit isEqualToString:@"♦︎"] || [playingCard.suit isEqualToString:@"♥︎"]) {
            
            suitColor = [UIColor redColor];
        }
        
        
        /*if ([genString length]) {
            NSLog([genString string]);
            id obj =[genString attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:nil];
            rankColor = obj;
        }
        
        float red, green, blue, alpha;
        
        [rankColor getRed:&red green:&green blue:&blue alpha:&alpha];
        NSLog(@"%f %f %f %f", red, green, blue, alpha);
        
        if (rankColor) {
            NSLog(@"worked");
        }*/
        
        
        
        
        
        NSDictionary *rankAttributes = @{NSFontAttributeName :font,  NSForegroundColorAttributeName : rankColor };
        NSDictionary *suitAttributes = @{NSFontAttributeName : font, NSForegroundColorAttributeName : suitColor};
        
        NSString *cardContents = playingCard.contents;
        
        NSString *rankString = [cardContents substringToIndex:[cardContents length]-2];
        
        
        NSString *suitString = [cardContents substringFromIndex:[cardContents length] -2];
        //NSLog(playingCard.suit);
        //NSLog([playingCard.contents substringFromIndex:1]);
        
       // NSLog
        
        //NSLog([cardContents substringFromIndex:[cardContents length]-2] );
        
        NSMutableAttributedString *attributedRankString = [[NSMutableAttributedString alloc] initWithString:rankString attributes:rankAttributes];
        
        NSMutableAttributedString *attributedSuitString = [[NSMutableAttributedString alloc] initWithString:suitString attributes:suitAttributes];
        [genString appendAttributedString:attributedRankString];
        [genString appendAttributedString:attributedSuitString];
        
        
        
        
        
        
        
        
        
    }
}
- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];  
}

- (NSString *) typeOfCards
{
    return @"Playing Card";
}




/*- (BOOL)determineRed:(Card *)card
{
    PlayingCard *playCard = (PlayingCard *) card;
    
    if ([playCard.suit isEqualToString:@"♥︎"] || [playCard.suit isEqualToString:@"♦︎"]) {
        return YES;
    }
    else {
        return NO;
    }
    
} */
@end
