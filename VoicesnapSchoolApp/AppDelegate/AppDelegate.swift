//
//  AppDelegate.swift
//  VoicesnapSchoolApp
//
//  Created by Shenll-Mac-04 on 03/07/17.
//  Copyright © 2017 Shenll-Mac-04. All rights reserved.
////

import UIKit
import UserNotifications
import Firebase
import Fabric
import Crashlytics
import AVFoundation
import ObjectMapper
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var LanguageArray = NSArray()
    var emptyArray = NSArray()
    var ArrLibraryDetail = NSArray()
    var ArrExamMark = NSArray()
    var ArrExamDetailMark = NSArray()
    var ArrPaidFeeDetail = NSArray()
    var ArrPendingFeeDetail = NSMutableArray()
    var LoginSchoolDetailArray = NSArray()
    var MaxGeneralSMSCountString = String()
    var MaxHomeWorkSMSCountString = String()
    var MaxEmergencyVoiceDurationString = String()
    var MaxGeneralVoiceDuartionString = String()
    var MaxHWVoiceDurationString = String()
    var idGroupHead = String()
    var strMobileNumber = String()
    var strOfferLink = String()
    var strProductLink = String()
    var FeePaymentGateway = String()
    var strProfileLink = String()
    var strProfileTitle = String()
    var strUploadPhotoTitle = String()
    var otpMobileNumber = String()
    var Helplineurl = String()
    var AdTimerInterval = String()
    
    var isAdmin = String()
    var isPrincipal = String()
    var isStaff = String()
    var isParent = String()
    var MenuNmaes = String()
    var staffRole = String()
    var staffDisplayRole = String()
    var school_type = String()
    var LiveAppUrl = NSString()
    
    var videoSize = String()
    var videoSizeAlert = String()
    var VimeoToken = String()
    
    var isPasswordBind = String()
    var isPasswordBindPassword = String()
    var audioPlayer: AVAudioPlayer?
    var strDeviceToken = String()
