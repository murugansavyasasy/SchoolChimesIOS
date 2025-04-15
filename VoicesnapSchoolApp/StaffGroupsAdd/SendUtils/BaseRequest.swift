//
//  BaseRequest.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 04/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation
import Alamofire
import KRProgressHUD
import SystemConfiguration


final class BaseRequest{
    
    
    var valueHandle : ((AnyObject) -> ())?
    var errorHandle : ((NSError)->())?
    
    enum MultiPartType {
        case string, file
    }
    
    public typealias MultiDict = (type: MultiPartType, value: Any)
    
    @discardableResult
    func success(value:@escaping (AnyObject) -> ())->Self{
        //pass success handle
        self.valueHandle = value
        return self
    }
    
    @discardableResult
    func error(error:@escaping (NSError)->())->Self{
        //pass error handle
        self.errorHandle = error
        return self
    }
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
    
    
    static func paramNotUsing(url: String) -> BaseRequest {
        
        let call_back = BaseRequest()
        
        if isConnectedToNetwork(){
            AF.request(url, method:.get, encoding: URLEncoding.default , headers:["Content-Type": "application/x-www-form-urlencoded"])
                .validate()
                .responseJSON { response in
                    
                    print("get method response: \(response)")
                    
                    
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        
                        KRProgressHUD.dismiss({
                            call_back.valueHandle?(json as AnyObject)
                        })
                    }
                }
        }else{
            print("offline")
            KRProgressHUD.dismiss({
                call_back.valueHandle?("No Internet Connection" as AnyObject)
            })
        }
        
