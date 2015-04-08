//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Gaurav Verma on 6/28/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "Card.h"
#import "HistoryViewController.h"
//#import "CardGameFoundations.h"

@interface CardGameViewController ()



@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

//@property (weak, nonatomic) IBOutlet UISegmentedControl *matchButton;
//@property (strong, nonatomic) NSString *generatedString;

@property (strong, nonatomic) NSMutableArray *previousMessages;
@property (nonatomic) BOOL highScoreSet;

@end

@implementation CardGameViewController


//number of cards to match set here can be overidden, facedown default also set here can be overidden
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"High Scores"]) {
        NSDictionary *dictionary = [[NSDictionary alloc] init];
        [defaults setObject:dictionary forKey:@"High Scores"];
        [defaults synchronize];
    }
    
    
    
    
    self.shouldBeFaceDownDefault = YES;
    self.game.nCardsToMatch = self.nCardsToMatch;
    //updates UI with content before view appears for first time
    [self updateUI];
    
    
}

- (NSString *) typeOfCards
{
    if (!_typeOfCards)
    {
        _typeOfCards = @"Card Game";
    }
    
    return _typeOfCards;
}






-(int)nCardsToMatch
{
    if (!_nCardsToMatch) {
        _nCardsToMatch = 2;
    }
    
    return _nCardsToMatch;
}

// getter / sets up the NSarray of previous messages in the game
- (NSArray *)previousMessages
{
    if(!_previousMessages)
    {
        
        _previousMessages = [[NSMutableArray alloc] init];
    }
    return _previousMessages;
}


//getter for instance of self.game / creates instance using createCardGame and sets default number of cards to match to 2 if nonexistent
- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [self createCardGame];
    }
    return _game;
}



- (CardMatchingGame *)createCardGame
{
    
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
}


//abstract method used to create card deck currently returns nil
- (Deck *)createDeck
{
    return nil;  //abstract method
}


//target action for touching the redeal button, creates new instance of game and resets number of cards to match back to default
- (IBAction)touchDealButton
{
    [self setHighScore];
    self.highScoreSet = NO;
    
    self.game = nil;
    self.game = [self createCardGame];
    [self.previousMessages removeAllObjects];
    
    self.game.nCardsToMatch = self.nCardsToMatch;
    
    NSLog(@"High Score is Set: %d", self.highScoreSet);
    
    
    [self updateUI];
}

- (void) viewWillDisappear:(BOOL)animated
{
    
  //  [self setHighScore];
    
}

- (void) setHighScore
{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *highScoreDictionary = [defaults objectForKey:@"High Scores"]; //dictionary of arrays
    
    
    double timeSinceLastDate = -[self.date timeIntervalSinceNow];
    
    self.duration += timeSinceLastDate;
    
    
    
    NSString *highScoreKey = self.typeOfCards;
    
    
    NSArray *thisCardHighScoreDictionaryArray = [highScoreDictionary valueForKey:highScoreKey];
    
    
    
    NSDate *date = [NSDate date];
    self.date = date;
    
    NSNumber *duration = [NSNumber numberWithDouble:self.duration];
    NSNumber *score = [NSNumber numberWithInt:(int)self.game.score];
    NSMutableArray *thisCardHighScoreDictionaryArrayNew;
    
    if (!thisCardHighScoreDictionaryArray) {  //checks if array of this card's high score properties exists
        thisCardHighScoreDictionaryArray = [[NSArray alloc] init];
    }
    
    
    NSLog(@"About to check for Zero");
    NSLog(@"Game Score: %d", (int)self.game.score);
    if (self.game.score > 0) {
        NSLog(@"Greater Than Zero");
        if (!self.highScoreSet) {
            self.highScoreSet = YES;
            NSDictionary *highScoreProperties = @{@"Date" : date, @"Duration" : duration, @"Score" : score};
            thisCardHighScoreDictionaryArrayNew = [[NSMutableArray alloc] initWithArray:thisCardHighScoreDictionaryArray];
            
            [thisCardHighScoreDictionaryArrayNew addObject:highScoreProperties];
            
        }
        else {
            NSDictionary *mostRecentHighScoreProperties = [thisCardHighScoreDictionaryArray lastObject];
            
            int existingHighScore = (int)[[mostRecentHighScoreProperties valueForKey:@"Score"] integerValue];
            
            if (self.game.score > existingHighScore && self.highScoreSet) {
                NSDictionary *highScoreProperties = @{@"Date" : date, @"Duration" : duration, @"Score" : score};
                thisCardHighScoreDictionaryArrayNew = [[NSMutableArray alloc] initWithArray:thisCardHighScoreDictionaryArray];
                
                
                [thisCardHighScoreDictionaryArrayNew replaceObjectAtIndex:([thisCardHighScoreDictionaryArrayNew count] -1) withObject:highScoreProperties];
                
                
                
            }
        }
    }
    
    if (thisCardHighScoreDictionaryArrayNew) {
        NSMutableDictionary *newHighScoreDictionary = [[NSMutableDictionary alloc] initWithDictionary:highScoreDictionary];
        [newHighScoreDictionary setValue:thisCardHighScoreDictionaryArrayNew forKey:highScoreKey];
        [defaults setValue:newHighScoreDictionary forKey:@"High Scores"];
        [defaults synchronize];
        NSLog(@"High Score Set");
        
    }
    
    
    
    
    
    
    
    
    
}



