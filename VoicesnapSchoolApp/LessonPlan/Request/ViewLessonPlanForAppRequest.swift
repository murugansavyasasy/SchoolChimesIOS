//
//  ViewLessonPlanForAppRequest.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 02/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation

import KRProgressHUD


class ViewLessonPlanForAppRequest{
    
    
    static func call_request (param : [String : String],completion_handler : @escaping(String) -> ()) {

        
        KRProgressHUD.show()
print("ViewLessonPlanForAppRequestGetURl",get_url())
        BaseRequest.get(url: get_url(), param: param).success {


            (res) in

            completion_handler(res as! String)

        }

    }

    private static func get_url() -> String {

        return String (format:  "%@lesson-plan/view_lesson_plan_for_App",StaffConstantFile.SmsBaseUrl as! CVarArg )

    }
    
    
    
    
}
