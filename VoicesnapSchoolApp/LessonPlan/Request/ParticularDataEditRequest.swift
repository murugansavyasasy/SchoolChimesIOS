//
//  ParticularDataEditRequest.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import KRProgressHUD


class ParticularDataEditRequest {
    
    
    static func call_request (param : [String : String],completion_handler : @escaping(String) -> ()) {

        
        KRProgressHUD.show()

        BaseRequest.get(url: get_url(), param: param).success {


            (res) in

            completion_handler(res as! String)

        }

    }

    private static func get_url() -> String {

      
        
        return String(format: "%@lesson-plan/get_data_to_edit_staff_lessonplan_app", StaffConstantFile.SmsBaseUrl as! CVarArg )
    }
    
}
