//
//  httpClient.h
//  ManyFlowers
//
//  Created by Konstantin on 08.02.16.
//  Copyright © 2016 Olga. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define TypeInfo_Data @"data"
#define TypeInfo_Img  @"img"
#define TypeInfo_Json @"json"

#define LONG_NAME_FILE 25
#define RND arc4random()

@interface httpClient : NSObject <NSURLSessionDownloadDelegate>
{
    bool bConnect;
    bool bError;
    bool bDataRecive;
    
    NSMutableData *pAlldata;
    NSMutableData *responseData;
    
    NSMutableArray *pQueueDownLoad;
    NSMutableArray *pDataBasaFile;
    NSFileManager *fileManager;
    NSString *appDir;
    NSString* plistFile;
}

@property (strong, nonatomic) NSMutableDictionary *pDicFileBasa;
@property (nonatomic) BOOL bBusy;


//- (void)AddToDownLoadJson:(NSURL *)urlt dic:(NSMutableDictionary *)result;
//- (void)AddToDownLoadImage:(NSURL *)urlt impView:(UIImage *)img;
//- (void)AddToDownLoadData:(NSURL *)urlt dic:(NSData *)result;

- (void)UpdateTaskWithPar:(NSURL *)Url :(void (^) (NSData *result,NSError *error))handler;
- (void)GetData:(NSString *)url_name syn:(BOOL)syn download:(BOOL)bdload competition:(void (^) (NSData *result,NSString *ID, NSError *error))handler;
- (void)DownLoadData:(NSString *)url_name competition:(void (^) (NSData *result,NSString *ID, NSError *error))handler;

- (NSData *)LoadFileByName:(NSString *)Name;
- (BOOL)SaveFile:(NSData *)pData name:(NSString *)Name;
- (BOOL)DelFileByName:(NSString *)Name;

- (void)PostSend:(NSString *)urlString Params:(NSString *)paramsString
     competition:(void (^) (NSData *result,NSURLResponse *response, NSError *error))handler;


- (id)init;


@end
