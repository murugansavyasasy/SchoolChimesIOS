//
//  AdvertismentRequest.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 29/11/22.
//  Copyright © 2022 Shenll-Mac-04. All rights reserved.
//

import Foundation
import  KRProgressHUD


class AdvertismentRequest {
    
        
        static func call_request(param : String, completion_handler : @escaping(String)->()) {
            KRProgressHUD.show()
            print(get_url())
            AdBaseRequest.raw_post(url: get_url(), param: param).success {
                
                (res) in
                completion_handler (res as! String)
            }
        }
        
        
        private static func get_url() -> String{
            
            return String(format: "%@get-ads",StaffConstantFile.BaseUrl as! CVarArg )
        }
        
   

}
