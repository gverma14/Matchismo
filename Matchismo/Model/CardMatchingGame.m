//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Gaurav Verma on 7/1/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "CardMatchingGame.h"



@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Cards
@property (nonatomic) int COST_TO_CHOOSE;
@property (nonatomic) int MISMATCH_PENALTY;
@property (nonatomic) int MATCH_BONUS;
@end

@implementation CardMatchingGame




- (NSMutableArray *) cardsLastMatched
{
    if (!_cardsLastMatched) {
        _cardsLastMatched = [[NSMutableArray alloc] init];
    }
    
    return _cardsLastMatched;
}



- (NSMutableArray *)cards
{
    if(!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}



- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i=0; i<count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
                
            }
            else {
                self = nil;
                break;
            }

        }
        
        
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count] ? self.cards[index] : nil);
}

- (void)setNCardsToMatch:(NSUInteger)nCardsToMatch
{
    _nCardsToMatch = nCardsToMatch;
    
    
    //self.MATCH_BONUS = 1;
    //self.COST_TO_CHOOSE = nCardsToMatch-1;
    //self.MISMATCH_PENALTY = round(5.0/nCardsToMatch);
    //self.MATCH_BONUS = nCardsToMatch;
    
    
}

- (int) COST_TO_CHOOSE
{
    if (self.nCardsToMatch) {  // minimum of 2 cards
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int costAddition = (int)[defaults integerForKey:@"COST_TO_CHOOSE"];
        
        if (!costAddition)
        {
            costAddition = 1; //sets to minimum cost to choose
            [defaults setInteger:costAddition forKey:@"COST_TO_CHOOSE"];
        }
        
        _COST_TO_CHOOSE = (int)self.nCardsToMatch + (costAddition - 2);
        
    }
    
    return 0;
    
    
}

- (int) MISMATCH_PENALTY
{
    if (self.nCardsToMatch) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        int mismatchSelection = (int)[defaults integerForKey:@"MISMATCH_PENALTY"];
        
        if (!mismatchSelection) {
            mismatchSelection = 1;
            [defaults setInteger:mismatchSelection forKey:@"MISMATCH_PENALTY"];
        }
        
        _MISMATCH_PENALTY = round((3*mismatchSelection)/self.nCardsToMatch);
    }
    
    return _MISMATCH_PENALTY;
}

- (int)MATCH_BONUS
{
    
    
    if (self.nCardsToMatch) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        BOOL matchBonusActivated;
        
        if ([[[defaults dictionaryRepresentation]allKeys] containsObject:@"MATCH_BONUS"]) {
            matchBonusActivated = [defaults boolForKey:@"MATCH_BONUS"];
            
        }
        else {
            matchBonusActivated = YES;
        }
        
        _MATCH_BONUS = matchBonusActivated ? (int)self.nCardsToMatch : 1;
        
        
    }
    
    return _MATCH_BONUS;
}



- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:(index)];
    //NSLg(@"change in score cardgame %d", self.lastChangeInScore);
       
    /*PlayingCard *testPlayCard = [[PlayingCard alloc] init];
    
    //[testPlayCard test];
    Card *testCard = testPlayCard;
    //[testCard test];
    
    id obj = @"aa";
    [obj test];
    */
   // UIControlStateNormal;
    
    //NS_OPTIONS(nsu, <#_name#>)
    
    /*enum : int {
        FirstOption = 1 << 0,
        SecondOption = 1 << 1,
        ThirdOption = 1 << 2
    };
    
    //enum : int tagName = { first};
    
    typedef enum : int {north = 1} direction;
    enum direction : int {northwest};
    
    
    
    int myOptions = FirstOption | SecondOption;
    myOptions = ThirdOption | FirstOption;
    
    if (myOptions & ThirdOption) {
        
        NSLog(@"%d", myOptions);
    }*/
    
    if (!card.isMatched)
    {
        if (card.isChosen) {
            card.chosen = NO;
            [self.cardsLastMatched removeObject:card];
        }
        else {
            NSMutableArray *otherChosenCards = [[NSMutableArray alloc] init];
            //match against other cards
            for (Card *otherCard in self.cards) {
                
                
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherChosenCards addObject:otherCard];
                }
            
            }
            
            
            if ([otherChosenCards count] == self.nCardsToMatch-1)
            {
                int matchScore = [card match:otherChosenCards];
                

                if (matchScore) {
                    self.score += matchScore * self.MATCH_BONUS;
                    card.matched = YES;
                    self.lastChangeInScore = matchScore*self.MATCH_BONUS;
                    for (Card *otherChosenCard in otherChosenCards) {
                        otherChosenCard.matched = YES;
                        //[self.cardsLastMatched addObject:otherChosenCard];
                    }
                }
                
                else {
                    self.score -= self.MISMATCH_PENALTY;
                    self.lastChangeInScore = -self.MISMATCH_PENALTY;
                    for (Card *otherChosenCard in otherChosenCards) {
                        otherChosenCard.chosen = NO;
                        //[self.cardsLastMatched addObject:otherChosenCard];
                    }
                }
            }
            //break;
            self.score -= self.COST_TO_CHOOSE;
            card.chosen = YES;
            [self.cardsLastMatched addObject:card];

            //NSLog(@j %d", [otherChosenCards count]);
        }
    }
}




@end