//    var player: AVAudioPlayer?
    var isPopupOpened = 0
    var LoginParentDetailArray = NSArray()
    var appIsStarting = false
    
    var SchoolDetailDictionary = NSDictionary()
    var razorPaymentDict = NSMutableDictionary()
    var redirectOTPDict = NSDictionary()
    
    var strSchoolID = String()
    private var player: AVPlayer?
    
    var mainParentIconArray : [String] = []
    var mainParentSegueArray : [String] = []
    var Id = 0
    //
    // Language Parent Menu Arrays
    
    var mainParentArray = ["en" : ["Emergency Voice","Non-Emergency Voice","Text Messages","Homework","Exam/Test","Exam Marks","Circulars","Notice Board","School / Class Events","Attendance Report","Leave Information","Fee Details","Images","Library Details","Staff Details","Online Text Book","YouTube Video","","Assignment","Video","Online Meeting"],
                           "ar" : ["صوت الطوارئ","صوت غير طارئ","رسائل نصية","واجب منزلي","/ اختبارامتحان","علامات الامتحان","التعاميم","لوح الإعلانات","أحداث المدرسة / الصف","تقرير الحضور","اترك المعلومات","تفاصيل الرسوم","صور","تفاصيل المكتبة","تفاصيل الموظفين","كتاب النصوص على الانترنت","فيديو يوتيوب","","","مهمة","فيديو"], "ms" :["Suara Kecemasan","Suara Bukan Kecemasan","Mesej teks","Kerja rumah","Ujian / Ujian","Tanda Peperiksaan","Pekeliling","Papan kenyataan","Peristiwa Sekolah / Kelas","Laporan Kehadiran","Tinggalkan Maklumat","Butiran Bayaran","Imej","Butiran Perpustakaan","Butiran Staf","Buku Teks Dalam Talian","YouTube Video","","Tugasan","Video"], "fr": ["Voix d'urgence","Voix non urgente","Des messages texte","Devoirs","Examen / tester","Marques d'examen","Circulaires","Tableau d'affichage","Événements scolaires / de classe","Rapport de présence","Laisser des informations","Détails des frais","l' image ","Détails de la bibliothèque","Détails du personnel","Livre de texte en ligne","YouTube Video","","affectation","vidéo"],"es": ["Voz de emergencia","Voz no de emergencia","Mensajes de texto","Deberes","Examen / Examen","Marcas de examen","Circulares","Tablón de anuncios","Escuela / eventos de clase","Reporte de asistencia","Dejar informacion","Detalles de la tarifa","Imágenes","Detalles de la biblioteca","Detalles del personal","Libro de texto en línea","YouTube Video","","Asignación","Vídeo"], "de" : ["Notstimme","Allgemeine Stimme","Text Messages","Hausaufgaben","Prüfung / Test","Prüfzeichen","Rundschreiben","Schild","Schulveranstaltungen","Teilnahmebericht","Informationen hinterlassen","Fee Details","Bilder","Bibliotheksdetails","Staff Details","Online Text Book","YouTube Video","","Opgave","Video"],"it" : ["Voice di emergenza","Voce non di emergenza","Messaggi di testo","Compiti a casa","Exam/Test","Marchi d'esame","circolari","Bacheca","Eventi scuola / classe","Rapporto di partecipazione","Invia informazioni","Dettagli della tariffa","immagini","Dettagli della biblioteca","Dettagli del personale","Libro di testo online","YouTube Video","Assignment","","Incarico","Video"],
                           "si" : ["හදිසි කටහ","හදිසි නොවන හ voice","කෙටි පණිවිඩ","ගෙදර වැඩ","විභාගය / පරීක්ෂණය","විභාග ලකුණු","චක්‍රලේඛ","දැන්වීම් පුවරුව","පාසල් / පන්ති සිදුවීම්","පැමිණීමේ වාර්තාව","තොරතුරු තබන්න","ගාස්තු විස්තර","රූප","පුස්තකාල විස්තර","කාර්ය මණ්ඩල විස්තර","මාර්ගගත පෙළ පොත","යූ ටියුබ් වීඩියෝ","","පැවරුම","වීඩියෝ"]
    ]
    
    // School Menu Detail
    var mainSchoolArrray = ["en" : ["Emergency Voice","Voice to Parents/Staff","Text to Parents/Staff","Notice Board","School / Class Events","Image/PDF Upload","Absenteeism Report","School Strength","School Strength","Text Homework","Voice Homework","Schedule Exam/Test","Attendance Marking","Messages From Management","Feedback","Library Details","Conference Call with Teachers","Leave Requests","Online Text Book","Meeting","Upload Video","Our New Products","Assignment","Video","Chat","Other Services", "Online Meeting"],
                            
                            "ar" : ["صوت الطوارئ","صوت للآباء / الموظفين","النص إلى الآباء / الموظفين","لوح الإعلانات","أحداث المدرسة / الفصل","تحميل صورة / PDF","تقرير التغيب","قوة المدرسة","قوة المدرسة","نص الواجبات المنزلية","صوت واجبات منزلية","امتحان / جدول اختبار","علامات الحضور","رسائل من الإدارة","ردود الفعل","تفاصيل المكتبة","مؤتمر نداء مع المعلمين","ترك طلبات","كتاب النصوص على الانترنت","كتاب النصوص على الانترنت","Upload Video","منتجاتنا الجديدة","مهمة","فيديو","دردشة","Other Services","Online Meeting"],
                            
                            "fr" :["Voix d'urgence","Voix aux parents/Personnelle","Texte aux parents/Personnelle","Tableau d'affichage","École / Classe Événements","Téléchargement d'image / PDF","Rapport d'absentéisme","Force scolaire","Force scolaire","Texte Devoirs","Suara Kerja rumah","Calendrier examen / test","Marquage de présence","Messages de gestion","Retour d'information","Détails de la bibliothèque","Conférence téléphonique avec les enseignants","Demandes de congé","Livre de texte en ligne","Livre de texte en ligne","Upload Video","Nos Nouveaux Produits","affectation","vidéo","Bavarder","Other Services","Online Meeting"],
                            
                            "ms":  ["Suara Kecemasan","Suara kepada Ibu Bapa/Kakitangan","Teks kepada Ibu Bapa/Kakitangan","Papan kenyataan","Sekolah / Kelas Peristiwa  ","Muat naik Imej / PDF","Laporan Absenteeism","Kekuatan Sekolah","Kekuatan Sekolah","Kerja rumah teks","Kerja Rumah Suara","Jadual Peperiksaan / Ujian","Menanda Kehadiran","Mesej Dari Pengurusan","Maklumbalas","Butiran Perpustakaan","Panggilan Persidangan Dengan Guru","Tinggalkan Permintaan","Buku Teks Dalam Talian","Buku Teks Dalam Talian","Upload Video","Produk Baru Kami","Tugasan","Video","Sembang","Other Services","Online Meeting"],
                            
                            "es": ["Voz de emergencia","Voz a los padres / personal","Texto a los padres / personal","Tablón de anuncios","Escuela / eventos de clase","Image / PDF Upload","Informe de absentismo","Fuerza escolar","Fuerza escolar","Tarea de texto","Tarea de voz","Programar Examen / Prueba","Marca de asistencia","Mensajes de la gerencia","Realimentación","Detalles de la biblioteca","Llamada de conferencia con los maestros","Solicitudes de licencia","Libro de texto en línea","Libro de texto en línea","Upload Video","Nuestros Nuevos Productos","Asignación","Vídeo","Charla","Other Services","Online Meeting"],
                            
                            "de" : ["Notstimme","Stimme für Eltern / Mitarbeiter","Text an Eltern / Mitarbeiter","Schild","Schul- / Klassenveranstaltungen","Bild / PDF-Upload","Fehlzeitenbericht","Schulstärke","Schulstärke","Text Hausaufgaben","Stimme Hausaufgaben","Prüfung / Test planen","Anwesenheitskennzeichnung","Nachrichten aus dem Management","Feedback","Bibliotheksdetails","Telefonkonferenz mit Lehrern","Urlaubsanträge","Online Lehrbuch","Online Lehrbuch","Upload Video","Unsere Neuen Produkte","Opgave","Video","Snak","Other Services","Online Meeting"],
                            
                            "it" : ["Voice di emergenza","Voice to Parents / Staff","Testo per genitori / personale","Bacheca","Eventi scuola / classe","Caricamento immagine / PDF","Rapporto sull'assenteismo","Forza della scuola","Forza della scuola","Compiti di testo","Compiti vocali","Programma esame / test","Marcatura presenze","Messaggi dalla gestionem","Risposta","Dettagli della biblioteca","Conference Call con gli insegnanti","Invia richieste","Libro di testo online","Libro di testo online","Upload Video","I Nostri Nuovi Prodotti","Incarico","Video","Chiacchierare","Other Services","Online Meeting"],
                            "si" : ["හදිසි කටහ","දෙමාපියන්ට / කාර්ය මණ්ඩලයට voice","දෙමාපියන්ට / කාර්ය මණ්ඩලයට කෙටි පණිවිඩයක්","දැන්වීම් පුවරුව","පාසල් / පන්ති සිදුවීම්","රූපය / PDF උඩුගත කිරීම","නොපැමිණීමේ වාර්තාව","පාසල් ශක්තිය","පාසල් ශක්තිය","පෙළ ගෙදර වැඩ","voice ගෙදර වැඩ","උපලේඛන විභාගය / පරීක්ෂණය","පැමිණීමේ ලකුණු කිරීම","කළමනාකරණයෙන් පණිවිඩ","ප්‍රතිපෝෂණය","පුස්තකාල විස්තර","ගුරුවරුන් සමඟ සම්මන්ත්‍රණ ඇමතුම","ඉල්ලීම් අත්හරින්න","මාර්ගගත පෙළ පොත","රැස්වීම","වීඩියෝ උඩුගත කරන්න","අපගේ නව නිෂ්පාදන","පැවරුම","වීඩියෝ","චැට්","Other Services"],
    ]
    
    
    var mainSchoolIconsArray = ["emergency","GeneralVoice","PrincipalText","notice","events","ImagePdf","AbsenteesReport","school_strength","school_strength","PrincipalTextHW","voice_homework","exam","absentees","MsgFromMgmt","FeedBack","Library","ConferenceCall","PrincipalLeaveReq","BookIcon","meet","video","offer","assignment","VimeoVideo","IconChat","otherservice","onlineclass"]
    
    var mainSchoolStaffArrray = ["en" : ["Emergency Voice","Voice to Parents App","Text to Parents App","Notice Board","School / Class Events","Image/PDF Upload","Absenteeism Report","School Strength","School Strength","Text Homework","Voice Homework","Schedule Exam/Test","Attendance Marking","Messages From Management","Feedback","Library Details","Conference Call with Teachers","Leave Requests","Online Text Book","Online Text Book","Assignment","","Assignment","Video","Chat", "","onlineclass"],
                                 "si" : ["හදිසි කටහ","දෙමාපියන්ට voice","දෙමාපිය යෙදුමට කෙටි පණිවිඩයක් යවන්න","දැන්වීම් පුවරුව","පාසල් / පන්ති සිදුවීම්","රූපය / PDF උඩුගත කිරීම","නොපැමිණීමේ වාර්තාව","පාසල් ශක්තිය","පාසල් ශක්තිය","පෙළ ගෙදර වැඩ","voice ගෙදර වැඩ","උපලේඛන විභාගය / පරීක්ෂණය","පැමිණීමේ ලකුණු කිරීම","කළමනාකරණයෙන් පණිවිඩ","ප්‍රතිපෝෂණය","පුස්තකාල විස්තර","ගුරුවරුන් සමඟ සම්මන්ත්‍රණ ඇමතුම","ඉල්ලීම් අත්හරින්න","මාර්ගගත පෙළ පොත","මාර්ගගත පෙළ පොත","පැවරුම","","පැවරුම","වීඩියෝ","චැට්"],
                                 
                                 "ar" : ["صوت الطوارئ","صوت للآباء / الموظفين","النص إلى الآباء / الموظفين","النص إلى تطبيق الآباء","تطبيق صوت الآباء","تحميل صورة / PDF","تقرير التغيب","قوة المدرسة","قوة المدرسة","نص الواجبات المنزلية","صوت واجبات منزلية","امتحان / جدول اختبار","علامات الحضور","رسائل من الإدارة","ردود الفعل","تفاصيل المكتبة","مؤتمر نداء مع المعلمين","ترك طلبات","كتاب النصوص على الانترنت","كتاب النصوص مهمة","","","مهمة","فيديو","دردشة","","onlineclass"],
                                 
                                 "fr" :["Voix d'urgence","Voice to Parents App","Texte aux parents App","Tableau d'affichage","École / Classe Événements","Téléchargement d'image / PDF","Rapport d'absentéisme","Force scolaire","Force scolaire","Texte Devoirs","Suara Kerja rumah","Calendrier examen / test","Marquage de présence","Messages de gestion","Retour d'information","Détails de la bibliothèque","Conférence téléphonique avec les enseignants","Demandes de congé","Livre de texte en ligne","Livre de texte en ligne","","","affectation","vidéo","Bavarder","","onlineclass"],
                                 
                                 "ms":  ["Suara Kecemasan","Suara untuk Ibu Bapa App","Teks kepada Ibu Bapa App","Papan kenyataan","Sekolah / Kelas Peristiwa  ","Muat naik Imej / PDF","Laporan Absenteeism","Kekuatan Sekolah","Kekuatan Sekolah","Kerja rumah teks","Kerja Rumah Suara","Jadual Peperiksaan / Ujian","Menanda Kehadiran","Mesej Dari Pengurusan","Maklumbalas","Butiran Perpustakaan","Panggilan Persidangan Dengan Guru","Tinggalkan Permintaan","Buku Teks Dalam Talian","Buku Teks Dalam Talian","","","Tugasan","Video","Sembang","","onlineclass"],
                                 
                                 "es": ["Voz de emergencia","Voice to Parents App","Text to Parents App","Tablón de anuncios","Escuela / eventos de clase","Image / PDF Upload","Informe de absentismo","Fuerza escolar","Fuerza escolar","Tarea de texto","Tarea de voz","Programar Examen / Prueba","Marca de asistencia","Mensajes de la gerencia","Realimentación","Detalles de la biblioteca","Llamada de conferencia con los maestros","Solicitudes de licencia","Libro de texto en línea","Libro de texto en línea","","","Asignación","Vídeo","Charla","","onlineclass"],
                                 
                                 "de" : ["Notstimme","Stimme für Eltern App","Text an Eltern App","Schild","Schul- / Klassenveranstaltungen","Bild / PDF-Upload","Fehlzeitenbericht","Schulstärke","Schulstärke","Text Hausaufgaben","Stimme Hausaufgaben","Prüfung / Test planen","Anwesenheitskennzeichnung","Nachrichten aus dem Management","Feedback","Bibliotheksdetails","Telefonkonferenz mit Lehrern","Urlaubsanträge","Online Text Book","Online Text Book","","","Opgave","Video","Snak","","onlineclass"],
                                 
                                 "it" : ["Voice di emergenza","App Voice to Parents","App Text to Parents","Bacheca","Eventi scuola / classe","Caricamento immagine / PDF","Rapporto sull'assenteismo","Forza della scuola","Forza della scuola","Compiti di testo","Compiti vocali","Programma esame / test","Marcatura presenze","Messaggi dalla gestionem","Risposta","Dettagli della biblioteca","Conference Call con gli insegnanti","Invia richieste","Libro di testo online","Libro di testo online","","","Incarico","Video","Video","","onlineclass"],
                                 
    ]
    
    
    var mainSchoolGroupHeadSegueArray =  ["EmergencyVoiceSegue","VoiceMessageSegue","TextMessageSegue","NoticeBoardSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","TextMessageSegue","OfferMessageSegue","","VideoMessageSegue","OfferMessageSegue","","CreateAssignmentSegue","UploadVimeoVideoSegue","studentChatSegue","","",""]
    
    var mainSchoolAdminSegueArray = ["NoticeBoardSegue","NoticeBoardSegue","NoticeBoardSegue","NoticeBoardSegue","AttendanceMessageSegue","AttendanceMessageSegue","AttendanceMessageSegue","AttendanceMessageSegue","AttendanceMessageSegue","AttendanceMessageSegue","AttendanceMessageSegue","AttendanceMessageSegue","AttendanceMessageSegue","MsgMgmtSegue","AttendanceMessageSegue","AttendanceMessageSegue","AttendanceMessageSegue","AttendanceMessageSegue","","","","","UploadVimeoVideoSegue","UploadVimeoVideoSegue","studentChatSegue"]
    
    
    
    
    var mainSchoolPrincipalSegueArray : [String] = []
    
    
    
    var mainSchoolStaffSegueArray : [String] = []
    
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("didFinishLaunchingWithOptions11",isPasswordBind)
        isPasswordBind = String(1)
        
        print("didFinishLaunchingWithOptions",isPasswordBind)
        FirebaseApp.configure()
        Fabric.with([Crashlytics.self])
        emptyAssignment()
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        //DB creating
        Util.copyFile("school.sqlite")
        Util.openDatabase()
        Messaging.messaging().delegate = self
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        }
        
        
        initializeS3()
        
        let deviceid = UIDevice.current.identifierForVendor?.uuidString
        print("deviceiddeviceid",deviceid)
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge,.sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        
        return true
    }
    
    
    
    
    
