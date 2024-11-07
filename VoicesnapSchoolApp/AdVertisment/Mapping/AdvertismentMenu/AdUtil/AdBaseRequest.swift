//
//  AdBaseRequest.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 29/11/22.
//  Copyright © 2022 Shenll-Mac-04. All rights reserved.
//

import Foundation


import Alamofire
import KRProgressHUD
import SystemConfiguration


final class AdBaseRequest{
    
    
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
    
    
    static func get(url: String ,param: [String: String]?) -> AdBaseRequest {
        
        let call_back = AdBaseRequest()
        
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
    
    static func post(url: String, param: [String : MultiDict]) -> AdBaseRequest{
        let call_back = AdBaseRequest()
        
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
    
    
    static func raw_post(url: String, param: String) -> AdBaseRequest{
        let call_back = AdBaseRequest()
        
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


