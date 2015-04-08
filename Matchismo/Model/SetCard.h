//
//  SetCard.h
//  Matchismo
//
//  Created by Gaurav Verma on 7/23/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

+ (NSArray *)validShapes;
+ (NSUInteger)maxNumber;
+ (NSArray *)validColors;
+ (NSArray *)validShades;

//typedef enum {solid, striped, blank} shading;
//typedef enum {shapeColorRed, shapeColorGreen, shapeColorBlue} shapeColor;
@property (nonatomic, strong) NSString *color;
@property (strong, nonatomic) NSString *shape;
@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) NSString *shading;


@property (nonatomic, strong) UILabel *label;

@end
