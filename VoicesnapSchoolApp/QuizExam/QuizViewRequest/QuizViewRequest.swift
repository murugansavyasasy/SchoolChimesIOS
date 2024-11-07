//
//  QuizViewRequest.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 02/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation
import  KRProgressHUD


class QuizViewRequest {
    
    
    static func call_request(param : String, completion_handler : @escaping(String)->()) {
        KRProgressHUD.show()
        print("get_url()",get_url())
        BaseRequest.raw_post(url: get_url(), param: param).success {
            
            (res) in
            completion_handler (res as! String)
        }
    }
    
    
    private static func get_url() -> String{
        
        return String(format: "%@/ViewSubmission", StaffConstantFile.BaseUrl as! CVarArg )
    }
    
}
