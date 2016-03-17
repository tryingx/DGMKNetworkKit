//
//  DGMKNetworkEngine.h
//  DGMKNetworkKit
//
//  Created by Gavin on 16/3/16.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "MKNetworkEngine.h"

// 项目打包上线都不会打印日志，因此可放心。
#ifdef DEBUG
#define DGAppLog(s, ... ) NSLog( @"[%@：in line: %d]-->%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DGAppLog(s, ... )
#endif

#define DGMKNetworkKit_BaseURL @"www.tryingx.com"

typedef void (^ResponseBlock)(NSString *responseString);

@interface DGMKNetworkEngine : MKNetworkEngine

/**
 *  指定BaseUrl
 *
 *  @return MKNetworkEngine
 */
- (id)initWithDefaultSettings;

/**
 *  Get 请求
 *
 *  @param urlString       Url地址
 *  @param completionBlock 请求完成回调Block
 *  @param errorBlock      请求错误回调Block
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation*)getDataWithPath:(NSString*)urlString
                    completionHandler:(ResponseBlock)completionBlock
                         errorHandler:(MKNKErrorBlock)errorBlock;

/**
 *  Post 请求
 *
 *  @param urlString       Url地址
 *  @param params          参数字典
 *  @param completionBlock 请求完成回调Block
 *  @param errorBlock      请求错误回调Block
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation*)postDataWithPath:(NSString*)urlString
                                params:(NSDictionary*)body
                     completionHandler:(ResponseBlock)completionBlock
                          errorHandler:(MKNKErrorBlock)errorBlock;

/*----
 NSString *file = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/SampleImage.jpg"];
 ----*/
/**
 *  上传文件
 *
 *  @param urlString       文件地址
 *  @param params          参数字典
 *  @param file            文件类型
 *  @param completionBlock 请求完成回调Block
 *  @param errorBlock      请求错误回调Block
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation*)uploadWithPath:(NSString*)urlString
                               params:(NSDictionary*)body
                                 file:(NSString*)file
                    completionHandler:(ResponseBlock)completionBlock
                         errorHandler:(MKNKErrorBlock)errorBlock;

/*----
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
 NSString *cachesDirectory = paths[0];
 NSString *filePath = [cachesDirectory stringByAppendingPathComponent:@"DownloadedFile.pdf"];
 ----*/
/**
 *  下载文件
 *
 *  @param remoteURL 下载Url地址
 *  @param filePath  文件存放地址
 *
 *  @return MKNetworkOperation
 */
- (MKNetworkOperation*)downloadFatAssFileFrom:(NSString*)remoteURL
                                       toFile:(NSString*)filePath;
/**
 *  清空缓存
 */
- (void)emptyCache;

@end
