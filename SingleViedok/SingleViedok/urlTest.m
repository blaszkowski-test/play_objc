//
//  urlTest.m
//  SingleViedok
//
//  Created by LIM on 27.12.2014.
//  Copyright (c) 2014 LIM. All rights reserved.
//

#import "urlTest.h"

@implementation urlTest

@synthesize delegate;

- (id) init
{
    self = [super init];
    
    responseString = [[NSMutableString alloc]init];
    agentTable = [[NSMutableArray alloc] init];
    currentTag = [[NSMutableString alloc]init];
    currentVale = [[NSMutableString alloc] init];
    
    return self;
}

- (void) startTest
{
    serverUrl = @"http://184.106.1.48/skyslopeApi/AgentsInMLSOffice.php?mls_org=njgsmls";
    userUrl = @"Exit";
    userPassword = @"test";
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:serverUrl]];
    polacz = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [responseString appendString:[parseError description]];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"agent"])
    {
        agentInfo = [[NSMutableDictionary alloc] init];
    }
    else if(agentInfo != nil)
    {
        [currentTag setString:elementName];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
   
    if([elementName isEqualToString:@"agent"])
    {
        [agentTable addObject:agentInfo];
        agentInfo = nil;
    }
    else if(agentInfo != nil)
    {
        [agentInfo setObject:[currentVale copy] forKey:[currentTag copy]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    if(agentInfo != nil)
    {
        [currentVale setString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [[self delegate] urlResponse:agentTable];
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        NSLog(@"Trust Challenge Requested!");
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
        
    }
    else if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic])
    {
        NSLog(@"HTTP Auth Challenge Requested!");
        NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:userUrl password:userPassword persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        credential = nil;
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    
    ourXml = [[NSXMLParser alloc] initWithData:data];
    [ourXml setDelegate:self];
    [ourXml parse];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error description]);

}

@end