// target action for touching card button
- (IBAction)touchCardButton:(UIButton *)sender
{
    
    //toggle for game starting
    self.game.gameStarted = YES;
    
    
    
    
    int chooseButtonIndex = (int)[self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chooseButtonIndex]; //interacting with model here
    
    //update high score
    //[self setHighScore];
    
    
    
    //finds the changed Cards in CardMatchingGame
    NSMutableArray *changedCards = self.game.cardsLastMatched;
    
    
    NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
    
    
    for (Card *card in changedCards) {
        
        // finds matched cards from the changed cards (including current card) for a match or finds all the unchosen cards from the changed cards for a mismatch (excluding current card)
        if (card.isMatched || !card.isChosen) {
            [indexes addIndex:[changedCards indexOfObject:card]];
        }
        
    }
    
    
    
    
    [self updateUI:sender]; //updating the view

    
    
    
    //(removes all cards if matched, leaves current chosen card if mismatch)
    [changedCards removeObjectsAtIndexes:indexes];
    
    
    
    
    
    
    
    
    
}

- (void)updateUI:(UIButton *) changedButton
{
    for (UIButton *cardButton in self.cardButtons) {
        
        if (cardButton == changedButton) {
            int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];
            Card *card = [self.game cardAtIndex:cardButtonIndex];
            
            
            UIViewAnimationOptions option = UIViewAnimationOptionTransitionFlipFromLeft;
            
            
            [UIView transitionWithView:cardButton duration:.25 options:option animations:^{[cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];} completion:nil];
            break;
            
        }
        
        
        
    }
    
    [self updateUI];
    
}

- (void)updateUI
{
    
    
    // loops through card buttons
    for (UIButton *cardButton in self.cardButtons) {
        
        int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        
        
        
        // sets background Image for card
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        
        // Card attributed string contents displayed on button
        NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:@""];
        
        
        // checks if cards should be face down when not chosen
        if (!self.shouldBeFaceDownDefault || (card.isChosen)) {
            [self extractCardContents:contents usingCard:card];
        }
        
        
        //sets the cardbutton attributed title to contents
        [self setCardButtonTitle:cardButton usingString:contents];
        
        
        
        cardButton.enabled = !card.isMatched;
        
    }
    
    self.gameMessage.backgroundColor = nil;
    
    //update game message
    
    
    
    //checks if game has started
    if (!self.game.gameStarted) {
        NSDictionary *attributes = [self defaultGameMessageAttributes];
        
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Welcome to Matchismo!" attributes:attributes];
        self.gameMessage.attributedText = message;
        self.gameMessage.backgroundColor = self.gameMessageBackgroundColor;
        //[self setGameMessageAttributedText];
        if (![self.previousMessages count]) {
            
            
            [self.previousMessages addObject:self.gameMessage.attributedText];
            
        }
        //[self.previousMessages removeAllObjects];
    }
    else {
        
        
        //creates message to be displayed for message sender
        NSAttributedString *textToBeSent = [self generateString];
        
        
        //sets attributed text for game message
        self.gameMessage.attributedText = textToBeSent;
        
        if (![[self.gameMessage.attributedText string] isEqualToString:@""]) {
            self.gameMessage.backgroundColor = self.gameMessageBackgroundColor;
        }
        
        
        if (![[self.gameMessage.attributedText string] isEqualToString: @""] && ([self.game.cardsLastMatched count] == self.game.nCardsToMatch)) {
            
            //self.gameMessage.backgroundColor = [UIColor whiteColor];
         
            if ([self.previousMessages count]) {
                NSAttributedString *lastAttributedString = [self.previousMessages lastObject];
                
                if ([lastAttributedString isKindOfClass:[NSAttributedString class]]) {
                    
                    
                
                    if (![[lastAttributedString string] isEqualToString:[self.gameMessage.attributedText string]]) {
                        
                    
                    
                        
                        [self.previousMessages insertObject:self.gameMessage.attributedText atIndex:0];
                    }
                }
            }
            else {
                
                [self.previousMessages insertObject:self.gameMessage.attributedText atIndex:0];
                
                
            }
        
        }
            
        
            
            
        
        
         
        
        
        
    }
    
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",(int)self.game.score]; //accessing model to update the view
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *) segue.destinationViewController;
            hvc.previousMessages = self.previousMessages;
            hvc.backgroundColor = [self gameMessageBackgroundColor];
        }
    }
}



