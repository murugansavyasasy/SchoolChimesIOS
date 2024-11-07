//
//  UpdateDetailRequest.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 01/12/23.
//  Copyright © 2023 Gayathri. All rights reserved.
//

import Foundation

class UpdateDetailRequest{
    
    static func call_request(param : String, completion_handler : @escaping(String)->()) {
        BaseRequest.raw_post(url: get_url(), param: param).success {
            
            (res) in
            completion_handler (res as! String)
        }
    }
    
    
    
    
    private static func get_url() -> String {
        
        return String (format:  "%@new-update-details-app",StaffConstantFile.BaseUrl as! CVarArg )
        
    }
    
    
    
}
