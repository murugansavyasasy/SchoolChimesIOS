//
//  QuestionSubmitRequest.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 16/02/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import KRProgressHUD


class QuizQuestionSubmitRequest {
    
    
    static func call_request(param : String, completion_handler : @escaping(String)->()) {
        KRProgressHUD.show()
        print("get_url()",get_url())
        BaseRequest.raw_post(url: get_url(), param: param).success {
            
            (res) in
            completion_handler (res as! String)
        }
    }
    
    
    private static func get_url() -> String{
        
        return String(format: "%@/SubmitResponseForQuiz", StaffConstantFile.SmsBaseUrl as! CVarArg )
    }
    
}
