//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Gaurav Verma on 6/28/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

//abstract class should be filled in
@interface CardGameViewController : UIViewController


//abstract method should be filled in
- (Deck *)createDeck;

//protected methods
- (UIImage *)backgroundImageForCard:(Card *)card;

//- (UIColor *) gameMessageBackgroundColor;


//protected should be overidden
@property (strong, nonatomic) NSString *typeOfCards;

- (void)viewDidLoad;

@property (nonatomic) int nCardsToMatch;


//used for updating UI should not need to be overidden, use extract Card Contents
- (void)updateUI;
@property (strong, nonatomic) UIColor *gameMessageBackgroundColor;
//- (NSAttributedString *)generateString;
- (void)extractCardContents:(NSMutableAttributedString *)genString usingCard:(Card *)card;
@property (weak, nonatomic) IBOutlet UILabel *gameMessage;
- (NSMutableAttributedString *)generateString;
- (NSDictionary *)defaultGameMessageAttributes;

- (void) setHighScore;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) double duration;

//checks if card is chosen, if it is, then sets the title
//- (void) setCardButtonTitle:(UIButton *)cardButton usingString:(NSAttributedString *)string;

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) BOOL shouldBeFaceDownDefault;
@end
