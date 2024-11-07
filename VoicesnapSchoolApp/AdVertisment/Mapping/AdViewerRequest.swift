//
//  AdViewerRequest.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 01/06/23.
//  Copyright © 2023 Gayathri. All rights reserved.
//

import Foundation
//impo


class AdViewerRequest {
    
    
    static func call_request(param : String, completion_handler : @escaping(String)->()) {
        //        KRProgressHUD.show()
        print("get_url()",get_url())
        BaseRequest.raw_post(url: get_url(), param: param).success {
            
            (res) in
            completion_handler (res as! String)
        }
    }
    
    
    private static func get_url() -> String{
        
        return String(format: "%@/ads-viewer", StaffConstantFile.SmsBaseUrl as! CVarArg )
    }
    
}
