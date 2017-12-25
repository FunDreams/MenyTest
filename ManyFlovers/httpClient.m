//
//  httpClient.m
//  ManyFlowers
//
//  Created by Konstantin on 08.02.16.
//  Copyright © 2016 Olga. All rights reserved.
//

#import "httpClient.h"

@interface httpClient (){
    NSURLSessionDownloadTask *download;
    
}
@property (nonatomic, strong)NSURLSession *backgroundSession;
@end

@implementation httpClient
@synthesize bBusy,pDicFileBasa;

-(NSString *)GetRndName{
    
    NSString *outstring = @"";
    NSString *allLetters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
    
repeate:
    
    for (int ii=0; ii<LONG_NAME_FILE; ii++) {
        outstring = [outstring stringByAppendingString:[allLetters substringWithRange:[allLetters rangeOfComposedCharacterSequenceAtIndex:RND%[allLetters length]]]];
    }
    
    return outstring;
}

- (NSData *)LoadFileByName:(NSString *)Name
{
    NSString *Hash=[pDicFileBasa objectForKey:Name];
    
    if(Hash)
    {
        NSString *pNameFile = [appDir stringByAppendingFormat:@"/%@",Hash];
        NSData *data = [fileManager contentsAtPath:pNameFile];
        return data;
    }
    else return nil;
}

//- (BOOL)UpdateFile:(NSData *)pData name:(NSString *)Name
//}

- (BOOL)SaveFile:(NSData *)pData name:(NSString *)Name
{
    NSString *Hash=[pDicFileBasa objectForKey:Name];
    
    if(Hash)
    {
        [self DelFileByName:Name];
        return [self SaveFile:pData name:Name];
    }

    NSString *NameHash=[self GetRndName];
    NSString *pNameFile =  [appDir stringByAppendingFormat:@"/%@",NameHash];

    [pDicFileBasa setObject:NameHash forKey:Name];
    [pDicFileBasa writeToFile:plistFile atomically:YES];

    return [pData writeToFile:pNameFile atomically:NO];
}

- (BOOL)DelFileByName:(NSString *)Name
{
    NSString *Hash=[pDicFileBasa objectForKey:Name];
    
    if(Hash)
    {
        NSError *error;
        NSString *pNameFile =  [appDir stringByAppendingFormat:@"/%@",Hash];
        BOOL Rez=[fileManager removeItemAtPath:pNameFile error:&error];
        
        [pDicFileBasa removeObjectForKey:Name];
        [pDicFileBasa writeToFile:plistFile atomically:YES];
        
        return Rez;
    }
    return NO;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        bBusy=NO;
        pQueueDownLoad = [NSMutableArray array];
        NSURLSessionConfiguration *backgroundConfigurationObject =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _backgroundSession = [NSURLSession sessionWithConfiguration:backgroundConfigurationObject
                                                delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        //файловая система
        fileManager = [NSFileManager defaultManager];
        NSError *error;
        
        NSArray * tempArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [tempArray objectAtIndex:0];
        
        //общий путь
        appDir = [docsDir stringByAppendingPathComponent:@"/APP_DATA/"];
        
        //новвая директория
        if(![fileManager fileExistsAtPath:appDir])
            [fileManager createDirectoryAtPath:appDir withIntermediateDirectories:NO attributes:nil error:&error];
        
        //главный информационный файл базы данных
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        plistFile = [[paths objectAtIndex:0]
                          stringByAppendingPathComponent:@"data_info.plist"];
        
        pDicFileBasa = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFile];
        if (!pDicFileBasa) {
            pDicFileBasa = [NSMutableDictionary dictionary];
            [pDicFileBasa writeToFile:plistFile atomically:YES];
        }
    }
    return self;
}

- (void)PostSend:(NSString *)urlString Params:(NSString *)paramsString
    competition:(void (^) (NSData *result,NSURLResponse *response, NSError *error))handler
{    
    NSData *parameterData = [paramsString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", (int)[parameterData length]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    [theRequest addValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:parameterData];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSURLSessionConfiguration *defaultConfigObject =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:theRequest completionHandler:
        ^(NSData *result, NSURLResponse *response, NSError *error) {
            handler(result,response,error);
    }];
    
    [dataTask resume];
}

- (void)DownLoadData:(NSString *)url_name competition:(void (^) (NSData *result,NSString *ID, NSError *error))handler
{
    NSURL *urlt=[NSURL URLWithString:url_name];
    
    [self UpdateTaskWithPar:urlt :^(NSData *result, NSError *error) {
        handler(result,url_name,error);
    }];
}

