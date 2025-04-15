//
//  get_campaigns_Req.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 21/02/25.
//  Copyright © 2025 Gayathri. All rights reserved.
//

import Foundation
import KRProgressHUD
class Get_campians_Request{

    static func call_request (param : [String : Any],headers : [String : Any],completion_handler : @escaping(String) -> ()) {
        
        KRProgressHUD.show()
        
        BaseRequest .postAnyHeader(url: get_url(), param: param, header: headers).success {
            
            (res) in
            
            completion_handler(res as! String)
        }
    }

    private static func get_url() -> String {

        return String (format:  "%@get_campaigns",StaffConstantFile.PaucktBaseUrl as! CVarArg )

    }
}
