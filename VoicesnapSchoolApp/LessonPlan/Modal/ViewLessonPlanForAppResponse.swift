//
//  ViewLessonPlanForAppResponse.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 02/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation


import ObjectMapper


class ViewLessonPlanForAppResponse : Mappable {
   
    var status : Int!
    var message : String!
    var viewLessonPlanForAppData : [ViewLessonPlanForAppData]!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        message <- map["message"]
        viewLessonPlanForAppData <- map["data"]
     
    }
   
}

class ViewLessonPlanForAppData : Mappable {



var particular_id : Int!
var status : Int!
var data_array : [ViewLessonPlanDataArray]!



required init?(map: ObjectMapper.Map) {
mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {

particular_id <- map["particular_id"]
status <- map["status"]
data_array <- map["data_array"]


}
}




class ViewLessonPlanDataArray : Mappable {

var name : String!
var value : String!




required init?(map: ObjectMapper.Map) {
mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {

name <- map["name"]
value <- map["value"]


}
}




