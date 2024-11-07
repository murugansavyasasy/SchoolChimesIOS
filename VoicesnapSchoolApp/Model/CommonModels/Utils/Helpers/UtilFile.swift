//
//  UtilFile.swift
//  Indian_Food_App
//
//  Created by Shenll-Mac-04 on 25/09/17.
//  Copyright © 2017 Shenll-Mac-04. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import UserNotifications  // for push notification

class UtilClass
{
    let SCHOOL_NAV_BAR_COLOR : UIColor = UIColor(red: 88.0/255.0, green: 21.0/255.0, blue: 69.0/255.0, alpha: 1.0)
    let PARENT_NAV_BAR_COLOR : UIColor = UIColor(red: 0.0/255.0, green: 96.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    let ORANGE_COLOR : UIColor = UIColor(red: 244.0/255.0, green: 120.0/255.0, blue: 21.0/255.0, alpha: 1.0)
    let GREEN_COLOR : UIColor = UIColor(red: 0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1.0)
    

    
    func convertTime(str_time : String) -> String {
        
        let str = str_time
        
        let dateFormatterWS : DateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US")
        dateFormatterWS.locale = enUSPosixLocale
        
        dateFormatterWS.timeZone = NSTimeZone.local
        dateFormatterWS.dateFormat = "dd-MM-yyyy'T'HH:mm:ss"
        let date = dateFormatterWS.date(from: str)
        
        let dateFormatterNew : DateFormatter = DateFormatter()
        dateFormatterNew.locale = enUSPosixLocale
        dateFormatterNew.timeZone = NSTimeZone.local
        dateFormatterNew.dateFormat = "MM/dd'T'hh:mm a"
        let stringForNewDate = dateFormatterNew.string(from: date!)
        return stringForNewDate
    }
    
    func convertTimeFromAM(str_time : String) -> String {
        let df: DateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        df.locale = enUSPosixLocale
        df.timeZone = NSTimeZone.local
        df.dateFormat = "hh:mm a"
        let newDate : Date = df.date(from: str_time)!
        df.dateFormat = "HH:mm"
        return df.string(from: newDate)
    }
    
    func convertTimeAMFormatFrom24(str_time : String) -> String {
        
        let dateAsString = str_time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: dateAsString)
        
        dateFormatter.dateFormat = "hh:mm a"
        let Date12 = dateFormatter.string(from: date!)
        
        return Date12
        
    }
    
    func convertTime24FormatFromAM(str_time : String) -> String {
        
        let dateAsString = str_time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.date(from: dateAsString)
        
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date!)
        
