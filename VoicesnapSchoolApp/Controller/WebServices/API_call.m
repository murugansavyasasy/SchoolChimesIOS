//
//  API_call.m
//  BrianVickers
//
//  Created by Rifluxyss on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "API_call.h"

#import "Constants.h"


@implementation API_call
@synthesize receivedData;
@synthesize delegate;
@synthesize strapiname;


//#define  Aurtorizartion  @"bearer 031097f31f782ace6fc9669fd84ef393" // replace 123456789 with your token, bearer text will be there
#define  accept  @"application/vnd.vimeo.*+json; version=3.2"

#pragma mark JSON Parsing

-(void)callPassParms:(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData{
    
    
    NSString *requestStringer = [NSString stringWithFormat:@"%@%@",LIVE_DOMAIN,APPINSERTREPLY];
    
    NSMutableData *body = [NSMutableData data];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestStringer]];
    
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@.png\"\r\n", @"sign"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:feedURLString forKey:@"Info"];
    
    [body appendData:[self createFormData:dict withBoundary:boundary]];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        
        UIAlertController * alert = [UIAlertController
                        alertControllerWithTitle:@"Timout error."
                                         message:@"Ok"
                                  preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Timout error." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//        [alert show];
    }
}

-(void) GETFunction:(NSString *)feedURLString :(NSString *)apiname {
    @try{
        
        self.strapiname=apiname;
        [Constants printLogKey:@"*** API_URL" printValue:feedURLString];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:feedURLString]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
        
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (conn) {
            receivedData=[[NSMutableData alloc]init];
            
        }
        else{
            
            UIAlertController * alert = [UIAlertController
                            alertControllerWithTitle:@"Unable to connect to remote server, please check your network settings and try again"
                                             message:@""
                                         
                                      preferredStyle:UIAlertControllerStyleAlert];
        
//            UIAlertView * alert_error = [[UIAlertView alloc] initWithTitle:@"Unable to connect to remote server, please check your network settings and try again" message:@"" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//            [alert_error show];
        }
    }
    
    @catch (NSException *e) {
        [Constants printLogKey:@"*** Exception %@" printValue:e];
        //NSLog(@"Exception %@", e);
    }
}