//    func playAudioFile(named fileName: String, fileType: String) {
//            // Get the file path
//        
//        print("playAudioFileplayAudioFile")
//            guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileType) else {
//                print("Audio file not found.")
//                return
//            }
//            
//            let fileURL = URL(fileURLWithPath: filePath)
//            
//            do {
//                // Initialize the audio player
//                audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
//                audioPlayer?.prepareToPlay()
//                audioPlayer?.play() // Start playback
//            } catch {
//                print("Error playing audio: \(error.localizedDescription)")
//            }
//        }
    
    
    func playAudio(from urlString: String) {
            guard let url = URL(string: "https://schoolchimes-files-india.s3.ap-south-1.amazonaws.com/communication/IOS+App/schoolchimes_tone.wav"
        ) else {
                print("Invalid URL")
                return
            }
            player = AVPlayer(url: url)
            player?.play()
            print("Playing audio...")
        }

        func stopAudio() {
            player?.pause()
            player = nil
            print("Audio stopped.")
        }

        private func configureAudioSession() {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                try AVAudioSession.sharedInstance().setActive(true)
                print("Audio session configured for background playback.")
            } catch {
                print("Failed to configure audio session: \(error.localizedDescription)")
            }
        }
    
    func registerNotificationCategories() {
        let callCategory = UNNotificationCategory(
            identifier: "CALL_CATEGORY",
            actions: [], // Add any custom actions here if needed
            intentIdentifiers: [],
            options: .customDismissAction
        )
        UNUserNotificationCenter.current().setNotificationCategories([callCategory])
    }
    func clearNotification(){
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests() // To remove all pending notifications which are not delivered yet but scheduled.
            center.removeAllDeliveredNotifications() // To remove all delivered notifications
        } else {
            UIApplication.shared.cancelAllLocalNotifications()
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        self.appIsStarting = false
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("APNs device token: \(deviceTokenString)")
        strDeviceToken = Util.checkNil(deviceTokenString) as String
        
        if(strDeviceToken.count == 0) {
            strDeviceToken = "1234"
        }
        
        print("APNs device token: \(deviceTokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        strDeviceToken = "1234"
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Recived: \(userInfo)")
        completionHandler(.newData)
        self.playSound(userInfo: userInfo)
        
        
        if let type = userInfo[AnyHashable("type")] as? String {
            print("Type: \(type)")
            
            if type == "isCall"{
                if let url = userInfo[AnyHashable("url")] as? String {
                    print("URL: \(url)")
                    
                    navigateToViewController(with: URL(string: url)!, userInfo: userInfo)
                }
            }
        }

        
        
        application.applicationIconBadgeNumber = 1
        application.applicationIconBadgeNumber = 0
        if(isPopupOpened == 0){
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name(rawValue: "PushNotification"), object: nil)
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        application.applicationIconBadgeNumber = 1
        application.applicationIconBadgeNumber = 0
        if(isPopupOpened == 0){
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name(rawValue: "PushNotification"), object: nil)
        }
    }
    
    
    
    func playSound(userInfo: [AnyHashable : Any]) {
        var msgsound = userInfo["tone"] as? String ?? "TEST_MESSAGE"
        var ext = ".wav"
        if(msgsound.lowercased() == "message"){
            msgsound = "message"
            ext = ".mp3"
        }else{
            msgsound = "emergencyvoice"
            ext = ".mp3"
//            
        }
        
        guard let url = Bundle.main.url(forResource: msgsound, withExtension: "wav") else { return }
        
        do {
            if #available(iOS 11.0, *) {
                try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, policy: .default, options: .defaultToSpeaker)
            } else {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            }
            try AVAudioSession.sharedInstance().setActive(true)
            
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = 1
            player.play()
            
        }
        catch let error {
            print("error\(error)")
            print(error.localizedDescription)
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        
        
        Id = 1
//        playAudioFile(named: "schoolchimes_tone", fileType: "caf")
        
//        configureAudioSession()
//        playAudio(from: "")
        completionHandler([.alert, .badge,.sound])
        
        if(isPopupOpened == 0){
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name(rawValue: "PushNotification"), object: nil)
        }
    }
    
    
    
    
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        isPasswordBind = "1"
        
        print("applicationDidEnterBackground")
