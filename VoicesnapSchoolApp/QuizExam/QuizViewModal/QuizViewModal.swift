//
//  QuizViewModal.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 02/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation
//QuizViewModal.swift
import ObjectMapper







class QuizViewModal : Mappable {
    
    
    
    var StudentID : String!
    var QuizId : String!
    
    
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        StudentID <- map["StudentID"]
        QuizId <- map["QuizId"]
        
        
        
        
    }
    
    
}



class QuizViewResponse : Mappable {
    
    
    
    var status : Int!
    var message : String!
    var data : QuizViewData!
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        message <- map["message"]
        
        data <- map["data"]
        
        
    }
    
    
}


class QuizViewData : Mappable {
    
    
    var rightAnswer : String!
    var wrongAnswer : String!
    var unAnswer : String!
    var quizArray : [QuizArrayData]!
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        rightAnswer <- map["rightAnswer"]
        wrongAnswer <- map["wrongAnswer"]
        
        unAnswer <- map["unAnswer"]
        quizArray <- map["quizArray"]
        
    }
    
    
}



class QuizArrayData: Mappable {
    
    
    
    
    
    
    var id : Int!
    var question : String!
    var quizId : Int!
    var aOption : String!
    var bOption : String!
    var cOption : String!
    var dOption : String!
    var mark : Int!
    var answer : String!
    var studentAnswer : String!
    var correctAnswer : String!
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        
        
        
        id <- map["id"]
        question <- map["question"]
        quizId <- map["quizId"]
        aOption <- map["aOption"]
        bOption <- map["bOption"]
        cOption <- map["cOption"]
        dOption <- map["dOption"]
        mark <- map["mark"]
        answer <- map["answer"]
        studentAnswer <- map["studentAnswer"]
        correctAnswer <- map["correctAnswer"]
        
        
    }
    
    
}
