//
//  AdvertismentConstant.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 29/11/22.
//  Copyright © 2022 Shenll-Mac-04. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class AdConstant {
    static let BaseUrl : String = "http://reporting.schoolchimes.com/nodejs/api/"
    
    
  static  var adDataList : [MenuData] = []
   // static var getMenuId : String!
    
   static var getMenuId = NSString()
    static var status : String!

    static var mgmtVoiceType = NSString()
    
    
    
    
    
    
    
    
    
//    async func getDataAndProcess() {
//        do {
//            let data = try await fetchData()
//            // Process the data here
//        } catch {
//            // Handle errors
//        }
//    }
    
    
    
    static func AdRes(memId : String,memType : String,menu_id : String , school_id : String)async {
        
        
        print("getMenuId:\(getMenuId)")
        let AdModal = AdvertismentModal()
        AdModal.MemberId = memId
        AdModal.MemberType = memType
        if mgmtVoiceType == "1" {
            AdModal.MenuId = "0"
        }
        AdModal.MenuId = getMenuId as String
        AdModal.SchoolId = school_id
        
        
        let admodalStr = AdModal.toJSONString()
        
       
//       print("admodalStr2222",admodalStr)
//        AdvertismentRequest.call_request(param: admodalStr!) { [self]
//            
//            (res) in
//            
//            let adModalResponse : [AdvertismentResponse] = Mapper<AdvertismentResponse>().mapArray(JSONString: res)!
//            
//            
//            
////            var adDataList : [MenuData] = []
//            for i in adModalResponse {
//                if i.Status.elementsEqual("1") {
//                    print("AdConstantadDataListtt",AdConstant.adDataList.count)
//                    
//                    DefaultsKeys.MenuStatus = i.Status
//                    status = i.Status
//                    
//                    AdConstant.adDataList.removeAll()
//                    AdConstant.adDataList = i.data
//                    
//                }else{
//                    
//                }
//                
//            }
            
            print("admodalStr_count", AdConstant.adDataList .count)

            

//
//        }
   
}


}
