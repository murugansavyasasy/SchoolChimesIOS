//
//  activate_coupon.swift
//  VoicesnapSchoolApp
//
//  Created by Lakshmanan on 03/04/25.
//  Copyright © 2025 SchoolChimes. All rights reserved.
//

import Foundation
import KRProgressHUD

class Activate_coupon_Request{


    static func call_request (param : [String : Any],headers : [String : Any],completion_handler : @escaping(String) -> ()) {


        KRProgressHUD.show()

        
        BaseRequest .postAnyHeader(url: get_url(), param: param, header: headers).success {
       



            (res) in

            completion_handler(res as! String)

        }

    }

    private static func get_url() -> String {

        return String (format:  "%@activate_coupon",StaffConstantFile.PaucktBaseUrl as! CVarArg )

    }
   


}