- (NSDictionary *)defaultGameMessageAttributes
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    UIColor *color = [UIColor whiteColor];
    return @{NSFontAttributeName : font, NSForegroundColorAttributeName : color};
}

// checks if card is chosen, puts front image for chosen back image for not
// can be overidden based on game
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

// extracts card contents using default settings, system font, black color, returns @"" if contents is nil
// can be overidden by subclass for different types of cards
- (void)extractCardContents:(NSMutableAttributedString *)genString usingCard:(Card *)card
{
    
    if (card.contents) {
        NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:card.contents];
        [genString appendAttributedString:contents];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    NSDate *date = [NSDate date];
    self.date = date;
}






//sets Card button title using attributed string no need to be overidden
- (void) setCardButtonTitle:(UIButton *)cardButton usingString:(NSAttributedString *)string
{
    [cardButton setAttributedTitle:string forState:UIControlStateNormal];
}


// generates the string for game message from extract card contents for each card in cards last matched
//should not be overidden
- (NSMutableAttributedString *)generateString
{
    
    
    NSMutableAttributedString *genString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    
    //NSLog(@"generating");
    
    
    if (![self.game.cardsLastMatched count]) {
        //NSLog(@"nocards");
        return genString;
    }
    
    else if ([self.game.cardsLastMatched count] < self.game.nCardsToMatch) {
        //NSLog(@"less");
        NSDictionary *attributes = [self defaultGameMessageAttributes];
        NSMutableAttributedString *firstPart = [[NSMutableAttributedString alloc] initWithString:@"You are currently selecting" attributes:attributes];
        
        [genString appendAttributedString:firstPart];
                                                
        
        
        //NSLog([genString string]);
        
        for (Card *card in self.game.cardsLastMatched) {
            //genString = [genString stringByAppendingString:@" "];
            NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:@" " attributes:attributes];
            [genString appendAttributedString:space];
            
            //NSLog([genString string]);
            
            [self extractCardContents:genString usingCard:card];
            
            
        }
        
        
        
        
        
    }
    else {
        
        // NSMutableArray *cardStrings = [[NSMutableArray alloc] init];
        if (self.game.lastChangeInScore >0) {
            NSDictionary *attributes = [self defaultGameMessageAttributes];
            NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc] initWithString:@"You matched" attributes:attributes];
            [genString appendAttributedString:attributedMessage];
            
            
            for (Card *card in self.game.cardsLastMatched) {
                NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:@" " attributes:attributes];
                [genString appendAttributedString:space];
                
                [self extractCardContents:genString usingCard:card];
            }
            
            
            NSMutableAttributedString *gainMessage = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" for a gain of %d", self.game.lastChangeInScore] attributes:attributes];
            [genString appendAttributedString:gainMessage];
            
            
        }
        
        
        /*for (Card *card in self.game.cardsLastMatched) {
         if (card.isMatched) {
         if (card.contents) {
         [cardStrings addObject:card.contents];
         //NSLog(card.contents);
         }
         }
         }*/
        
        /*if ([cardStrings count]) {
         genString = @"You matched";
         for (NSString *cardString in cardStrings) {
         //NSLog(cardString);
         genString = [genString stringByAppendingString:@" "];
         if (cardString) {
         genString = [genString stringByAppendingString:cardString];
         }
         }
         
         NSString *secondPart = [NSString stringWithFormat:@" for a score of %d", self.game.lastChangeInScore];
         
         genString = [genString stringByAppendingString:secondPart];
         
         
         
         
         
         }*/
        
        else if (self.game.lastChangeInScore <=0){
            NSDictionary *attributes = [self defaultGameMessageAttributes];
            
            NSMutableAttributedString *misMatchMessage = [[NSMutableAttributedString alloc] initWithString:@"You mismatched" attributes:attributes];
            [genString appendAttributedString:misMatchMessage];
            
            
            for (Card *card in self.game.cardsLastMatched) {
                NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:@" " attributes:attributes];
                [genString appendAttributedString:space];
                
                [self extractCardContents:genString usingCard:card];
            }
            
            
            NSMutableAttributedString *scoreMessage = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" for a loss of %d", self.game.lastChangeInScore] attributes:attributes];
            
            [genString appendAttributedString:scoreMessage];
            
            
        }
    }
    
    return genString;
}














/*- (IBAction)dragHistorySlider:(UISlider *)sender {
 sender.value = round(sender.value);
 
 int index = (int) sender.value;
 
 if ([self.previousMessages count] > 1) {
 self.gameMessage.text = self.previousMessages[index];
 }
 
 if (self.historySlider.value < self.historySlider.maximumValue) {
 self.historySlider.alpha = .8;
 self.gameMessage.alpha = .8;
 }
 else {
 self.historySlider.alpha = 1;
 self.gameMessage.alpha = 1;
 
 }
 
 
 }*/

@end
