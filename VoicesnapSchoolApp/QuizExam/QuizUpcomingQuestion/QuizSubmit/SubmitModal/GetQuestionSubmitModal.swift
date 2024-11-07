//
//  GetQuestionSubmitModal.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 14/02/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper


class GetQuestionSubmitModal : Mappable {
    
    
    
    
    var QuizId : Int!
    var StudentID : String!
    var Answer : String!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        QuizId <- map["QuizId"]
        StudentID <- map["StudentID"]
        Answer <- map["Answer"]
        
        
    }
    
}




class AnswerEmpty : Mappable {
    
    
    
    
    
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        
    }
    
}



class QuestionSubmitResponse : Mappable {
    
    
    
    var Status : Int!
    var Message : String!
    var QuizId : String!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        Status <- map["Status"]
        Message <- map["Message"]
        QuizId <- map["QuizId"]
    }
}
