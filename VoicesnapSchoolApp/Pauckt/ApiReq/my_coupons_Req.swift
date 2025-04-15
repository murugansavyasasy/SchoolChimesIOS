//
//  my_coupons_Req.swift
//  VoicesnapSchoolApp
//
//  Created by Lakshmanan on 04/04/25.
//  Copyright © 2025 SchoolChimes. All rights reserved.
//

import Foundation
import KRProgressHUD

class My_Coupons_Request {
    
    static func call_request (param : [String : Any],headers : [String : Any],completion_handler : @escaping(String) -> ()) {
        
        KRProgressHUD.show()
        
        BaseRequest .postAnyHeader(url: get_url(), param: param, header: headers).success {
            
            (res) in
            
            completion_handler(res as! String)
        }
    }
    
    private static func get_url() -> String {
        
        return String (format:  "%@my_coupons",StaffConstantFile.PaucktBaseUrl as! CVarArg )
    }
}

