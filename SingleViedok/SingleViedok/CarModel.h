//
//  CarModel.h
//  SingleViedok
//
//  Created by LIM on 16.03.2015.
//  Copyright (c) 2015 LIM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject<NSCopying,NSCoding>
{
    NSString * carName;
    NSString * carMark;
    NSNumber * carYear;
    NSNumber * carId;
}
-(id) init;
-(id) initWithName:(NSString*)name model:(NSString*)model year:(NSNumber*)year key:(NSNumber*) key;

-(NSNumber*)getId;
-(NSString *)getName;
-(NSString*)description;

@end
