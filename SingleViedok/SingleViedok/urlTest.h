//
//  urlTest.h
//  SingleViedok
//
//  Created by LIM on 27.12.2014.
//  Copyright (c) 2014 LIM. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol urlTestDelegate <NSObject>
@required
- (void) urlResponse: (NSMutableArray *)data;
@end

@interface urlTest : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate,NSXMLParserDelegate>
{
    id <urlTestDelegate> delegate;
    NSURLConnection * polacz;
    NSString * serverUrl;
    NSString * userUrl;
    NSString * userPassword;
    NSXMLParser * ourXml;
    NSMutableString * responseString;
    
    NSMutableArray * agentTable;
    NSMutableDictionary * agentInfo;
    NSMutableString * currentTag;
    NSMutableString * currentVale;
}
@property id delegate;
-(void) startTest;
@end
