//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Gaurav Verma on 7/1/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"


@interface CardMatchingGame : NSObject

//designated initilializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;



- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger nCardsToMatch;
@property (nonatomic, strong) NSMutableArray *cardsLastMatched;
@property (nonatomic) BOOL gameStarted;
@property (nonatomic) int lastChangeInScore;

@end


