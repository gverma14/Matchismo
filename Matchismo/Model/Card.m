//
//  Card.m
//  Matchismo
//
//  Created by Gaurav Verma on 6/29/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    
    return score;
}

- (double) combinatoric:(double)nAvailable usingNumber:(double)nChosen
{
    if (nChosen <= nAvailable) {
        // NSLog(@"%ld", nAvailable);
        
        
        return ([self factorial:nAvailable]/([self factorial:nChosen]*[self factorial:(nAvailable-nChosen)]));
        
    }
    
    
    return 0;
    
}



- (double) factorial:(double)number
{
    double fact = 1;
    if (number == 0) {
        return 1;
    }
    else {
        
        for (double i = number; i > 0; i--) {
            fact *= i;
        }
    }
    
    return fact;
}




@end
