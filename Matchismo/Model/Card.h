//
//  Card.h
//  Matchismo
//
//  Created by Gaurav Verma on 6/29/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import <Foundation/Foundation.h>






@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;

//protected method
- (double) combinatoric:(double)nAvailable usingNumber:(double)nChosen;






@end
