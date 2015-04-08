//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Gaurav Verma on 7/23/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    super.shouldBeFaceDownDefault = NO;
    super.gameMessageBackgroundColor = [UIColor colorWithWhite:1 alpha:.75];
    //super.nCardsToMatch = 3;
    
    [super updateUI];
    
}

- (NSString *) typeOfCards
{
    return  @"Set Card";
    
}

-(int)nCardsToMatch
{
    return 3;
}


- (NSDictionary *) defaultGameMessageAttributes
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    UIColor *color = [UIColor blackColor];
    //UIColor *backColor = [UIColor whiteColor];
    return @{NSFontAttributeName : font, NSForegroundColorAttributeName :color};
    
}






- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}


- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"setcardselected" : @"cardfront"];
}





- (void)extractCardContents:(NSMutableAttributedString *)genString usingCard:(Card *)card
{
    if ([card isMemberOfClass:[SetCard class]] ) {
        SetCard *setCard = (SetCard *) card;
        
//        setCard.label.text = @"abc";
//        
//        UILabel *label = setCard.label;
//        
//        label.text = @"abcd";
//        
//        
//        NSLog(setCard.label.text);
        
        
        
        //SETTING UP ALL ATTRIBUTES
        
        //SET UP COLOR
        SEL s = NSSelectorFromString(setCard.color);
        UIColor *color = [UIColor performSelector:s];
        
        
        //SET UP NUMBER
        int number = (int)setCard.number;
        
        //SET UP SHAPE
        NSString *shape = setCard.shape;
        
        
        //SET UP SHADING
        NSNumber *strokeWidth = @0;
        if ([setCard.shading isEqualToString:@"blank"]) {
            strokeWidth = @5;
        }
        
        
        float alpha = 1;
        int istrikeThroughStyle = NSUnderlineStyleNone;
        
        
        if ([setCard.shading isEqualToString:@"striped"]) {
            alpha = 1;
            istrikeThroughStyle = NSUnderlineStyleDouble;
            istrikeThroughStyle |= NSUnderlineStyleThick;
            
        }
        
        
        NSNumber *strikeThroughStyle = [NSNumber numberWithInt:istrikeThroughStyle];
        
        //SET UP FONT SIZE
        float fontSize = 19;
        
        if (number < [SetCard maxNumber]) {
            fontSize = 21;
        }
        
        
        
        //FINALIZE VALUES
        
        color = [color colorWithAlphaComponent:alpha];
        
        
        
        NSString *message = @"";
        for (int i = 1; i <= number; i++) {
            
            message = [message stringByAppendingString:shape];
            
        }
        
        
        /*SEL colorSelector = NSSelectorFromString(@"redColor");
         [UIColor performSelector:colorSelector];*/
        
        
        UIFont *font = [UIFont systemFontOfSize:fontSize];
        
        
        //create attributes dictionary
        NSDictionary *attributes = @{NSFontAttributeName : font,  NSForegroundColorAttributeName : color,  NSStrokeWidthAttributeName : strokeWidth, NSStrokeColorAttributeName : color, NSStrikethroughStyleAttributeName : strikeThroughStyle, NSStrikethroughColorAttributeName : [UIColor whiteColor]};
        
        //create attributed string
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:message attributes:attributes];
        
        
        
        
        
        [genString appendAttributedString:string];
        
        
    }
    
}






@end
