//
//  CertificateTypes.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 18/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation

import KRProgressHUD


class CertificateTypesRequest{
    
    
    static func call_request (completion_handler : @escaping(String) -> ()) {
        
        
        KRProgressHUD.show()
        print("lessonget_url()",get_url())
        BaseRequest.paramNotUsing(url: get_url() ).success {
            
            
            (res) in
            
            completion_handler(res as! String)
            
        }
        
    }
    
    private static func get_url() -> String {
        
        return String (format:  "%@/other-req/certificate-types",StaffConstantFile.SmsBaseUrl as! CVarArg )
        
    }
    
    
    
}
