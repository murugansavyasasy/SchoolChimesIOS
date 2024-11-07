//
//  StudentListReq.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 29/04/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import KRProgressHUD


class StudentListReqst{
    static func call_request(param : String, completion_handler : @escaping(String)->()) {
        KRProgressHUD.show()
        BaseRequest.raw_post(url: get_url(), param: param).success {
            (res) in
            completion_handler (res as! String)
        }
    }
    
    private static func get_url() -> String{
        return String(format: "%@GetAbsenteesStudentsByDate",StaffConstantFile.BaseUrl as! CVarArg)
    }
}




