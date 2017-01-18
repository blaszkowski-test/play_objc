//
//  DbManager.h
//  SingleViedok
//
//  Created by LIM on 07.03.2015.
//  Copyright (c) 2015 LIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "CarModel.h"

@interface DbManager : NSObject
{
    NSString *databasePath;
}

+(DbManager*)getSharedInstance;
-(BOOL)createDB;
- (long) saveData:(NSString*)carModel name:(NSString*)name year:(NSNumber*)year;
-(NSMutableArray*) findByRegisterNumber:(NSString*)registerNumber;
-(BOOL) deleteCar:(NSNumber*)carId;
-(NSMutableArray*) getAll;

@end