        return call_back
    }
    
    
    static func get(url: String ,param: [String: String]?) -> BaseRequest {
        
        let call_back = BaseRequest()
        
        if isConnectedToNetwork(){
            AF.request(url, method:.get, parameters: param, encoding: URLEncoding.default , headers:["Content-Type": "application/x-www-form-urlencoded"])
                .validate()
                .responseJSON { response in
                    
                    print("get method response: \(response)")
                    
                    
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        
                        KRProgressHUD.dismiss({
                            call_back.valueHandle?(json as AnyObject)
                        })
                    }
                }
        }else{
            print("offline")
            KRProgressHUD.dismiss({
                call_back.valueHandle?("No Internet Connection" as AnyObject)
            })
        }
        
        return call_back
    }
    
    
    
    static func getAny(url: String ,param: [String: Any]?) -> BaseRequest {
        
        let call_back = BaseRequest()
        
        if isConnectedToNetwork(){
            AF.request(url, method:.get, parameters: param, encoding: URLEncoding.default , headers:["Content-Type": "application/x-www-form-urlencoded"])
                .validate()
                .responseJSON { response in
                    
                    print("get method response: \(response)")
                    
                    
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        
                        KRProgressHUD.dismiss({
                            call_back.valueHandle?(json as AnyObject)
                        })
                    }
                }
        }else{
            print("offline")
            KRProgressHUD.dismiss({
                call_back.valueHandle?("No Internet Connection" as AnyObject)
            })
        }
        
        return call_back
    }
    
    
    
    
    
    
    

    static func getAnyHeader(url: String, param: [String: Any]?, header: [String: Any]?) -> BaseRequest {
        let call_back = BaseRequest()
        
        // Convert header dictionary to HTTPHeaders type
        var httpHeaders: HTTPHeaders = [:]
        if let headerDict = header {
            for (key, value) in headerDict {
                if let stringValue = value as? String {
                    httpHeaders.add(name: key, value: stringValue)
                }
            }
        }

        if isConnectedToNetwork() {
            AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: httpHeaders)
                .validate()
                .responseJSON { response in
                    print("get method response: \(response)")
                    
                    if let data = response.data {
                        let json = String(data: data, encoding: .utf8)
                        KRProgressHUD.dismiss {
                            call_back.valueHandle?(json as AnyObject)
                        }
                    }
                }
        } else {
            print("offline")
            KRProgressHUD.dismiss {
                call_back.valueHandle?("No Internet Connection" as AnyObject)
            }
        }
        
        return call_back
    }

    
    
   

    static func postAnyHeader(url: String, param: [String: Any]?, header: [String: Any]?) -> BaseRequest {
        let call_back = BaseRequest()
        
        // Convert header dictionary to HTTPHeaders type
        var httpHeaders: HTTPHeaders = [:]
        if let headerDict = header {
            for (key, value) in headerDict {
                if let stringValue = value as? String {
                    httpHeaders.add(name: key, value: stringValue)
                }
            }
        }

        if isConnectedToNetwork() {
            AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: httpHeaders)
                .validate()
                .responseJSON { response in
                    print("POST method response: \(response)")
                    
                    if let data = response.data {
                        let json = String(data: data, encoding: .utf8)
                        KRProgressHUD.dismiss {
                            call_back.valueHandle?(json as AnyObject)
                        }
                    }
                }
        } else {
            print("offline")
            KRProgressHUD.dismiss {
                call_back.valueHandle?("No Internet Connection" as AnyObject)
            }
        }
        
        return call_back
    }

    
    static func verifyToken(url: String ,token: String) -> BaseRequest {
        
        let call_back = BaseRequest()
        
        if isConnectedToNetwork(){
            AF.request(url, method:.get,encoding: URLEncoding.default , headers:["Content-Type": "application/x-www-form-urlencoded","token":token])
                .validate()
                .responseJSON { response in
                    
                    print("get method response: \(response)")
                    
                    
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        
                        KRProgressHUD.dismiss({
                            call_back.valueHandle?(json as AnyObject)
                        })
                    }
                }
        }else{
            print("offline")
            KRProgressHUD.dismiss({
                call_back.valueHandle?("No Internet Connection" as AnyObject)
            })
        }
        
        return call_back
    }
    
    
    
    
    static func verifyTokenParam(url: String ,param: [String: Int],token: String) -> BaseRequest {
        
        let call_back = BaseRequest()
        
        if isConnectedToNetwork(){
            AF.request(url, method:.get, parameters: param, encoding: URLEncoding.default , headers:["Content-Type": "application/x-www-form-urlencoded","token":token])
                .validate()
                .responseJSON { response in
                    
                    print("get method response: \(response)")
                    
                    
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        
                        KRProgressHUD.dismiss({
                            call_back.valueHandle?(json as AnyObject)
                        })
                    }
                }
        }else{
            print("offline")
            KRProgressHUD.dismiss({
                call_back.valueHandle?("No Internet Connection" as AnyObject)
            })
        }
        
        return call_back
    }
    
    static func post(url: String, param: [String : MultiDict]) -> BaseRequest{
        let call_back = BaseRequest()
        
        if isConnectedToNetwork(){
            AF.upload(multipartFormData: { (mfd) in
                
                for (key, value) in param{
                    let val: MultiDict = value
                    if val.type == MultiPartType.string{
                        mfd.append(Data((val.value as! String).utf8), withName: key)
                    }else{
                        let images: [UIImage] = val.value as! [UIImage]
                        images.forEach { img in
                            mfd.append(img.jpegData(compressionQuality: 0.8)!, withName: key, fileName: "image.jpeg", mimeType: "image/jpeg")
                        }
                    }
                }
                
            }, to: url)
            .responseJSON { (res) in
                
                print("post method response: \(res)")
                
                if let data = res.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    
                    KRProgressHUD.dismiss({
                        call_back.valueHandle?(json as AnyObject)
                    })
                }
            }
        }else{
            print("offline")
            KRProgressHUD.dismiss({
                call_back.valueHandle?("No Internet Connection" as AnyObject)
            })
        }
        
        return call_back
    }
    
    
    static func raw_post(url: String, param: String) -> BaseRequest{
        let call_back = BaseRequest()
        
        if isConnectedToNetwork(){
            let jsonData = param.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            AF.request(request)
                .validate()
                .responseJSON { (res) in
                    print(" ⚡ raw post method request : \(res.request!)")
                    print(" ⚡ raw post method response: \(res)")
                    

                    print("responseSTATUS: \(res.response?.statusCode)")
                DefaultsKeys.failedErrorCode = res.response?.statusCode
                    if let data = res.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        
                        KRProgressHUD.dismiss({
                            call_back.valueHandle?(json as AnyObject)
                        })
                    }
                }
        }else{
            print(" ⚡ offline")
            KRProgressHUD.dismiss({
                call_back.valueHandle?("No Internet Connection" as AnyObject)
            })
        }
        
        return call_back
    }
    
    
    
    
    static func token_raw_post(url: String, param: String,token : String) -> BaseRequest{
           let call_back = BaseRequest()
           
           if isConnectedToNetwork(){
               let jsonData = param.data(using: .utf8, allowLossyConversion: false)!
               var request = URLRequest(url: URL(string: url)!)
//           headers:["Content-Type": "application/x-www-form-urlencoded","token":token])
               request.httpMethod = HTTPMethod.post.rawValue
               request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
               request.setValue(token, forHTTPHeaderField: "token")
               request.httpBody = jsonData
               AF.request(request)
                   .validate()
                   .responseJSON { (res) in
                       print(" ⚡ raw post method request : \(res.request!)")
                       print(" ⚡ raw post method response: \(res)")
                       
                       if let data = res.data {
                           let json = String(data: data, encoding: String.Encoding.utf8)
                           
                           KRProgressHUD.dismiss({
                               call_back.valueHandle?(json as AnyObject)
                           })
                       }
                   }
           }else{
               print(" ⚡ offline")
               KRProgressHUD.dismiss({
                   call_back.valueHandle?("No Internet Connection" as AnyObject)
               })
           }
           
           return call_back
       }
    
}


