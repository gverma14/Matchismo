//
//  PlayingCard.h
//  Matchismo
//
//  Created by Gaurav Verma on 6/30/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
//@property (nonatomic) BOOL actuallyMatched;
+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;


@end
