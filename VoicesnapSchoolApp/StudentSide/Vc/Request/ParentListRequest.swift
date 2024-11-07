//
//  ParentListRequest.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 18/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import KRProgressHUD


class ParentListRequest{
    
    
    static func call_request(param : String, completion_handler : @escaping(String)->()) {
        KRProgressHUD.show()
        print("get_url()",get_url())
        BaseRequest.raw_post(url: get_url(), param: param).success {
            
            (res) in
            completion_handler (res as! String)
        }
    }
    
    private static func get_url() -> String {
        
        return String (format:  "%@parent-request-list",StaffConstantFile.SmsBaseUrl as! CVarArg )
        
    }
    
    
    
}
