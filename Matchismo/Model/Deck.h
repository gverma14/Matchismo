//
//  Deck.h
//  Matchismo
//
//  Created by Gaurav Verma on 6/30/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