-(void) callRazorPayment:(NSString *)feedURLString :(NSString *)postParams :(NSString *)token :(NSString *)apiname; {
    @try{
        
        self.strapiname=apiname;
        
        NSData *data = [postParams dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *requestDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [Constants printLogKey:@"*** API_URL" printValue:feedURLString];
        [Constants printLogKey:@"*** Request Params\n" printValue:requestDictionary];
        
        NSData *postData = [postParams dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:feedURLString]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
        
        NSString *postLength = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)[postData length]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:token forHTTPHeaderField:@"Authorization"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (conn) {
            receivedData=[[NSMutableData alloc]init];
            
        }
        else{
            
            UIAlertController * alert = [UIAlertController
                            alertControllerWithTitle:@"Unable to connect to remote server, please check your network settings and try again"
                                             message:@""
                                      preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertView * alert_error = [[UIAlertView alloc] initWithTitle:@"Unable to connect to remote server, please check your network settings and try again" message:@"" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//            [alert_error show];
        }
    }
    
    @catch (NSException *e) {
        [Constants printLogKey:@"*** Exception %@" printValue:e];
        //NSLog(@"Exception %@", e);
    }
}

-(void) NSURLVimeoFunction:(NSString *)feedURLString :(NSString *)postParams :(NSString *)apiname {
    @try{
        
        self.strapiname=apiname;
        
        NSData *data = [postParams dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *requestDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [Constants printLogKey:@"*** API_URL" printValue:feedURLString];
        [Constants printLogKey:@"*** Request Params\n" printValue:requestDictionary];
        
        //   feedURLString = @"http://demo.shenll.net/IOS/ImgUpload/imgsign.php";
        NSData *postData = [postParams dataUsingEncoding:NSUTF8StringEncoding];
        
        //NSData *postData = [NSKeyedArchiver archivedDataWithRootObject:arrM];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:feedURLString]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
        
        NSString *postLength = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)[postData length]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"bearer 031097f31f782ace6fc9669fd84ef393" forHTTPHeaderField:@"Authorization"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/vnd.vimeo.*+json;version=3.4" forHTTPHeaderField:@"Accept"];
        [request setHTTPBody:postData];
        
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (conn) {
            receivedData=[[NSMutableData alloc]init];
            
        }
        else{
            
            
            UIAlertController * alert = [UIAlertController
                            alertControllerWithTitle:@"TUnable to connect to remote server, please check your network settings and try again"
                                             message:@""
                                      preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertView * alert_error = [[UIAlertView alloc] initWithTitle:@"Unable to connect to remote server, please check your network settings and try again" message:@"" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//            [alert_error show];
        }
    }
    
    @catch (NSException *e) {
        [Constants printLogKey:@"*** Exception %@" printValue:e];
        //NSLog(@"Exception %@", e);
    }
}

-(void) PutViemoApiCall:(NSString *)feedURLString :(NSString *)postParams :(NSString *)apiname {
    @try{
        
        self.strapiname=apiname;
        // NSLog(@"API_URL : %@",LIVE_DOMAIN);
        // NSLog(@"Request Params : %@",feedURLString);
        
        NSData *data = [postParams dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *requestDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [Constants printLogKey:@"*** API_URL" printValue:feedURLString];
        [Constants printLogKey:@"*** Request Params\n" printValue:requestDictionary];
        
        //   feedURLString = @"http://demo.shenll.net/IOS/ImgUpload/imgsign.php";
        NSData *postData = [postParams dataUsingEncoding:NSUTF8StringEncoding];
        
        //NSData *postData = [NSKeyedArchiver archivedDataWithRootObject:arrM];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:feedURLString]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
        
        NSString *postLength = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)[postData length]];
        
        [request setHTTPMethod:@"PUT"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"bearer 031097f31f782ace6fc9669fd84ef393" forHTTPHeaderField:@"Authorization"];
        [request setValue:@"application/vnd.vimeo.*+json;version=3.4" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        NSLog(@"API_URL : %@",conn);
        if (conn) {
            receivedData=[[NSMutableData alloc]init];
            
        }
        else{
            
            UIAlertController * alert = [UIAlertController
                            alertControllerWithTitle:@"TUnable to connect to remote server, please check your network settings and try again"
                                             message:@""
                                         
                                      preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertView * alert_error = [[UIAlertView alloc] initWithTitle:@"Unable to connect to remote server, please check your network settings and try again" message:@"" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//            [alert_error show];
        }
    }
    
    @catch (NSException *e) {
        [Constants printLogKey:@"*** Exception %@" printValue:e];
        //NSLog(@"Exception %@", e);
    }
}
-(void) NSURLConnectionFunction:(NSString *)feedURLString :(NSString *)postParams :(NSString *)apiname {
    @try{
        
        self.strapiname=apiname;
         NSLog(@"API_URL : %@",LIVE_DOMAIN);
         NSLog(@"Request Params : %@",feedURLString);
        
        NSData *data = [postParams dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *requestDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [Constants printLogKey:@"*** API_URL" printValue:feedURLString];
        [Constants printLogKey:@"*** Request Params\n" printValue:requestDictionary];
        
        //   feedURLString = @"http://demo.shenll.net/IOS/ImgUpload/imgsign.php";
        NSData *postData = [postParams dataUsingEncoding:NSUTF8StringEncoding];
        
        //NSData *postData = [NSKeyedArchiver archivedDataWithRootObject:arrM];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:feedURLString]  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
        
        NSString *postLength = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)[postData length]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (conn) {
            receivedData=[[NSMutableData alloc]init];
            
        }
        else{
            
            UIAlertController * alert = [UIAlertController
                            alertControllerWithTitle:@"TUnable to connect to remote server, please check your network settings and try again"
                                             message:@""
                                         
                                      preferredStyle:UIAlertControllerStyleAlert];
            
//            UIAlertView * alert_error = [[UIAlertView alloc] initWithTitle:@"Unable to connect to remote server, please check your network settings and try again" message:@"" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//            [alert_error show];
        }
    }
    
    @catch (NSException *e) {
        [Constants printLogKey:@"*** Exception %@" printValue:e];
        //NSLog(@"Exception %@", e);
    }
}

-(void)postAPIformissing:(NSDictionary *) dicMiss :(NSString *)apiname{
    self.strapiname=apiname;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@""]];
    //  NSLog(@"Miss: %@ \n %@",url,dicMiss);
    
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request1 setHTTPMethod:@"POST"];
    
    NSDictionary *tmp = dicMiss;
    
    NSError *error;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
    [request1 setHTTPBody:postdata];
    
    //set request content type we MUST set this value.
    [request1 setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // [request1 setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request1 delegate:self];
    //  [connection start];
    if(connection) {
        //  NSLog(@"Connection Successful");
    } else {
        // NSLog(@"Connection could not be made");
    }
    
}


//upload new product Images
-(void)UploadImagetoServer:(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData{
    //  AppDelegate *appDelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.strapiname=apiname;
    
    NSString *requestStringer = [NSString stringWithFormat:@"%@%@",LIVE_DOMAIN,APPINSERTREPLY];
    // requestStringer = @"http://demo.shenll.net/IOS/ImgUpload/imgsign.php";
    
    
    NSLog(@"Url  :%@",requestStringer);
    NSLog(@"feedURLString  :%@",feedURLString);
    
    feedURLString =@"Hai";
    NSMutableDictionary *dicInfpo = [[NSMutableDictionary alloc] init];
    [dicInfpo setValue:feedURLString forKey:@"Info"];
    
    NSLog(@"feedURLString  :%@",dicInfpo);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestStringer]];
    
    // NSData *postData = [NSKeyedArchiver archivedDataWithRootObject:dicInfpo];
    
    NSString *post = [NSString stringWithFormat:@"Info=%@",@"Raja"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:120];
    [request setHTTPMethod:@"POST"];
    // [request setHTTPBody:postData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    //  [request setValue:feedURLString forHTTPHeaderField:@"Info"];
    
    NSString *postString = [[NSString alloc] initWithData:postData
                                                 encoding:NSUTF8StringEncoding];
    //  [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    
    // add image data
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@.png\"\r\n", @"sign"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    NSLog(@"postLength %@",postLength);
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Timout error"
                                     
                                     preferredStyle:UIAlertControllerStyleAlert];
    }
}



//connection cancel
-(void)cancelconnection{
    if (conn) {
        [conn cancel];
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
    
    total_length = [response expectedContentLength];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
    
    if([self.strapiname isEqualToString:@"document"]){
        
        float current = [data length];
        
        [delegate currentprogress:current/total_length];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
   
    
    NSString *str_response=[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    //  NSLog(@"Before Server Response : %@",str_response);
    
    
    
    NSMutableArray *responseDictionary= [[NSMutableArray alloc] init];
    
    
    str_response=[str_response stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    str_response = [str_response stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
    
    NSData *data = [str_response dataUsingEncoding:NSUTF8StringEncoding];
    responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    
    if(str_response==nil|| [str_response isEqualToString:@"(null)"]|| [str_response isEqual:NULL]|| [str_response isEqualToString:@""]){
        str_response=nil;
        str_response=[[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        data = [str_response dataUsingEncoding:NSUTF8StringEncoding];
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
    }
    
    
    [Constants printLogKey:@"*** API From" printValue:self.strapiname];
    [Constants printLogKey:@"*** Server Response\n" printValue:responseDictionary];
    
    
    [delegate responestring:responseDictionary:self.strapiname];
  //  [delegate responeDictstring:responseDictionary:self.strapiname];

    
    str_response=nil;
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [delegate failedresponse:error];
    // NSLog(@"Failed Error : %@",error);
    [Constants printLogKey:@"*** Failed Error" printValue:error];
}
//callPassVoiceParms as staff
-(void)callPassVoiceStaff:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)VoiceData{
    
    
    //NSURL *baseUrlString =[[NSUserDefaults standardUserDefaults] objectForKey:@"BASEURL"];
    NSString *requestStringer = [NSString stringWithFormat:@"%@%@",baseurl,SENDVOICE_STAFF];
    NSLog(@"Request url : %@",requestStringer);
    
    NSMutableData *body = [NSMutableData data];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestStringer]];
    
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (VoiceData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"voice\"; filename=\"%@.mp4\"\r\n", @"voice"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:VoiceData];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"Info"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }else{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"Info"];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    //    [dict setObject:feedURLString forKey:@"Info"];
    //     NSLog(@"INFO DICT : %@",dict);
    //    [body appendData:[self createFormData:dict withBoundary:boundary]];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        
        
        UIAlertController * alert = [UIAlertController
                        alertControllerWithTitle:@""
                                         message:@"Timout error"
                                     
                                  preferredStyle:UIAlertControllerStyleAlert];

    }
}


-(void)callPassVoiceParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)VoiceData{
   
    [Constants printLogKey:@"Request url" printValue:baseurl];
    [Constants printLogKey:@"Request params" printValue:feedURLString];
    [Constants printLogKey:@"Voice VoiceData params" printValue:VoiceData];
    
    
    NSMutableData *body = [NSMutableData data];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:baseurl]];
    
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"----WebKitFormBoundary7MA4YWxkTrZu0gW";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (VoiceData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"voice\"; filename=\"%@.mp4\"\r\n", @"voice"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:VoiceData];
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"Info"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        // [body appendData:VoiceData];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }else{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"key"];
        [body appendData:[self createFormData:dict withBoundary:boundary]];


    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
  
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        
        UIAlertController * alert = [UIAlertController
                        alertControllerWithTitle:@""
                                         message:@"Timout error"
                                     
                                  preferredStyle:UIAlertControllerStyleAlert];

    }
}
-(void)callVoiceParams:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)VoiceData{
    
    
    //NSURL *baseUrlString =[[NSUserDefaults standardUserDefaults] objectForKey:@"BASEURL"];
    NSString *requestStringer = [NSString stringWithFormat:@"%@%@",baseurl,SENDVOICETOPARTICULARCLASS_PRINCIPLE];
    NSLog(@"Request url : %@",requestStringer);
    
    NSMutableData *body = [NSMutableData data];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestStringer]];
    
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (VoiceData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"voice\"; filename=\"%@.mp4\"\r\n", @"voice"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:VoiceData];
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"key"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        
        UIAlertController * alert = [UIAlertController
                        alertControllerWithTitle:@""
                                         message:@"Timout error"
                                     
                                  preferredStyle:UIAlertControllerStyleAlert];

    }
}

