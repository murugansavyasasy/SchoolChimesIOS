
#define  Aurtorizartion  @"bearer 123456789" // replace 123456789 with your token, bearer text will be there
#define  accept  @"application/vnd.vimeo.*+json; version=3.2"

#import "Vimeo_uploader.h"

@implementation Vimeo_uploader


+(id)SharedManger{

    static Vimeo_uploader *Vimeouploader = nil;
    @synchronized (self) {
        static dispatch_once_t oncetoken;
        dispatch_once(&oncetoken, ^{
            Vimeouploader = [[self alloc] init];
        });
    }
    return Vimeouploader;
}

-(id)init{

    if (self = [super init]) {

    }
    return self;
}

- (void)pass_data_header:(NSData *)videoData{

    NSString *tmpUrl=[[NSString alloc]initWithFormat:@"https://api.vimeo.com/me/videos?type=streaming&redirect_url=&upgrade_to_1080=false"];

    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:tmpUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    [request setHTTPMethod:@"POST"];
    [request setValue:Aurtorizartion forHTTPHeaderField:@"Authorization"];
    [request setValue:accept forHTTPHeaderField:@"Accept"];//change this according to your need.
    NSError *error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: &error];
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:&error];

//    if (!error) {
//        [self call_for_ticket:[json valueForKey:@"upload_link_secure"] complet_url:[json valueForKey:@"complete_uri"] videoData:videoData];
//
//    }else{
//        NSLog(@"RESPONSE--->%@",json);
//    }


}
- (void)call_for_ticket:(NSString *)upload_url complet_url:(NSString *)complet_uri videoData:(NSData *)videoData{


    NSURLSessionConfiguration *configuration;
    //configuration.timeoutIntervalForRequest = 5;
    //configuration.timeoutIntervalForResource = 5;
    configuration.HTTPMaximumConnectionsPerHost = 1;
    configuration.allowsCellularAccess = YES;
   // configuration.networkServiceType = NSURLNetworkServiceTypeBackground;
    configuration.discretionary = NO;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];


    NSURL *url = [NSURL URLWithString:upload_url];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"PUT"];
    [urlRequest setTimeoutInterval:0];
    [urlRequest setValue:Aurtorizartion forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:accept forHTTPHeaderField:@"Accept"];
    NSError *error;

    NSString *str_lenth = [NSString stringWithFormat:@"%lu",(unsigned long)videoData.length];
    NSDictionary *dict = @{@"str_lenth":str_lenth,
                           @"Content-Type":@"video/mp4"};
    NSData *postData12 = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    [urlRequest setHTTPBody:postData12];
   // [urlRequest setHTTPBody:videoData];



    // You could try use uploadTaskWithRequest fromData
    NSURLSessionUploadTask *taskUpload = [session uploadTaskWithRequest:urlRequest fromData:videoData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        if (!error && httpResp.statusCode == 200) {
             [self call_complete_uri:complet_uri];
        } else {
            if([self.delegate respondsToSelector:@selector(vimeouploader_error:methodName:)]){
                [self.delegate vimeouploader_error:error methodName:@"vimeo"];}
            NSLog(@"ERROR: %@ AND HTTPREST ERROR : %ld", error, (long)httpResp.statusCode);
        }
    }];
    [taskUpload resume];


}
-(void)call_complete_uri:(NSString *)complettion_url{


    NSString *str_url =[NSString stringWithFormat:@"https://api.vimeo.com%@",complettion_url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    [request setHTTPMethod:@"DELETE"];
    [request setValue:Aurtorizartion forHTTPHeaderField:@"Authorization"];
    [request setValue:accept forHTTPHeaderField:@"Accept"];
    //change this according to your need.

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
           if ([httpResponse statusCode] == 201) {
               NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:[httpResponse allHeaderFields]];
               if (dict) {
                   if([self.delegate respondsToSelector:@selector(vimeouploader_succes:methodName:)]){
                     //  [self.delegate vimeouploader_succes:[dict valueForKey:@"Location"] methodName:@"vimeo"];
                       NSLog(@"sucesses");

                       NSString *str = [NSString stringWithFormat:@"title"];
                       [self Give_title_to_video:[dict valueForKey:@"Location"] With_name:str];



                   }else{
                       if([self.delegate respondsToSelector:@selector(vimeouploader_error:methodName:)]){
                           [self.delegate vimeouploader_error:error methodName:@"vimeo"];}
                   }
               }
           }else{
               //9
               if([self.delegate respondsToSelector:@selector(vimeouploader_error:methodName:)]){
                   [self.delegate vimeouploader_error:error methodName:@"vimeo"];}
               NSLog(@"%@",error.localizedDescription);
           }
    }];

}
- (void)Give_title_to_video:(NSString *)VIdeo_id With_name:(NSString *)name {

    NSString *tmpUrl=[[NSString alloc]initWithFormat:@"https://api.vimeo.com%@",VIdeo_id];

    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:tmpUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    [request setHTTPMethod:@"PATCH"];
    [request setValue:Aurtorizartion forHTTPHeaderField:@"Authorization"];
    [request setValue:accept forHTTPHeaderField:@"Accept"];//change this according to your need.
    NSError *error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: &error];
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:&error];
     NSString *str_description =  @"description";
    NSDictionary *dict = @{@"name":name,
                           @"description":str_description,
                           @"review_link":@"false"
                           };

    NSData *postData12 = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    [request setHTTPBody:postData12];

    if (!error) {
         NSLog(@"RESPONSE--->%@",json);

         [self.delegate vimeouploader_succes:[json valueForKey:@"link"] methodName:@"vimeo"];
    }else{
        if([self.delegate respondsToSelector:@selector(vimeouploader_error:methodName:)]){
            [self.delegate vimeouploader_error:error methodName:@"vimeo"];}
        //NSLog(@"%@",error.localizedDescription);
        NSLog(@"Give_title_to_video_error--->%@",error);
    }


}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {

    NSLog(@"didSendBodyData: %lld, totalBytesSent: %lld, totalBytesExpectedToSend: %lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
    if([self.delegate respondsToSelector:@selector(vimeouploader_progress:totalBytesExpectedToSend:)]){
        [self.delegate vimeouploader_progress:totalBytesSent totalBytesExpectedToSend:totalBytesExpectedToSend];}
}



- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error == nil) {
        NSLog(@"Task: %@ upload complete", task);
    } else {
        NSLog(@"Task: %@ upload with error: %@", task, [error localizedDescription]);
    }
}
@end
