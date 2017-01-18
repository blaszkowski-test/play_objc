#import "DbManager.h"
static DbManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DbManager

+(DbManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB{
    NSURL *docsDir;
    NSArray *dirPaths;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    // Get the documents directory
    //dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    dirPaths = [filemgr URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [[docsDir absoluteString] stringByAppendingPathComponent: @"cars.db"]];
    BOOL isSuccess = YES;
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =  "create table if not exists carsModels (id integer primary key autoincrement, model text, name text, year integer)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)!= SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table %s", errMsg);
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

- (long) saveData:(NSString*)carModel name:(NSString*)name year:(NSNumber*)year;
{
    long isOk = -1;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *insert_stmt = "insert into carsModels (model, name, year) values (?,?,?)";
        if(sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [carModel UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [name UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 3, [year intValue]);
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                isOk = (long) sqlite3_last_insert_rowid(database);
            }
          
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
    }
    return isOk;
}

- (NSMutableArray*) findByRegisterNumber:(NSNumber*)registerNumber
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *query_stmt = "select model, name, year from carsModels where id=?";
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, [registerNumber intValue]);
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *name = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                
                NSString *department = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 1)];
                
                NSNumber *year = [[NSNumber alloc]initWithInt:
                                  (int) sqlite3_column_int(statement, 2)];
                
                [resultArray addObject:department];
                [resultArray addObject:name];
                [resultArray addObject:year];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
    }
    return resultArray;
}

- (NSMutableArray*) getAll
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *query_stmt = "select id, model, name, year from carsModels";
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSNumber *dbId = [[NSNumber alloc]initWithInt:
                                  (int) sqlite3_column_int(statement, 0)];
                
                NSString *name = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 1)];
                
                NSString *model = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 2)];
                
                NSNumber *year = [[NSNumber alloc]initWithInt:
                                  (int) sqlite3_column_int(statement, 3)];
                
                CarModel * oneCar = [[CarModel alloc]initWithName:name model:model year:year key:dbId];
                
                [resultArray addObject:oneCar];             
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
    }
    return resultArray;
}

-(BOOL) deleteCar:(NSNumber*)carId
{
    BOOL status = NO;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *query_stmt = "DELETE FROM carsModels WHERE id=?";
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, [carId intValue]);
            if (sqlite3_step(statement) == SQLITE_OK)
            {
                status = YES;
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
    }
    return status;
}
@end