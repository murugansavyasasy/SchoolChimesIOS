//
//  GetTeacherWiseSlotRequest.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 12/08/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import KRProgressHUD
class GetTeacherWiseSlotAvailabilityRequest{


    static func call_request (param : [String : Any],completion_handler : @escaping(String) -> ()) {


        KRProgressHUD.show()
        print("get_url()",get_url())

        BaseRequest.getAny(url: get_url(), param: param).success {



            (res) in

            completion_handler(res as! String)

        }

    }

    private static func get_url() -> String {

        return String (format:  "%@/ptm-schedule/teacherwise-slots-availability-for-student",StaffConstantFile.SmsBaseUrl as! CVarArg )

    }

    

}
