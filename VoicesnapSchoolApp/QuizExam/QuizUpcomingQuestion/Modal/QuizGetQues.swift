//
//  QuizGetQues.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 14/02/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper





class QuizGetQuestionModal : Mappable {
    
    
    
    var QuizId : Int!
    var StudentID : String!
    
    
    
    init() {}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        QuizId <- map["QuizId"]
        StudentID <- map["StudentID"]
    }
    
    
}




class QuizGetQuestionResponse : Mappable {
    
    
    
    var Status : Int!
    var Message : String!
    var Level : String!
    var QuestionData : [GetQuestionData]!
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        Status <- map["Status"]
        Message <- map["Message"]
        Level <- map["Level"]
        QuestionData <- map["data"]
        
        
        
    }
    
    
    
    
}




class GetQuestionData : Mappable {
    
    
    var QestionID : Int!
    var Question : String!
    var QuestionAnswer : [String]! = []
    var VideoUrl : String!
    var FileUrl : String!
    var FileType : String!
    var mark : Int!
    var isSelect : Bool!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        QestionID <- map["QestionId"]
        Question <- map["Question"]
        QuestionAnswer <- map["Answer"]
        VideoUrl <- map["VideoUrl"]
        FileUrl <- map["FileUrl"]
        FileType <- map["FileType"]
        mark <- map["mark"]
        
    }
    
    
}



//class GetQuestionAnswer : Mappable {
//
//}
