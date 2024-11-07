//
//  MessageFromManagentVideoRequest.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 10/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation

import  KRProgressHUD


class MessageFromManagentVideoRequestGetFilesStaff_Archive {
    
    
    static func call_request(param :  String, completion_handler : @escaping(String)->()) {
        KRProgressHUD.show()
        BaseRequest.raw_post(url: get_url(), param: param).success {
            //        BaseRequest.post(url: get_url(), param: param).success {
            (res) in
            completion_handler (res as! String)
        }
    }
    //    http://reporting.schoolchimes.com/nodejs/api/MergedApi/GetFilesStaff_Archive
    
    
    private static func get_url() -> String{
        
        return String(format: "%@GetFilesStaff_Archive", StaffConstantFile.BaseUrl as! CVarArg)
    }
    
}



class MessageFromManagentVideoRequestGetFilesStaff {
    
    
    static func call_request(param :  String, completion_handler : @escaping(String)->()) {
        KRProgressHUD.show()
        BaseRequest.raw_post(url: get_url(), param: param).success {
            //        BaseRequest.post(url: get_url(), param: param).success {
            (res) in
            completion_handler (res as! String)
        }
    }
    //    http://reporting.schoolchimes.com/nodejs/api/MergedApi/GetFilesStaff_Archive
    
    
    private static func get_url() -> String{
        
        return String(format: "%@GetFilesStaff", StaffConstantFile.BaseUrl as! CVarArg)
    }
    
}
