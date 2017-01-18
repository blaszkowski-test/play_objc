//
//  CarModel.m
//  SingleViedok
//
//  Created by LIM on 16.03.2015.
//  Copyright (c) 2015 LIM. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel

-(id)init
{
    self = [super init];
    
    return self;
}

-(id) initWithName:(NSString*)name model:(NSString*)model year:(NSNumber*)year key:(NSNumber*) key
{
    self = [super init];
    
    if(self)
    {
        carName = [name copy];
        carMark = [model copy];
        carYear = [year copy];
        carId = [key copy];
    }
    
    return self;
}

-(id) copyWithZone:(NSZone *)zone
{
    id newObj = [[[self class] allocWithZone:zone] initWithName:carName model:carMark year:carYear key:carId];
    return newObj;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:carName forKey:@"carName"];
    [aCoder encodeObject:carMark forKey:@"carMark"];
    [aCoder encodeObject:carYear forKey:@"carYear"];
    [aCoder encodeObject:carId forKey:@"carId"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    carName = [aDecoder decodeObjectForKey:@"carName"];
    carMark = [aDecoder decodeObjectForKey:@"carMark"];
    carYear = [aDecoder decodeObjectForKey:@"carYear"];
    carId = [aDecoder decodeObjectForKey:@"carId"];
    
    return self;
}

-(NSNumber*)getId
{
    return carId;
}

-(NSString*) getName
{
    return [NSString stringWithFormat:@"%@ %@",carName,carMark];
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@",carName,carMark];
}
@end