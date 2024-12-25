//
//  StaffConstantFile.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 04/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation
import UIKit
import AVFAudio


class StaffConstantFile {
//    NEWLINKREPORTBASEURL
    
   static let BaseUrl = UserDefaults.standard.object(forKey:NEWLINKREPORTBASEURL)
//    static let BaseUrl : String = "http://reporting.schoolchimes.com/nodejs/api/MergedApi/"
    
    
       // REPOTING : BaseUrl
       // VOICESNAP : SmsBaseUrl
    
    
//    static let demoSmsBaseUrl : String = "https://vss.voicesnapforschools.com/nodejs/api/"
    static  let SmsBaseUrl  = UserDefaults.standard.object(forKey:BASEURL)
    
    static let demoAlumni   = "http://106.51.127.215:8061/api/"
    
    
//    let defaults = UserDefaults.standard
//    static let SmsBaseUrl : String = defaults.string(forKey: BASEURL)!
    
}


struct DefaultsKeys {
    
    static let studentId = "chilId"
    static var MobileNum = "6380786962"
    static let chilId = "chilId"
    static let SchoolD = "SchoolD"
    static let selectDate = "selectDate"
    static let StaffID = "StaffID"
    static let ClassID = "ClassID"
    static let SectionId = "SectionId"
    static let QuizID = "QuizID"
    static let StaffRole = "StaffRole"
    static let staffDisplayRole = "staffDisplayRole"
    static let LessonSchoolId = "LessonSchoolId"
    static let LessonStafflId = "LessonStafflId"
    static let LessonSecId = "LessonSecId"
    static let getSecId = "getSecId"
    static let getgroupHeadRole = "getgroupHeadRole"
    static let updateTime = "86400"
    static let lastUpdateList = "lastUpdateList"
    static let updateListCount = "updateListCount"
    static let MemberidTild = ["MemberidTild"]
    static var MenuStatus : String!
    static var initialDisplayDate : String!
    static var dateArr : [String] = []
    static var school_type  = "school_type"
    static var doNotDialDisplayDate : String!
    static var SelectInstantSchedule = 0
    static var storeVimeoUrl : String!
    static var videoFilesize  = ""
    static var SchoolNameRegional = "SchoolNameRegional"
    static var biometricEnable = "biometricEnable"
    static var SelectedDAte = ""
    static var allowVideoDownload = "allowVideoDownload"
    
//    schoolchimes-communication
    
    
    static var bucketNameIndia = "schoolchimes-communication"
    
    static var bucketNameBangkok = "schoolchimes-files-bangkok"
    
    static var UploadProfileBucket = "schoolchimes-student-images"
    static var uploadprofileBrowes = "schoolchimes-docs"
    
    
    
    
    static var CognitoPoolID = "ap-south-1:a8650d2e-79d6-4668-85db-110e9917583f"
    static var bookingSlotId : [Int] = []
    static var date : [String] = []
    static var timesarr : [String] = []
    static var ClickID : Int!
    static var coutData : [countResponce] = []
    static var failedErrorCode : Int!
    static var sortName = "Sort Alphabetically (A → Z)"
    
    static var audioPlayer: AVAudioPlayer?
    
}

