//
//  LessonPlanUpdateRequest.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import KRProgressHUD

class LessonPlanUpdateRequest {
    
    
    static func call_request(param : String, completion_handler : @escaping(String)->()) {
        KRProgressHUD.show()
        print("get_url()",get_url())
        BaseRequest.raw_post(url: get_url(), param: param).success {
            
            (res) in
            completion_handler (res as! String)
        }
    }
    
    
    private static func get_url() -> String{
        
        return String(format: "%@lesson-plan/update_staff_lessonplan_particular_app", StaffConstantFile.SmsBaseUrl as! CVarArg )
    }
    
}
