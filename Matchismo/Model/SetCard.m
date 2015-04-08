//
//  SetCard.m
//  Matchismo
//
//  Created by Gaurav Verma on 7/23/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "SetCard.h"

@interface SetCard ()


@end

@implementation SetCard

- (NSString *) contents
{
    
    
    
    
    
    return nil;
    
}

//card shape setter getter BEGIN

@synthesize shape = _shape;

- (void)setCardShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (NSString *)shape
{
    return _shape ? _shape : @"?";
}

// shape setter getter END


//card number setter getter BEGIN

- (void)setNumber:(NSUInteger)number
{
    if (number > 0 && number <= [SetCard maxNumber]) {
        _number = number;
    }
}

// card number setter getter END


//card color BEGIN
- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
    
}
//card color END


- (UILabel *)label
{
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        _label = label;
    }

    return _label;
}

//card shading begin

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShades] containsObject:shading]) {
        _shading = shading;
    }
}

//card shading END


//class instance methods
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    //return 1;
    
    if ([otherCards count] > 0) {
        NSMutableArray *groupOfCards = [[NSMutableArray alloc] init];
        [groupOfCards addObject:self];
        
        for (Card *card in otherCards) {
            if ([card isMemberOfClass:[SetCard class]]) {
                [groupOfCards addObject:(SetCard *)card];
            }
        }
        
        int maxnumbercount = 0;
        int maxcolorcount = 0;
        int maxshapecount = 0;
        int maxshadingcount = 0;
        
        NSUInteger maxNumber = [SetCard maxNumber];
        NSArray *validColors = [SetCard validColors];
        NSArray *validShapes = [SetCard validShapes];
        NSArray *validShades = [SetCard validShades];
        
        
        for (int i = 1; i <= maxNumber; i++) {
            int thisNumberCount = 0;
            for (SetCard *setCard in groupOfCards) {
                if (setCard.number == i) {
                    thisNumberCount++;
                    //NSLog(@"%d thisNumberCount  %d setCardnumber", thisNumberCount, setCard.number);
                }
            }
            
            if (thisNumberCount > maxnumbercount) {
                maxnumbercount = thisNumberCount;
            }
            
            
        }
        
        //NSLog(@"%d maxnumbercount",maxnumbercount);
        
        for (NSString *color in validColors) {
            int thisColorCount = 0;
            for (SetCard *setCard in groupOfCards) {
                if ([setCard.color isEqualToString:color]) {
                    thisColorCount++;
                }
            }
            
            if (thisColorCount > maxcolorcount) {
                maxcolorcount = thisColorCount;
            }
        }
        
        for (NSString *shape in validShapes) {
            int thisShapeCount = 0;
            for (SetCard *setCard in groupOfCards) {
                if ([setCard.shape isEqualToString:shape]) {
                    thisShapeCount++;
                }
            }
            
            if (thisShapeCount > maxshapecount) {
                maxshapecount = thisShapeCount;
            }
        }
        
        for (NSString *shading in validShades) {
            int thisShadingCount = 0;
            for (SetCard *setCard in groupOfCards) {
                if ([setCard.shading isEqualToString:shading]) {
                    thisShadingCount++;
                }
            }
            
            if (thisShadingCount > maxshadingcount) {
                maxshadingcount = thisShadingCount;
            }
        }
        
        if (maxshadingcount && maxnumbercount && maxcolorcount && maxshapecount) {
            
            double multiple = maxnumbercount * maxcolorcount * maxshapecount * maxshadingcount;
            double exponent = log(multiple)/log([groupOfCards count]);
            
            if (exponent == (int) exponent) {
                score = 14;
            }
            
        }
            
            
            
        
        
        
        
    }
    
    return score;
    
}



//class methods for retrieving card standard properties

+ (NSArray *)validColors
{
    return @[@"redColor",@"blueColor",@"purpleColor"];
}

+ (NSArray *)validShades
{
    return @[@"solid",@"striped",@"blank"];
}

+ (NSArray *)validShapes
{
    
    
    
    return @[@"◉",@"▲",@"◼︎"];
}


+ (NSUInteger)maxNumber
{
    return ([[SetCard validShapes] count]);
}





@end