        return date24
        
    }
    
    func convertTimestampToDate(timeStampString : Double) -> String {
        
        let date = Date(timeIntervalSince1970: timeStampString/1000)
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
        
    }
    
    //pragma mark - Check Nil String
    
    func CheckNil(CheckString : NSString) -> NSString {
        var returnString : NSString
        if(CheckString == nil || CheckString.isEqual(to: "NULL") || CheckString.isEqual(to: "") || CheckString.isEqual(to: "null") || CheckString.isEqual(to: " ") || CheckString.length == 0 || CheckString.isEqual(to: "<null>"))
        {
            returnString = ""
        }
        else
        {
            returnString = CheckString
        }
        return returnString
    }
    
    func emptyCheck(str : String) -> Bool {
        var success:Bool = Bool()
        if(str == "" || str == " " || str.count == 0)
        {
            success = true
        }
        else
        {
            success = false
        }
        
        return success
        
    }
    
    func ConverHextoColor(hex: String) -> UIColor {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    
    
    func removeFile(file : String) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent(file).path
        let fileManager = FileManager.default
        if (fileManager.fileExists(atPath: filePath))
        {
            do{
                try fileManager.removeItem(atPath: filePath)
                
            }
            catch
            {
                print(error)
            }
        }
        else{
            // print("Folder not exists")
        }
    }
    
    
    func convertDictionaryToString(dict : NSMutableDictionary) -> String {
        let dictionary = dict
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
    
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        //let str = "{\"name\":\"James\"}"
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                // print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    func QuitApp()
    {
        exit(0);
    }
    
    func printLogKey(printKey : String, printingValue : Any ) -> Void
    {
        
        if IS_DEBUG_MODE == "0"{
            print(" STS Logbfvdcsxz`cv  \(printKey) : \(printingValue)")
        }
        
        
    }
    
    
    func create_folder(foldername : String) {
        var success : Bool = Bool()
        success = false
        let fileManager = FileManager.default
        //let documentsPath1 = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let documentsPath1 = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0])
        let logsPath = documentsPath1.appendingPathComponent(foldername)?.path
        success = fileManager.fileExists(atPath: logsPath!)
        print(logsPath!)
        if(!success)
        {
            do {
                try FileManager.default.createDirectory(atPath: logsPath!, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                
            }
        }
        else{
            
        }
        
    }
    
    
    func IsNetworkConnected() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    
    func validEmailAddress(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func ValidatePhonenumber(str_phone : NSString) -> Bool {
        let numberCharSet:NSCharacterSet = NSCharacterSet(charactersIn: "+0123456789()-")  as NSCharacterSet
        for var i in 0..<str_phone.length{
            let singlechar = str_phone.character(at: i) as unichar
            if(!(numberCharSet.characterIsMember(singlechar)))
            {
                return false
            }
        }
        return true
    }
    func ValidateNumbers(str_phone : NSString) -> Bool {
        let numberCharSet:NSCharacterSet = NSCharacterSet(charactersIn: "0123456789") as NSCharacterSet
        for var i in 0..<str_phone.length{
            let singlechar = str_phone.character(at: i) as unichar
            if(!(numberCharSet.characterIsMember(singlechar)))
            {
                return false
            }
        }
        return true
    }
    func urlspecialCheck(stringUrl:NSString) -> String {
        var stringUrl1 = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        stringUrl1 = stringUrl.replacingOccurrences(of: "&", with: "%26")
        stringUrl1 = stringUrl.replacingOccurrences(of: "+", with: "%2B")
        stringUrl1 = stringUrl.replacingOccurrences(of: ",", with: "%2C")
        stringUrl1 = stringUrl.replacingOccurrences(of: "/", with: "%2F")
        stringUrl1 = stringUrl.replacingOccurrences(of: ":", with: "%3A")
        stringUrl1 = stringUrl.replacingOccurrences(of: ";", with: "%3B")
        stringUrl1 = stringUrl.replacingOccurrences(of: "=", with: "%3D")
        stringUrl1 = stringUrl.replacingOccurrences(of: "?", with: "%3F")
        stringUrl1 = stringUrl.replacingOccurrences(of: "@", with: "%40")
        stringUrl1 = stringUrl.replacingOccurrences(of: " ", with: "%20")
        stringUrl1 = stringUrl.replacingOccurrences(of: "\t", with: "%09")
        stringUrl1 = stringUrl.replacingOccurrences(of: "#", with: "%23")
        stringUrl1 = stringUrl.replacingOccurrences(of: "<", with: "%3C")
        stringUrl1 = stringUrl.replacingOccurrences(of: ">", with: "%3E")
        stringUrl1 = stringUrl.replacingOccurrences(of: "\"", with: "%22")
        stringUrl1 = stringUrl.replacingOccurrences(of: "\n", with: "%0A")
        
        return stringUrl1!
    }
    
    func convertDateToDisplay(str_date : NSString) -> NSString {
        
        let str:NSString = str_date
        let df: DateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US")
        df.locale = enUSPosixLocale
        df.timeZone = NSTimeZone.local
        df.dateFormat = "yyyy-MM-dd"
        let newDate : Date = df.date(from: str as String)!
        df.dateFormat = "MMM dd, yyyy"
        let stringForNewDate:NSString = df.string(from: newDate) as NSString
        return stringForNewDate
        
    }
    
    func convertDate(str_date : NSString) -> NSString {
        let str:NSString = str_date
        let df: DateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US")
        df.locale = enUSPosixLocale
        df.timeZone = NSTimeZone.local
        df.dateFormat = "dd-MM-yyyy"
        let newDate : Date = df.date(from: str as String)!
        let dfnew: DateFormatter = DateFormatter()
        df.locale = enUSPosixLocale
        df.timeZone = NSTimeZone.local
        df.dateFormat = "dd-MM-yyyy"
        let stringForNewDate:NSString = dfnew.string(from: newDate) as NSString
        return stringForNewDate
        
        
    }
    func convertDateTime(str_date : NSString) -> NSString {
        let str:NSString = str_date
        let df: DateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US")
        df.locale = enUSPosixLocale
        df.timeZone = NSTimeZone.local
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let newDate : Date = df.date(from: str as String)!
        let dfnew: DateFormatter = DateFormatter()
        df.locale = enUSPosixLocale
        df.timeZone = NSTimeZone.local
        df.dateFormat = "MMM dd, yyyy"
        let stringForNewDate:NSString = dfnew.string(from: newDate) as NSString
        return stringForNewDate
        
        
    }
    func getCurrentTime() -> String {
        let date = Date()
        let df:DateFormatter = DateFormatter()
        df.dateFormat = "hh:mm a"
        let result = df.string(from: date)
        return result
    }
    
    func getCurrentDate() -> NSString {
        let date = Date()
        let df: DateFormatter = DateFormatter()
        df.dateFormat = "dd MMM yyyy"
        return df.string(from: date) as NSString
        
    }
    func getCurrentDateFrom() -> String {
        let date = Date()
        let df: DateFormatter = DateFormatter()
        df.dateFormat = "dd MMM yyyy"
        return df.string(from: date)
        
    }
    func getCurrentDate1() -> NSString {
        let date = Date()
        let df: DateFormatter = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: date) as NSString
        
    }
    
    func getCurrentTimeWithSeconds() -> String {
        let date = Date()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour,.minute,.second],from:date)
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        let today_string =  String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        return today_string
        
    }
    func getCurrentPlusMin() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
        
    }
    func createNewUUID1() -> String {
        let uuid = UUID().uuidString
        return uuid
        
    }
    func str_deviceid1() -> String {
        let deviceid = UIDevice.current.identifierForVendor?.uuidString
        return deviceid!
    }
    
    func createNewUUID() -> String? {
        let theUUID = CFUUIDCreate(nil)
        let string = CFUUIDCreateString(nil, theUUID)
        return string as! String
    }
    
    func str_deviceid() -> String? {
        var strdevice = ""
        let retrieveuuid = SSKeychain.password(forService: "com.voicesnap.schoolmessenger", account: "user") as! String
        strdevice = retrieveuuid
        if retrieveuuid == nil {
            let uuid = createNewUUID()
            SSKeychain.setPassword(uuid, forService: "com.voicesnap.schoolmessenger", account: "user")
            strdevice = uuid!
        }
        return strdevice
    }
    //pragma mark - Loading Activity
    //not checked
    func configPush() {
        let application = UIApplication()
        // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
    }
    
    func isDatabaseFileExistsOrNot(file : NSString) -> Bool {
        var isDBPathAvailable : Bool = Bool()
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        
        let filePath = url.appendingPathComponent(file as String).path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            isDBPathAvailable = true
        } else {
            isDBPathAvailable = false
        }
        return isDBPathAvailable
    }
    func copyFile(file : NSString)  {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent(file as String).path
        let fileManager = FileManager.default
        if (!fileManager.fileExists(atPath: filePath)) {
            let bundlePath = Bundle.main.path(forResource: "db", ofType: ".sqlite")
            do
            {
                try fileManager.copyItem(atPath: bundlePath!, toPath: path)
            }
            catch
            {
                print(error)
            }
        }
    }
    
    func applicationHiddenDocumentsDirectory(str_folder : NSString) -> NSURL {
        
        let libraryPath:String = NSSearchPathForDirectoriesInDomains(.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let path = libraryPath.appending(str_folder as String)
        let pathURl:NSURL =  NSURL.fileURL(withPath: path) as NSURL
        var isDirectory:ObjCBool = false
        if(FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory))
        {
            if(isDirectory).boolValue
            {
                return pathURl
            }
            else
            {
                NSException.raise(NSExceptionName(rawValue: "Private Documents exists, and is a file"), format: "Path: %@", arguments:getVaList([path]))
                
            }
            
        }
        do {
            
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        
        return pathURl
        
        
    }
    func converDictionaryToString(Data:NSDictionary) -> String
    {
        var result:String = String()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: Data)
            if let json = String(data: jsonData, encoding: .utf8) {
                result = json
                print(json)
            }
        } catch {
            print("something went wrong with parsing json")
        }
        return result
        
    }
    //for device
    
    func convertDateFormater1(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
    }
    
    func convertStringIntoDate(strDate : String) -> Date{
        print(strDate)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeStyle = DateFormatter.Style.none
              dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "dd-MM-YYYY" //"dd-MM-yyyy"
        
        let date = dateFormatter.date(from: strDate)
        if(date != nil){
             return date!
        }else{
             return Date()
        }
       
    }
    
    func convertStringIntoDate1(strDate : String) -> Date{
        print(strDate)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeStyle = DateFormatter.Style.none
              dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "dd-MM-YYYY"
        
        let date = dateFormatter.date(from: strDate)
        if(date != nil){
                    return date!
               }else{
                    return Date()
               }
    }
    
    func getCurrentDate2() -> Date {
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let stringDate =  dateFormatter.string(from: date)
        let dateFormatter1 = DateFormatter()
        dateFormatter1.timeStyle = DateFormatter.Style.none
        dateFormatter1.dateStyle = DateFormatter.Style.short
        dateFormatter1.dateFormat = "dd-MM-yyyy"
        
        let date1 = dateFormatter1.date(from: stringDate)
         if(date1 != nil){
                    return date1!
               }else{
                    return Date()
               }
    }
    
    func Shadowview(MyView : UIView){
              MyView.layer.cornerRadius = 5
              MyView.layer.masksToBounds = false
              MyView.layer.shadowOffset = CGSize.zero
              MyView.layer.shadowRadius = 3
              MyView.layer.shadowOpacity = 2
              MyView.layer.shadowColor = UIColor.lightGray.cgColor
              MyView.layer.cornerRadius = 5
          }
    
    func daysBetween(strDate : String) -> String {
       let startDate = strDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy hh:mma"
        let formatedStartDate = dateFormatter.date(from: startDate)
        let currentDate = Date()
        let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .month, .year])
        let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate!, to: currentDate)
        return String(describing: differenceOfDate.day!)
    }
       
    }