//CommoncallPassParmsImage
-(void)CommoncallPassParmsImage:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData{
    
    
    //NSURL *baseUrlString =[[NSUserDefaults standardUserDefaults] objectForKey:@"BASEURL"];
    NSString *requestStringer = [NSString stringWithFormat:@"%@%@",baseurl,feedURLString];
    // requestStringer = @"http://demo.shenll.net/IOS/ImgUpload/imgsign.php";
    // feedURLString = @"http://demo.shenll.net/IOS/ImgUpload/imgsign.php";
    NSMutableData *body = [NSMutableData data];
    NSLog(@"Request url : %@",requestStringer);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestStringer]];
    
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@.png\"\r\n", @"sign"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"key"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        
        UIAlertController * alert = [UIAlertController
                        alertControllerWithTitle:@""
                                         message:@"Timout error"
                                     
                                  preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    NSLog(@"Close Tapped");
                                                }]];

    }
}

-(void)callPassParmsImage:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData{
    
    
    //NSURL *baseUrlString =[[NSUserDefaults standardUserDefaults] objectForKey:@"BASEURL"];
    NSString *requestStringer = [NSString stringWithFormat:@"%@%@",baseurl,SENDIMAGE_STAFF];
    // requestStringer = @"http://demo.shenll.net/IOS/ImgUpload/imgsign.php";
    // feedURLString = @"http://demo.shenll.net/IOS/ImgUpload/imgsign.php";
    NSMutableData *body = [NSMutableData data];
    NSLog(@"Request url : %@",requestStringer);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestStringer]];
    
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@.png\"\r\n", @"sign"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"key"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Timout error." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        [alert show];
    }
}

-(void)callPassUploadVimeoVideoParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)videoData{
    
   
    NSMutableData *body = [NSMutableData data];
    [Constants printLogKey:@"Request url" printValue:baseurl];
    [Constants printLogKey:@"Request params" printValue:feedURLString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:baseurl]];
    
    [request setHTTPMethod:@"PUT"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:@"application/offset+octet-stream" forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"bearer 031097f31f782ace6fc9669fd84ef393" forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/vnd.vimeo.*+json;version=3.4" forHTTPHeaderField:@"Accept"];
    [request setValue:@"1.0.0" forHTTPHeaderField:@"Tus-Resumable"];
    [request setValue:@"0" forHTTPHeaderField:@"Upload-Offset"];
    // [request setValue:@"title" forHTTPHeaderField:@"name"];
    // [request setValue:@"Desc" forHTTPHeaderField:@"description"];
    
    if (videoData) {
       
        [body appendData:videoData];
        // [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
//    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
//    if (@available(iOS 10.0, *)) {
//    78
    
    
    
   
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *conn = [session dataTaskWithRequest:request
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
            {
        
        NSLog(@"RESPONSE url : %@",conn);
        if (conn) {
            self->receivedData=[[NSMutableData alloc]init];
        } else {
            
            UIAlertController * alert = [UIAlertController
                            alertControllerWithTitle:@""
                                             message:@"Timout error"
                                         
                                      preferredStyle:UIAlertControllerStyleAlert];
    //
        }
        
        
                // do something with the data
            }];
//    [dataTask resume];
    

    
}
-(void)callPassVimeoVideoParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)videoData{
    
    
  
    NSMutableData *body = [NSMutableData data];
    [Constants printLogKey:@"Request url" printValue:baseurl];
    [Constants printLogKey:@"Request params" printValue:feedURLString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:baseurl]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"bearer 031097f31f782ace6fc9669fd84ef393" forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/vnd.vimeo.*+json;version=3.4" forHTTPHeaderField:@"Accept"];
    // [request setValue:@"title" forHTTPHeaderField:@"name"];
    // [request setValue:@"Desc" forHTTPHeaderField:@"description"];
    
    if (videoData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"video\"; filename=\"%@.mp4\"\r\n", @"sign1"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:videoData];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"file_data"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Timout error." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        [alert show];
    }
}
-(void)callPassVideoParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)videoData{
    
    
   
    NSMutableData *body = [NSMutableData data];
    [Constants printLogKey:@"Request url" printValue:baseurl];
    [Constants printLogKey:@"Request params" printValue:feedURLString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:baseurl]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (videoData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"video\"; filename=\"%@.mp4\"\r\n", @"sign"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:videoData];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"key"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        
        UIAlertController * alert = [UIAlertController
                        alertControllerWithTitle:@""
                                         message:@"Timout error"
                                     
                                  preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Timout error." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
//        [alert show];
    }
}