- (void)GetData:(NSString *)url_name syn:(BOOL)syn download:(BOOL)bdload competition:(void (^) (NSData *result,NSString *ID, NSError *error))handler
{
    NSURL *urlt=[NSURL URLWithString:url_name];

    if(bdload==YES)
    {
        [self UpdateTaskWithPar:urlt :^(NSData *result, NSError *error) {
            
            if(syn==YES && error==nil)
                [self SaveFile:result name:url_name];
            
            if(result==nil)
            {
                result=[self LoadFileByName:url_name];
            }
            handler(result,url_name,error);
        }];
    }
    else
    {
        NSData *pData=[self LoadFileByName:url_name];
        
        if(pData==nil)
        {
            [self UpdateTaskWithPar:urlt :^(NSData *result, NSError *error) {
                
                if(syn==YES && error==nil)
                    [self SaveFile:result name:url_name];
                
                handler(result,url_name,error);
            }];
        }
        else
        {
            handler(pData,url_name,nil);
        }
    }
}

- (void)UpdateTaskWithPar:(NSURL *)Url :(void (^) (NSData *result,NSError *error))handler{
    
    //start a task that will download the data from the provided HTTP url
    //we pass it a 'block' completetion handler(essential a callback).
    //dataTaskWithUrl:completionHandler will fetch the data and pass it to
    //our completionHandler. passing in the data, response and any errors encountered.
    download = [_backgroundSession downloadTaskWithURL:Url
                         completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
    {
        //This current task will run in the background asynchronously. However we
        //want to process the data on the main thread of the app. This ensure
        //that any visual update will occur at the correct time. To do this,
        //we use the NSOperationQueue class to add it to the main thread.
   //     [[NSOperationQueue mainQueue] addOperationWithBlock:^{

            NSData *TmpData=nil;
            //check if we encountered an error
            if(error != nil)
            {
                NSLog(@"%@", [error localizedDescription]);
            }
            else
            {
                //get and check the HTTP status code
                NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
                if (HTTPStatusCode != 200)
                    NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
                
                TmpData= [NSData dataWithContentsOfURL:location];
            }
            [download suspend];
            handler(TmpData,error);
    }];
    
    //the task will not will without calling this
    [download resume];
}


- (IBAction)downloadFile:(id)sender {
}
- (IBAction)pauseDownload:(id)sender {
    [download suspend];
}
- (IBAction)resumeDownload:(id)sender {
        [download resume];
}
- (IBAction)cancelDownload:(id)sender {
        [download cancel];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{}

//- (void)AddToDownLoadData:(NSURL *)urlt dic:(NSData *)result
//{
//    NSData *pData=[self LoadFileByName:(NSString*)urlt];
//
//    if(pData==nil)
//    {
//        NSArray *TmpSet=[NSArray arrayWithObjects:TypeInfo_Data,urlt,result,@"Syn=YES",nil];
//        [pQueueDownLoad addObject:TmpSet];
//        [self UpdateTask];
//    }
//    else
//    {
////        [self LoadFileByName:(NSString *)urlt];
//    }
//}
//
//- (void)AddToDownLoadJson:(NSURL *)urlt dic:(NSMutableDictionary *)result
//{
//    NSArray *TmpSet=[NSArray arrayWithObjects:TypeInfo_Json,urlt,result,@"Syn=YES",nil];
//    [pQueueDownLoad addObject:TmpSet];
//    [self UpdateTask];
//}
//
//- (void)AddToDownLoadImage:(NSURL *)urlt impView:(UIImage *)img
//{
//    NSSet *TmpSet=[NSSet setWithObjects:TypeInfo_Img,urlt,img,@"Syn=YES",nil];
//    [pQueueDownLoad addObject:TmpSet];
//    [self UpdateTask];
//}



//
//
//- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
//{
////    [self.progressView setProgress:(double)totalBytesWritten/(double)totalBytesExpectedToWrite
////                          animated:YES];
//}
//
//
//- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
//{
////    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Downloader" message:@"Download is resumed successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
////    [alert show];
//}
//
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
//
//    
//    if (error) {
//        download = nil;
//
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Downloader" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    else
//    {
//        [download suspend];
//        [pQueueDownLoad removeObjectAtIndex:0];
//        [self UpdateTask];
//    }
//}

@end

