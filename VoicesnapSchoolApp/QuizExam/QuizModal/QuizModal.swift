//
//  QuizModal.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 01/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation
import ObjectMapper


class QuizModal : Mappable {
    
    
    
    var StudentID : String!
    var StatusType : Int!
    var SchoolID : String!
    
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        StudentID <- map["StudentID"]
        StatusType <- map["StatusType"]
        
        SchoolID <- map["SchoolID"]
        
        
    }
    
    
}


class QuizRespose : Mappable {
    
    
    var Status : Int!
    var Message : String!
    var data : [QuizData]!
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        
        data <- map["data"]
        
        
    }
    
    
}



class QuizData: Mappable {
    
    
    
    
    var QuizId : Int!
    var Title : String!
    var Description : String!
    var MaxMark : Int!
    var SubjectId : Int!
    var Subject : String!
    var Level : Int!
    var detailId : Int!
    var SubmittedOn : String!
    var createdOn : String!
    var Issubmitted : String!
    var isAppRead : String!
    var SentBy : String!
    var TotalNumberOfQuestions : Int!
    
    
    var RightAnswer : String!
    var WrongAnswer : String!
    var totalMark : String!
    var NoOfLevels : String!
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        
        
        
        QuizId <- map["QuizId"]
        Title <- map["Title"]
        Description <- map["Description"]
        MaxMark <- map["MaxMark"]
        SubjectId <- map["SubjectId"]
        Subject <- map["Subject"]
        Level <- map["Level"]
        detailId <- map["detailId"]
        SubmittedOn <- map["SubmittedOn"]
        createdOn <- map["createdOn"]
        Issubmitted <- map["Issubmitted"]
        isAppRead <- map["isAppRead"]
        SentBy <- map["SentBy"]
        TotalNumberOfQuestions <- map["TotalNumberOfQuestions"]
        
        RightAnswer <- map["RightAnswer"]
        WrongAnswer <- map["WrongAnswer"]
        totalMark <- map["totalMark"]
        NoOfLevels <- map["NoOfLevels"]
        
    }
    
    
}
