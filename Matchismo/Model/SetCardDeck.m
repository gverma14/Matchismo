//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Gaurav Verma on 7/23/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSString *color in [SetCard validColors]) {
            for (NSString *shape in [SetCard validShapes]) {
                for (NSString *shading in [SetCard validShades]) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.shape = shape;
                        card.shading = shading;
                        card.number = 1;
                        
                        [self addCard:card];
                        
                    }
                }
            }
        }
    }
    
    
    
    
    return self;
}

@end
