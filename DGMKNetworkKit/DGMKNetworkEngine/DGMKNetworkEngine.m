//
//  DGMKNetworkEngine.m
//  DGMKNetworkKit
//
//  Created by Gavin on 16/3/16.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "DGMKNetworkEngine.h"

@implementation DGMKNetworkEngine

-(id)initWithDefaultSettings{
    
    if(self = [super initWithHostName:DGMKNetworkKit_BaseURL
                   customHeaderFields:@{
                                        @"x-client-identifier" : @"iOS"
                                        }]) {
        
    }
    return self;
}

#pragma mark - Get Method
- (MKNetworkOperation*)getDataWithPath:(NSString*)urlString
                     CompletionHandler:(ResponseBlock)completionBlock
                          ErrorHandler:(MKNKErrorBlock)errorBlock{
    MKNetworkOperation *op=[self operationWithPath:urlString params:nil httpMethod:@"GET"];
    [op setFreezable:YES];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         // the completionBlock will be called twice.
         // if you are interested only in new values, move that code within the else block
         NSString *value=[completedOperation responseString];
         
         if([completedOperation isCachedResponse]) {
             DLog(@"Data from cache %@", value);
         }
         else {
             DLog(@"Data from server %@", value);
         }
         
         completionBlock(value);
         
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}

#pragma mark - Post Method
- (MKNetworkOperation*)postDataWithPath:(NSString*)urlString
                                 params:(NSDictionary*)body
                      completionHandler:(ResponseBlock)completionBlock
                           errorHandler:(MKNKErrorBlock)errorBlock{
    MKNetworkOperation *op=[self operationWithPath:urlString params:body httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         // the completionBlock will be called twice.
         // if you are interested only in new values, move that code within the else block
         NSString *value=[completedOperation responseString];
         
         if([completedOperation isCachedResponse]) {
             DLog(@"Data from cache %@", value);
         }
         else {
             DLog(@"Data from server %@", value);
         }
         
         completionBlock(value);
         
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}

#pragma mark - Upload Method
- (MKNetworkOperation*) uploadWithPath:(NSString*)urlString
                                params:(NSDictionary*)body
                                  file:(NSString*)file
                     completionHandler:(ResponseBlock)completionBlock
                          errorHandler:(MKNKErrorBlock)errorBlock{
    MKNetworkOperation *op = [self operationWithPath:urlString
                                              params:body
                                          httpMethod:@"POST"];
    
    [op addFile:file forKey:@"media"];
    
    // setFreezable uploads your images after connection is restored!
    [op setFreezable:YES];
    
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSString *value = [completedOperation responseString];
        
        completionBlock(value);
    }errorHandler:^(MKNetworkOperation *errorOp, NSError* error){
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
    return op;
    
}

#pragma mark - Download Method
-(MKNetworkOperation*)downloadFatAssFileFrom:(NSString*) remoteURL
                                       toFile:(NSString*) filePath {
    
    MKNetworkOperation *op = [self operationWithURLString:remoteURL];
    [op setFreezable:YES];
    [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath
                                                            append:YES]];
    
    [self enqueueOperation:op];
    return op;
}

#pragma mark - emptyCache
-(void) emptyCache{
    [super emptyCache];
}

@end
