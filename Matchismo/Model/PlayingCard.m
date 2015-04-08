//
//  PlayingCard.m
//  Matchismo
//
//  Created by Gaurav Verma on 6/30/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "PlayingCard.h"


@interface PlayingCard()
@property (nonatomic) double matchWeight;
@end

@implementation PlayingCard

- (NSString *) contents
{
    NSArray *rankStrings = [[self class] rankStrings];
    //NSLog(@"%.f",[self combinatoric:52 usingNumber:5]);
   // NSLog(@"%.f", [self factorial:16]);
    
    
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    
}

- (void) setChosen:(BOOL)chosen
{
    super.chosen = chosen;
    
    if (self.matchWeight < .02) {
        self.matchWeight = .01;
    }
    else if (chosen == NO) {
        self.matchWeight -= .01;
    }
    
    
    
   // NSLog(@"match weight %f", self.matchWeight);
    
}

- (double) matchWeight
{
    if (!_matchWeight) {
        _matchWeight = .5;
    }
    
    
    return _matchWeight;
}


@synthesize suit = _suit; //because we provided setter AND getter


//suit setter
- (void)setSuit:(NSString *)suit
{
    if([[[self class] validSuits] containsObject:(suit)]){
        _suit = suit;
    }
    
    

}

//suit getter
- (NSString *)suit
{
    return _suit ? _suit : @"?"; //if _suit exists return _suit, else return "?"
}


//returns array of valid suits
+ (NSArray *)validSuits
{
    return @[@"♥︎", @"♣︎", @"♦︎", @"♠︎"];

}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[[self class] rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [[self class] maxRank]) {
        _rank = rank;
    }
}


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] > 0) {
        
        
        
        NSMutableArray *groupOfCards = [[NSMutableArray alloc] init];
        [groupOfCards addObject:self];
        
        for (PlayingCard *playCard in otherCards) {
            [groupOfCards addObject:playCard];
        }
        double matchWeightSum = 0;
        for (PlayingCard *card in groupOfCards) {
            matchWeightSum += card.matchWeight;
        }
        
        double avgMatchWeight = matchWeightSum/[groupOfCards count];
        
        
        for (int i = 1; i <=13; i++) {
            int rankCount = 0;
            for (PlayingCard *card in groupOfCards) {
                if (card.rank == i) {
                    rankCount++;
                    //card.actuallyMatched = YES;
                }
            }
            
            if (rankCount > 1) {
                if (rankCount < [groupOfCards count]){
                    double final = avgMatchWeight*1/([self combinatoric:13 usingNumber:1]*[self combinatoric:4 usingNumber:rankCount] *[self combinatoric:12 usingNumber:([groupOfCards count] - rankCount)]*([groupOfCards count] - rankCount)*[self combinatoric:4 usingNumber:1]/[self combinatoric:52 usingNumber:[groupOfCards count]]);
                    
                    int finalround = (int) ceil(final);
                    //NSLog(@"final %d", finalround);
                    score+= finalround;
                    
                }
                else {
                    double final = avgMatchWeight*1/([self combinatoric:13 usingNumber:1]*[self combinatoric:4 usingNumber:rankCount]/[self combinatoric:52 usingNumber:[groupOfCards count]]);
                    
                    int finalround = (int) ceil((final));
                    //NSLog(@"final %d", finalround);
                    score+= finalround;
                    
                }
            }
        }
        
        NSArray *suits = [PlayingCard validSuits];
        
        for (NSString *suit in suits) {
            int suitCount = 0;
            for (PlayingCard *card in groupOfCards) {
                if ([card.suit isEqualToString:suit]) {
                    suitCount++;
                    //card.actuallyMatched = YES;
                }
                
            }
            
            if (suitCount > 1) {
                if (suitCount < [groupOfCards count]) {
                    double final = avgMatchWeight*1/([self combinatoric:4 usingNumber:1]*[self combinatoric:13 usingNumber:suitCount]*[self combinatoric:3 usingNumber:([groupOfCards count] - suitCount)]*([groupOfCards count] -suitCount)*[self combinatoric:13 usingNumber:1]/[self combinatoric:52 usingNumber:[groupOfCards count]]);
                    
                    int finalround = (int) ceil((final));
                   // NSLog(@"final %d", finalround);
                    score+= finalround;
                }
                else {
                    double final = avgMatchWeight*1/([self combinatoric:4 usingNumber:1] * [self combinatoric:13 usingNumber:suitCount]/[self combinatoric:52 usingNumber:[groupOfCards count]]);
                    
                    int finalround = (int) ceil(final);
                   // NSLog(@"final %d", finalround);
                    score+= finalround;
                }
            }
        }
        
        
        
       // NSLog(@"Avg Weight %f", avgMatchWeight);
        
    }

    return score;
    
}



@end