-(void)callPassAssignmentParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData :(NSString *)extension{
    
    
    
    NSMutableData *body = [NSMutableData data];
    [Constants printLogKey:@"Request url" printValue:baseurl];
    [Constants printLogKey:@"Request params" printValue:feedURLString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:baseurl]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", extension] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"key"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    //    [dict setObject:feedURLString forKey:@"Info"];
    //     NSLog(@"INFO DICT : %@",dict);
    //    [body appendData:[self createFormData:dict withBoundary:boundary]];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        
        UIAlertController * alert = [UIAlertController
                        alertControllerWithTitle:@""
                                         message:@"Timout error"
                                     
                                  preferredStyle:UIAlertControllerStyleAlert];

    }
}

-(void)callPassPDFParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData{
    
    
    
    NSMutableData *body = [NSMutableData data];
    [Constants printLogKey:@"Request url" printValue:baseurl];
    [Constants printLogKey:@"Request params" printValue:feedURLString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:baseurl]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.pdf\"\r\n", @"sign"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"key"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        
        UIAlertController * alert = [UIAlertController
                        alertControllerWithTitle:@""
                                         message:@"Timout error"
                                     
                                  preferredStyle:UIAlertControllerStyleAlert];
//
    }
}

-(void)callPassImageParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData{
    
    
   
    NSMutableData *body = [NSMutableData data];
    [Constants printLogKey:@"Request url" printValue:baseurl];
    [Constants printLogKey:@"Request params" printValue:feedURLString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:baseurl]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@.png\"\r\n", @"sign"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"key"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
   
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Timout error." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        [alert show];
    }
}
-(void)callPassParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname:(NSData *)imageData{
    
    
    //NSURL *baseUrlString =[[NSUserDefaults standardUserDefaults] objectForKey:@"BASEURL"];
    NSString *requestStringer = [NSString stringWithFormat:@"%@%@",baseurl,SENDIMAGETOALL_PRINCIPLE];
    NSLog(@"Request url : %@",requestStringer);
    // feedURLString = @"http://demo.shenll.net/IOS/ImgUpload/imgsign.php";
    NSMutableData *body = [NSMutableData data];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestStringer]];
    
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@.png\"\r\n", @"sign"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:feedURLString forKey:@"key"];
        
        // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self createFormData:dict withBoundary:boundary]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        
        UIAlertController * alert = [UIAlertController
                        alertControllerWithTitle:@""
                                         message:@"Timout error"
                                     
                                  preferredStyle:UIAlertControllerStyleAlert];

    }
}
- (NSData*)createFormData:(NSDictionary*)myDictionary withBoundary:(NSString*)myBounds
{
    NSMutableData *myReturn = [[NSMutableData alloc] init];
    NSArray *formKeys = [myDictionary allKeys];
    for (int i = 0; i < [formKeys count]; i++) {
        [myReturn appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",myBounds] dataUsingEncoding:NSASCIIStringEncoding]];
        [myReturn appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@",[formKeys objectAtIndex:i],[myDictionary valueForKey:[formKeys objectAtIndex:i]]] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
    }
    return myReturn;
}

- (void)pass_data_header:(NSData *)videoData :(NSString *)title :(NSString *)discription :(NSString *)Aurtorizartion {
    NSString *tmpUrl=[[NSString alloc]initWithFormat:@"https://api.vimeo.com/me/videos?type=streaming&redirect_url=&upgrade_to_1080=false"];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:tmpUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    [request setHTTPMethod:@"POST"];
    [request setValue:Aurtorizartion forHTTPHeaderField:@"Authorization"];
    [request setValue:accept forHTTPHeaderField:@"Accept"];//change this according to your need.

    
    NSURLSession *session = [NSURLSession sharedSession];
  
    [session dataTaskWithRequest:[request copy]
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    // completion stuff
        NSData *returnData;
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData: returnData  options:kNilOptions error:&error];
        NSLog(@"RESPONSE11--->%@",json);
        NSLog(@"RESPONSE11--->%@",json);
        NSLog(@"RESPONSE11--->%@",json);
        if (!error) {
            [self call_for_ticket:[json valueForKey:@"upload_link_secure"] complet_url:[json valueForKey:@"complete_uri"] videoData:videoData : title : discription : Aurtorizartion];
            NSLog(@"RESPONSE3--->%@",json);
            
        }else{
            NSLog(@"RESPONSE--->%@",json);
            [self->delegate failedresponse:error];
        }
    }];
    
}
- (void)call_for_ticket:(NSString *)upload_url complet_url:(NSString *)complet_uri videoData:(NSData *)videoData :(NSString *)title :(NSString *)discription:(NSString *)Aurtorizartion {
    
    
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
            [self call_complete_uri:complet_uri :title :discription :Aurtorizartion];
            //[self call_complete_uri:complet_uri : title,discription];
        } else {
            [delegate failedresponse:error];
            NSLog(@"ERROR: %@ AND HTTPREST ERROR : %ld", error, (long)httpResp.statusCode);
        }
    }];
    [taskUpload resume];
    
    
}
-(void)call_complete_uri:(NSString *)complettion_url :(NSString *)title :(NSString *)discription:(NSString *)Aurtorizartion {
    
    
    NSString *str_url =[NSString stringWithFormat:@"https://api.vimeo.com%@",complettion_url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    [request setHTTPMethod:@"DELETE"];
    [request setValue:Aurtorizartion forHTTPHeaderField:@"Authorization"];
    [request setValue:accept forHTTPHeaderField:@"Accept"];
    //change this according to your need.
    

    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:str_url]
              completionHandler:^(NSData *data,
                                  NSURLResponse *response,
                                  NSError *error) {
                // handle response
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        if ([httpResponse statusCode] == 201) {
            NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:[httpResponse allHeaderFields]];
            if (dict) {
                NSString *str = [NSString stringWithFormat:@"title"];
                [self Give_title_to_video:[dict valueForKey:@"Location"] With_name:str : title : discription :Aurtorizartion];
            }
        }else{
            [delegate failedresponse:error];
            NSLog(@"%@",error.localizedDescription);
        }
//    }];

      }] resume];



    
}
- (void)Give_title_to_video:(NSString *)VIdeo_id With_name:(NSString *)name :(NSString *)title :(NSString *)discription:(NSString *)Aurtorizartion {
    
    NSString *tmpUrl=[[NSString alloc]initWithFormat:@"https://api.vimeo.com%@",VIdeo_id];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:tmpUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    [request setHTTPMethod:@"PATCH"];
    [request setValue:Aurtorizartion forHTTPHeaderField:@"Authorization"];
    [request setValue:accept forHTTPHeaderField:@"Accept"];//change this according to your need.
    NSError *error;
    

    
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: &error];
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:&error];
    NSString *str_description =  @"description";
    NSDictionary *dict = @{@"name":title,
                           @"description":discription,
                           @"review_link":@"false"
    };
    
    NSData *postData12 = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    [request setHTTPBody:postData12];
    
    if (!error) {
        NSLog(@"RESPONSE--->%@",json);
        NSMutableArray *responseDictionary= [[NSMutableArray alloc] init];
        [responseDictionary addObject:json];
        [delegate responestring:responseDictionary:self.strapiname];
        //  [self.delegate vimeouploader_succes:[json valueForKey:@"link"] methodName:@"vimeo"];
    }else{
        [delegate failedresponse:error];
        //NSLog(@"%@",error.localizedDescription);
        NSLog(@"Give_title_to_video_error--->%@",error);
    }
    
    
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    
    NSLog(@"didSendBodyData: %lld, totalBytesSent: %lld, totalBytesExpectedToSend: %lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
    
}



- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error == nil) {
        NSLog(@"Task: %@ upload complete", task);
    } else {
        NSLog(@"Task: %@ upload with error: %@", task, [error localizedDescription]);
    }
}

 -(void)callSendTextParms:(NSString *)baseurl :(NSString *)feedURLString :(NSString *)apiname{
    
    
  
    [Constants printLogKey:@"Request url" printValue:baseurl];
    [Constants printLogKey:@"Request params" printValue:feedURLString];
    
    
    NSMutableData *body = [NSMutableData data];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:baseurl]];
    
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"----WebKitFormBoundary7MA4YWxkTrZu0gW";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:feedURLString forKey:@"Info"];
    [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    // [body appendData:[@"Content-Type: application/json\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[self createFormData:dict withBoundary:boundary]];
    // [body appendData:VoiceData];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
 [request setHTTPBody:body];
    
    conn =[[NSURLConnection alloc] initWithRequest:request delegate:self];
     

    if (conn) {
        receivedData=[[NSMutableData alloc]init];
    } else {
        
        UIAlertController * alert = [UIAlertController
                        alertControllerWithTitle:@""
                                         message:@"Timout error"
                                     
                                  preferredStyle:UIAlertControllerStyleAlert];

    }
}



@end