//        if Id == 1{
//            
//            playAudio(from: "")
//        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
//        if Id == 1{
//            
//            playAudio(from: "")
//        }
        
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func emptyAssignment(){
        if (UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
            print("App already launched")
        } else {
            // This is the first launch ever
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            print("App  First Time launched")
            UserDefaults.standard.set("No", forKey: AT_VERY_FIRST_TIME)
            UserDefaults.standard.set("No", forKey: COMBINATION)
            let samplearr:NSMutableArray = []
            UserDefaults.standard.set(samplearr, forKey: "UNREADCOUNT")
            UserDefaults.standard.set("en", forKey: SELECTED_LANGUAGE)
            UserDefaults.standard.set("", forKey: COUNTRY_CODE)
            UserDefaults.standard.set("", forKey: COUNTRY_ID)
            UserDefaults.standard.set("", forKey: OLD_BASE_URL)
            UserDefaults.standard.set(true, forKey: ACCEPT_TERMS_CONDITION)
            
            UserDefaults.standard.set(emptyArray, forKey: PARENT_ARRAY_INDEX)
            UserDefaults.standard.set(emptyArray, forKey: STAFF_ARRAY_INDEX)
            UserDefaults.standard.set(emptyArray, forKey: PRINCIPLE_ARRAY_INDEX)
            UserDefaults.standard.set(emptyArray, forKey: ADMIN_ARRAY_INDEX)
            UserDefaults.standard.set(emptyArray, forKey: GROUPHEAD_ARRAY_INDEX)
            UserDefaults.standard.set(emptyArray, forKey: LANGUAGE_ARRAY)
            
            UserDefaults.standard.set("", forKey: VIDEOJSON)
            UserDefaults.standard.set("", forKey: VIDEOSIZELIMIT)
            UserDefaults.standard.set("", forKey: VIDEOSIZELIMITALERT)
            UserDefaults.standard.set("", forKey: ADTIMERINTERVAL)
            
            UserDefaults.standard.set(false, forKey: FORGOT_PASSWORD_CLICKED)
            UserDefaults.standard.synchronize()
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken!)")
        let dataDict:[String: String] = ["token": fcmToken!]
        strDeviceToken = fcmToken ??  ""
        UserDefaults.standard.set(fcmToken, forKey: DEVICETOKEN)
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        print("dataDict: \(dataDict)")
    }
    
    
    
    
    
    
    static  var adDataList : [MenuData] = []
    
    static var getMenuId = NSString()
    
    
    
    
    
    static func AdRes(memId : String,memType : String,menu_id : String , school_id : String) {
        
        
        print("getMenuId:\(getMenuId)")
        let AdModal = AdvertismentModal()
        AdModal.MemberId = memId
        AdModal.MemberType = memType
        AdModal.MenuId = getMenuId as String
        AdModal.SchoolId = school_id
        
        
        let admodalStr = AdModal.toJSONString()
        
        
        print("admodalStr123",admodalStr)
        AdvertismentRequest.call_request(param: admodalStr!) { [self]
            
            (res) in
            
            let adModalResponse : [AdvertismentResponse] = Mapper<AdvertismentResponse>().mapArray(JSONString: res)!
            
            for i in adModalResponse {
                
                adDataList.removeAll()
                adDataList = i.data
                
                
                
            }
            
            print("admodalStr_count", adDataList .count)
            
            
            
            
        }
        
    }
    
    func initializeS3() {
        let poolId = DefaultsKeys.CognitoPoolID // 3-1
        print("poolIdpoolIdpoolId",poolId)
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .APSouth1, identityPoolId: poolId)//3-2
        let configuration = AWSServiceConfiguration(region: .APSouth1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        
    }
    
    
    func navigateToViewController(with wavURL: URL,userInfo:[AnyHashable : Any]) {
           
        let vc = getCurrentViewController()

        let vcc = NotificationCallingscreen(nibName: nil, bundle: nil)
        vcc.userInfo = userInfo
        vcc.urlss = wavURL.absoluteString
        vcc.modalPresentationStyle = .fullScreen

        vc?.present(vcc, animated: true)
                          
        
            }
//
       
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }
    
    
    
    
    
}

