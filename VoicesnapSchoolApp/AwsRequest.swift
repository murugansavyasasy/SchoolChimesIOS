//
//  AwsRequest.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/12/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import KRProgressHUD
class AwsReq{


    static func call_request (param : [String : Any],completion_handler : @escaping(String) -> ()) {


        KRProgressHUD.show()

        BaseRequest.getAny(url: get_url(), param: param).success {



           
            (res) in

            completion_handler(res as! String)

        }
        
        print("get_url()",get_url())

    }

    private static func get_url() -> String {

        return String (format:  "%@get-s3-presigned-url",StaffConstantFile.SmsBaseUrl as! CVarArg )

    }



}
