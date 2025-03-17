//
//  VocieMessageVC.swift
//  VoicesnapSchoolApp
//
//  Created by Shenll-Mac-04 on 18/07/17.
//  Copyright © 2017 Shenll-Mac-04. All rights reserved.
////

import UIKit
import AVFoundation
import FSCalendar

class VocieMessageVC: UIViewController,AVAudioRecorderDelegate, AVAudioPlayerDelegate,UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,Apidelegate,UIDocumentPickerDelegate, FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var DonotDialBeyondLbl: UILabel!
    @IBOutlet weak var cv: UICollectionView!
    
    @IBOutlet weak var InitiateCallOnLbl: UILabel!
    @IBOutlet weak var cvconstant: NSLayoutConstraint!
    @IBOutlet weak var showSheduleInstantCallHeight: NSLayoutConstraint!
    @IBOutlet weak var fsCaleView: FSCalendar!
    
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var addFileDefaultLbl: UILabel!
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var doNotCallLbl: UILabel!
    
    @IBOutlet weak var selectDateView: UIView!
    @IBOutlet weak var initiateCallLbl: UILabel!
    @IBOutlet weak var initiateCallView: UIView!
    
    @IBOutlet weak var doNotCallView: UIView!
    @IBOutlet weak var sheduleCallListView: UIView!
    @IBOutlet weak var showScheduleInstantCallView: UIView!
    @IBOutlet weak var selectedDatesLbl: UILabel!
    
    @IBOutlet weak var pathImg: UIImageView!
    @IBOutlet weak var pathLbl: UILabel!
    @IBOutlet weak var instantImg: UIImageView!
    @IBOutlet weak var voiceView: UIView!
    @IBOutlet weak var scheduleView: UIImageView!
    @IBOutlet weak var scheduleCallView: UIView!
    
    @IBOutlet weak var instantCallView: UIView!
    @IBOutlet weak var groupHeadSelectStandardBtn: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var TimeTitleLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ListenVoiceMsglabel: UILabel!
    @IBOutlet weak var VoiceMessageLabel: UILabel!
    @IBOutlet weak var currentPlayTimeLabel: UILabel!
    @IBOutlet weak var AudioSlider: UISlider!
    @IBOutlet weak var playVoiceMessageView: UIView!
    @IBOutlet weak var VoiceRecordTimeLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var VocieRecordButton: UIButton!
    @IBOutlet weak var PlayVocieButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var VoiceRecordView: UIView!
    @IBOutlet weak var scheduleCallLbl: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var instantCallHeadLbl: UILabel!
    
    //MARK: Voice History
    @IBOutlet var voiceHistoryTableView: UITableView!
    @IBOutlet weak var voiceHistoryView: UIView!
    @IBOutlet weak var NewVoicerecordImage: UIImageView!
    @IBOutlet weak var VoiceHistoryImage: UIImageView!
    @IBOutlet weak var NewVoiceRecordingLabel: UILabel!
    @IBOutlet weak var SelectFromVoiceHistoryLabel: UILabel!
    
    var ApiHomeWorkSecondInt = Int()
    var timer = Timer()
    var audioPlayer : AVAudioPlayer!
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    var meterTimer:Timer!
    var recordingSession : AVAudioSession!
    var audioRecorder    : AVAudioRecorder!
    var settings         = [String : Int]()
    var strPlayStatus : NSString = ""
    var time : Float64 = 0;
    var sliderIndex : NSInteger = NSInteger()
    var urlData: URL?
    var TotaldurationFormat = String()
    var durationString = String()
    var durationInteger = Int()
    var selectedSchoolID = NSString()
    var selectedStaffID = NSString()
    var count = Int()
    var selectedSchoolDictionary = NSMutableDictionary()
    var MaxMinutes = Int()
    var MaxSeconds = Int()
    var SelectHistory:Bool = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var CallerTyepString = String()
    var selectedSchoolsArray = NSMutableArray()
    var schoolsArray = NSMutableArray()
    var VoiceData : NSData? = nil
    var hud : MBProgressHUD = MBProgressHUD()
    var popupLoading : KLCPopup = KLCPopup()
    var SelectedArray = NSArray()
    let UtilObj = UtilClass()
    var HomeWorkSecondStr = Int()
    var strSchoolID = String()
    var strStaffID = String()
    var fromView = String()
    var strApiFrom = NSString()
    var voiceHistoryArray = NSMutableArray()
    var SelectedVoiceHistoryArray = NSMutableArray()
    var SelectedVoiceDict = NSDictionary()
    var SchoolDict = NSDictionary()
    var languageDictionary = NSDictionary()
    var strFromVC = String()
    var strLanguage = String()
    var strCountryCode = String()
    var strNoRecordAlert = String()
    var strNoInternet = String()
    var strSomething = String()
    var checkSchoolId : String = "0"
    var checkMultipleType : String!
    var groupHeadRole : String!
    
    var call_back: [((String) -> Void)]?
    
    var id = 0
    var timer1: Timer?
    
    var display_date : String!
    
    var url_time: String!
    
    var timesPath : String!
    var filePathAudio : String!
    var dateArr : [String] = []
    var intDateArr : [Int] = []
    var timeId  = ""
    let rowId = "ScheduleCallCollectionViewCell"
    var SchoolDetailDict = NSDictionary()
    var school_type : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        let userDefaults = UserDefaults.standard
        DefaultsKeys.dateArr.removeAll()
        pathLbl.text = ""
        pathImg.isHidden = true
        pathLbl.isHidden = true
        
        calendarView.isHidden  = true
        doneView.isHidden  = true
        fsCaleView.isHidden  = true
        InitiateCallOnLbl.text = commonStringNames.InitiateCallOn.translated()
        DonotDialBeyondLbl.text = commonStringNames.DoNotDialBeyond.translated()
        addFileDefaultLbl.text = commonStringNames.AddMp3File.translated()
        selectedDatesLbl.text = commonStringNames.SelectedDates.translated()
        scheduleCallLbl.text = commonStringNames.scheduleCall.translated()
        instantCallHeadLbl.text = commonStringNames.instantCall.translated()
        DefaultsKeys.SelectInstantSchedule = 0
        SchoolDetailDict = appDelegate.LoginSchoolDetailArray[0] as! NSDictionary
        school_type = userDefaults.string(forKey: DefaultsKeys.school_type)
        cv.isHidden  = true
        cv.register(UINib(nibName: rowId, bundle: nil), forCellWithReuseIdentifier: rowId)
        
        if school_type == "2" {
            showScheduleInstantCallView.isHidden = false
            showSheduleInstantCallHeight.constant = 40
        }else{
            showScheduleInstantCallView.isHidden = true
            showSheduleInstantCallHeight.constant  = 0
            
        }
        sheduleCallListView.isHidden = true
        initiateCallView.isHidden = true
        doNotCallView.isHidden = true
        selectDateView.isHidden = true
        
        fsCaleView.delegate = self
        fsCaleView.dataSource = self
        
        fsCaleView.allowsMultipleSelection = true
        pathImg.isHidden = true
        var staffDisplayRole : String!
        staffDisplayRole = userDefaults.string(forKey: DefaultsKeys.staffDisplayRole)
        groupHeadRole = userDefaults.string(forKey: DefaultsKeys.getgroupHeadRole)
        
        let doNotCallGes = deleteGesture(target: self, action: #selector(doNotCallAction))
        doNotCallGes.id = 2
        doNotCallView.addGestureRecognizer(doNotCallGes)
        
        let initiateCallGes = deleteGesture(target: self, action: #selector(initiateCallAction))
        initiateCallGes.id = 1
        initiateCallView.addGestureRecognizer(initiateCallGes)
        
        let calendarGes = UITapGestureRecognizer(target: self, action: #selector(calendarAction))
        selectDateView.addGestureRecognizer(calendarGes)
        
        let doneGes = UITapGestureRecognizer(target: self, action: #selector(doneActionVc))
        doneView.addGestureRecognizer(doneGes)
        
        groupHeadSelectStandardBtn.isHidden = true
        if groupHeadRole == "Group Head" {
            groupHeadSelectStandardBtn.isHidden = false
            
        }
        
        if staffDisplayRole == "Principal" {
            strFromVC = "Principal"
        }
        
        let nc = NotificationCenter.default
        nc.addObserver(self,selector: #selector(VocieMessageVC.catchNotification), name: NSNotification.Name(rawValue: "comeBackMenu"), object:nil)
        sendButton.layer.cornerRadius = 5
        sendButton.layer.masksToBounds = true
        
        if checkMultipleType != "1" {
            let defaults = UserDefaults.standard
            strStaffID = userDefaults.string(forKey: DefaultsKeys.StaffID)!
            strSchoolID = userDefaults.string(forKey: DefaultsKeys.SchoolD)!
        }
        
        let instantGes  = UITapGestureRecognizer(target: self, action: #selector(instantAction))
        instantCallView.addGestureRecognizer(instantGes)
        let scheduleGes  = UITapGestureRecognizer(target: self, action: #selector(scheduleAction))
        scheduleCallView.addGestureRecognizer(scheduleGes)
        let voiceGes  = UITapGestureRecognizer(target: self, action: #selector(addFileAct))
        voiceView.addGestureRecognizer(voiceGes)
    }
    
    @IBAction func doNotCallAction() {
        timeId = "2"
        timeSS()
    }
    
    @IBAction func instantAction() {
        instantImg.image = UIImage(named: "PurpleRadioSelect")
        scheduleView.image = UIImage(named: "RadioNormal")
        DefaultsKeys.SelectInstantSchedule = 0
        initiateCallView.isHidden = true
        doNotCallView.isHidden = true
        sheduleCallListView.isHidden = true
        cv.isHidden = true
        selectDateView.isHidden = true
        cvconstant.constant = 0
        calendarView.isHidden  = true
        doneView.isHidden  = true
        fsCaleView.isHidden  = true
        checkHistoryArray()
    }
    
    @IBAction func scheduleAction() {
        self.SelectedVoiceHistoryArray.removeAllObjects()
        self.voiceHistoryTableView.reloadData()
        ValidateField()
        instantImg.image = UIImage(named: "RadioNormal")
        scheduleView.image = UIImage(named: "PurpleRadioSelect")
        sheduleCallListView.isHidden = false
        initiateCallView.isHidden = false
        doNotCallView.isHidden = false
        DefaultsKeys.SelectInstantSchedule = 1
        
        calendarView.isHidden  = true
        doneView.isHidden  = true
        fsCaleView.isHidden  = true
        selectDateView.isHidden = false
        cv.isHidden = false
        if dateArr.count >= 6{
            cvconstant.constant = 200
        }else{
            cvconstant.constant = CGFloat(30*dateArr.count)
        }
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    override func viewWillAppear(_ animated: Bool){
        print("viewWillAppeaeeeefrsfsfsfsr",TitleLabel.text)
        //        TitleLabel.text?.translated()
        strCountryCode = UserDefaults.standard.object(forKey: COUNTRY_CODE) as! String
        
        self.callSelectedLanguage()
    }
    
    func Config(){
        
        
        let idGroupHead = appDelegate.idGroupHead as NSString
        if(idGroupHead .isEqual(to: "true")){
            self.sendButton.setTitle( commonStringNames.teacher_Select_school.translated() as? String, for: .normal)
            for  schoolDict in appDelegate.LoginSchoolDetailArray {
                let singleSchoolDictionary = schoolDict as? NSDictionary
                let schoolDic = NSMutableDictionary()
                schoolDic["SchoolID"] = singleSchoolDictionary?.object(forKey: "SchoolID")
                schoolDic["StaffID"] = singleSchoolDictionary?.object(forKey: "StaffID")
                schoolsArray.add(schoolDic)
                selectedSchoolsArray.add(schoolDic)
            }
            SelectedArray = selectedSchoolsArray
        }else{
            if groupHeadRole == "Group Head" {
                groupHeadSelectStandardBtn.isHidden = false
                sendButton.setTitle(commonStringNames.teacher_Select_school.translated() as? String, for: .normal)
                
            }else{
                sendButton.setTitle(commonStringNames.select_reciepients.translated() as? String, for: .normal)
            }
        }
        
        if(schoolsArray.count > 0){
            let singleSchoolDictionary = schoolsArray[0] as! NSDictionary
            self.strSchoolID = singleSchoolDictionary.object(forKey: "SchoolID") as! String
            self.strStaffID = singleSchoolDictionary.object(forKey: "StaffID") as! String
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.location == 0 && string == " " {
            return false
        }
        return true
        
    }
    func ConfigSendButton(){
        if( durationString != "0"){
            self.enableButton()
        }else{
            self.disableButton()
        }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopTimer()
        PlayVocieButton.isSelected = false
        AudioSlider.value = 0
        currentPlayTimeLabel.text = formatTime(time: 0)
        
    }
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?){
        
    }
    internal func audioPlayerBeginInterruption(_ player: AVAudioPlayer){
        
    }
    
    func directoryURL() -> NSURL? {
        
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        
        let soundURL = documentDirectory.appendingPathComponent("sample.mp4")
        
        return soundURL as NSURL?
    }
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            
            audioRecorder = try AVAudioRecorder(url: self.directoryURL()! as URL,
                                                settings: settings)
            urlData = audioRecorder.url
            selectedSchoolsArray = NSMutableArray(array: SelectedArray)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            
            
        } catch {
            finishRecording(success: false)
        }
        do {
            try audioSession.setActive(true)
            audioRecorder.record()
        } catch {
        }
    }
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        if success {
            
            audioRecorder = nil
            
        } else {
            audioRecorder = nil
            
        }
    }
    
    // MARK: VOICE RECORDING BUTTON ACTION
    
    @IBAction func actionVoiceRecording(_ sender: UIButton){
        descriptionTextField.resignFirstResponder()
        self.playerDidFinishPlaying()
        disableButton()
        calendarView.isHidden  = true
        doneView.isHidden  = true
        fsCaleView.isHidden  = true
        pathImg.isHidden = true
        pathLbl.isHidden = true
        if audioRecorder == nil {
            self.TitleForStopRecord()
            self.VocieRecordButton.setBackgroundImage(UIImage(named:"VoiceRecordSelect"), for: UIControl.State.normal)
            playVoiceMessageView.isHidden = true
            count = 0
            self.startRecording()
            
            self.meterTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                                   target:self,
                                                   selector:#selector(self.updateAudioMeter(_:)),
                                                   userInfo:nil,
                                                   repeats:true)
        }else{
            self.funcStopRecording()
            
        }
        
    }
    
    func funcStopRecording(){
        self.TitleForStartRecord()
        self.VocieRecordButton.setBackgroundImage(UIImage(named:"VocieRecord"), for: UIControl.State.normal)
        
        self.finishRecording(success: true)
        playVoiceMessageView.isHidden = false
        calucalteDuration()
        if(UIDevice.current.userInterfaceIdiom == .pad){
            count = appDelegate.LoginSchoolDetailArray.count
            self.durationLabel.text = TotaldurationFormat
            self.currentPlayTimeLabel.text = "00.00"
        }else{
            count = appDelegate.LoginSchoolDetailArray.count
            self.durationLabel.text = TotaldurationFormat
            self.currentPlayTimeLabel.text = "00.00"
        }
        self.ValidateField()
        
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    @objc func updateSlider(){
        
        print("helooo")
        if self.player!.currentItem?.status == .readyToPlay {
            print("helooo1")
            time = CMTimeGetSeconds(self.player!.currentTime())
        }
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        AudioSlider.maximumValue = Float(seconds)
        AudioSlider.minimumValue = 0.0
        
        AudioSlider.value = Float(time)
        
        if(time > 0){
            print("helooo2")
            let minutes = Int(time) / 60 % 60
            let secondss = Int(time) % 60
            MaxSeconds = secondss
            let durationFormat = String(format:"%02i:%02i", minutes, secondss)
            currentPlayTimeLabel.text = durationFormat
            
        }
        
        if(time == seconds){
            
            print(" PlayVocieButton.isSelected = false PlayVocieButton.isSelected = false")
            // print("finished time!!")
            timer.invalidate()
            PlayVocieButton.isSelected = false
            AudioSlider.value = 0.0
        }
    }
    
    
    
    func playAudio(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            AudioSlider.maximumValue = Float(audioPlayer?.duration ?? 0)
            durationLabel.text = formatTime(time: audioPlayer?.duration ?? 0)
            
            startTimer()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    
    
    func startTimer() {
        timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider1), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer1!.invalidate()
        timer1 = nil
    }
    
    @objc func updateSlider1() {
        AudioSlider.value = Float(audioPlayer?.currentTime ?? 0)
        currentPlayTimeLabel.text = formatTime(time: audioPlayer?.currentTime ?? 0)
    }
    
    @objc func sliderValueChanged() {
        audioPlayer?.currentTime = TimeInterval(AudioSlider.value)
        currentPlayTimeLabel.text = formatTime(time: audioPlayer?.currentTime ?? 0)
    }
    
    func formatTime(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func actionPlayButton(){
        
        
        
        
        if id == 0 {
            
            
            
            if(PlayVocieButton.isSelected){
                print("strPlayStatus4")
                PlayVocieButton.isSelected = false
                
                audioPlayer?.pause()
                
            }else{
                
                print("strPlayStatus3")
                PlayVocieButton.isSelected = true
                
                
                playAudio(url: urlData!)
            }
            
            
        }
        
        else{
            
            
            playerItem = AVPlayerItem(url: urlData!)
            
            player = AVPlayer(playerItem: playerItem!)
            
            print("strPlayStatus2")
            if(strPlayStatus.isEqual(to: "close")){
                
                print("strPlayStatus1")
                AudioSlider.value = 0.0
            }
            if(PlayVocieButton.isSelected){
                print("strPlayStatus4")
                PlayVocieButton.isSelected = false
                
                let seconds1 : Int64 = Int64(AudioSlider.value)
                let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
                
                player!.seek(to: targetTime)
                strPlayStatus = "play"
                player?.pause()
                
                
                
            }else{
                
                print("strPlayStatus3")
                PlayVocieButton.isSelected = true
                
                
                let seconds1 : Int64 = Int64(AudioSlider.value)
                let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
                player!.seek(to: targetTime)
                
                print("targetTime",targetTime)
                strPlayStatus = "play"
                player?.volume = 1
                player?.play()
                
            }
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            
            
            
        }
    }
    
    @objc func updateAudioMeter(_ timer:Timer) {
        
        if let audioRecorder1 = self.audioRecorder {
            if audioRecorder1.isRecording {
                let min = Int(audioRecorder1.currentTime / 60)
                let sec = Int(audioRecorder1.currentTime.truncatingRemainder(dividingBy: 60))
                let s = String(format: "%02d:%02d", min, sec)
                let SecString = sec
                VoiceRecordTimeLabel.text = s
                audioRecorder1.updateMeters()
                if(HomeWorkSecondStr < 60){
                    if(sec == ApiHomeWorkSecondInt){
                        self.funcStopRecording()
                    }
                }else{
                    if(min == ApiHomeWorkSecondInt)
                    {
                        self.funcStopRecording()
                    }
                }
                
            }
        }
    }
    
    func playbackSliderValueChanged(playbackSlider:UISlider){
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime : CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        if(player != nil){
            player!.seek(to: targetTime)
            
        }else{
            
            AudioSlider.value = playbackSlider.value
        }
        
    }
    
    func calucalteDuration() -> Void{
        playerItem = AVPlayerItem(url: urlData!)
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        
        AudioSlider.maximumValue = Float(seconds)
        
        let minutes = Int(seconds) / 60 % 60
        let secondss = Int(seconds) % 60
        durationInteger =  Int(seconds)
        durationString = String(format:"%i",Int(seconds))
        
        if(strLanguage == "ar"){
            TotaldurationFormat = String(format:"%02i:%02i/", minutes, secondss)
        }else{
            TotaldurationFormat = String(format:"/ %02i:%02i", minutes, secondss)
        }
        
        durationLabel.text = TotaldurationFormat
        
    }
    // MARK: Player close
    
    func playerDidFinishPlaying() {
        
        print("strPlayStatusww",strPlayStatus)
        
        if(player != nil){
            timer.invalidate()
            player?.pause()
            
            AudioSlider.value = 0.0
            player?.rate = 0.0
            currentPlayTimeLabel.text = "00.00"
            print("PlayVocieButton.isSelected",PlayVocieButton.isSelected)
            PlayVocieButton.isSelected = false
            print("PlayVocieButton.isSelected111",PlayVocieButton.isSelected)
            
            strPlayStatus = "close"
            player = nil
            player =  AVPlayer.init()
            playerItem?.seek(to: CMTime.zero)
            time = CMTimeGetSeconds(self.player!.currentTime())
        }
    }
    
    //MARK:Play Audio BUTTON ACTION
    
    @IBAction func actionPlayVoiceMessage(_ sender: UIButton){
        
        
        calucalteDuration()
        print("actionPlayVoiceMessage")
        actionPlayButton()
        
        
        audioRecorder = nil
        
    }
    @IBAction func actionSliderButton(_ sender: UISlider) {
        playbackSliderValueChanged(playbackSlider: AudioSlider)
    }
    
    
    // MARK: BUTTON ACTION
    
    @IBAction func actionNextButton(_ sender: UIButton) {
        
        self.playerDidFinishPlaying()
        DispatchQueue.main.async {
            
        }
    }
    
    @IBAction func actionCloseView(_ sender: UIButton) {
        // closePlayAudioFileButton()
        self.playerDidFinishPlaying()
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func actionSendButton (_ sender: UIButton) {
        if(Util .isNetworkConnected()){
            if( durationString != "0")
            {
                print("groupHeadRole11",groupHeadRole)
                if groupHeadRole == "Group Head" {
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "VoiceMessageToSchoolSelectionSegue", sender: self)
                    }
                }else {
                    if(strFromVC == "Principal"){
                        if(self.fromView == "Record"){
                            print("THIS23")
                            selectedSchoolDictionary["Description"] = descriptionTextField.text!
                            selectedSchoolDictionary["Duration"] = durationString
                        }else{
                            print("THIS2365789")
                            let voiceDict =  SelectedVoiceHistoryArray[0] as! NSDictionary
                            selectedSchoolDictionary["Description"] = String(describing: voiceDict["Description"]!)
                            selectedSchoolDictionary["Duration"] = String(describing: voiceDict["Duration"]!)
                        }
                        selectedSchoolDictionary["SchoolID"] = strSchoolID as NSString
                        selectedSchoolDictionary["StaffID"] = strStaffID as NSString
                        
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "VoiceToPrincipalGroupSegue", sender: self)
                        }
                    }else{
                        DispatchQueue.main.async {
                            print("THIS")
                            self.performSegue(withIdentifier: "VoiceMessageToSchoolSelectionSegue", sender: self)
                        }
                    }
                    
                }
                
            }
        }else{
            Util .showAlert("", msg: strNoInternet)
        }
        
    }
    
    @IBAction func actionNewVoiceRecording(){
        SelectHistory = false
        self.fromView = "Record"
        self.VoiceRecordView.isHidden = false
        self.voiceHistoryView.isHidden = true
        instantCallView.isHidden = false
        scheduleView.isHidden = false
        self.NewVoicerecordImage.image = UIImage(named: "PurpleRadioSelect")
        self.VoiceHistoryImage.image = UIImage(named: "RadioNormal")
        checkRecordAction()
    }
    
    @IBAction func actionVoiceRecordingHistory(){
        
        if DefaultsKeys.SelectInstantSchedule == 0{
            checkHistoryArray()
        }
        SelectHistory = true
        urlData = nil
        calendarView.isHidden  = true
        doneView.isHidden  = true
        fsCaleView.isHidden  = true
        self.fromView = "History"
        self.VoiceRecordView.isHidden = true
        self.voiceHistoryView.isHidden = false
        instantCallView.isHidden = false
        scheduleView.isHidden = false
        self.NewVoicerecordImage.image = UIImage(named: "RadioNormal")
        self.VoiceHistoryImage.image = UIImage(named: "PurpleRadioSelect")
        self.callVoiceHistoryApi()
        if DefaultsKeys.SelectInstantSchedule != 0 {
            self.ValidateField()
            scheduleAction()
            if dateArr.count >= 6{
                cvconstant.constant = 200
            }else{
                cvconstant.constant = CGFloat(30*dateArr.count)
            }
        }
    }
    
    func checkRecordAction(){
        let strDurationString : NSString = durationString as NSString
        if(strDurationString.integerValue > 0){
            self.enableButton()
            
        }else{
            playVoiceMessageView.isHidden = true
            self.disableButton()
        }
    }
    
    func checkHistoryArray(){
        if(self.SelectedVoiceHistoryArray.count > 0){
            self.enableButton()
        }else{
            self.disableButton()
        }
    }
    
    func enableButton(){
        sendButton.isUserInteractionEnabled = true
        sendButton.backgroundColor = UIColor(red: 36.0/255.0, green: 187.0/255.0, blue: 89.0/255.0, alpha: 1)
        groupHeadSelectStandardBtn.isUserInteractionEnabled = true
        groupHeadSelectStandardBtn.backgroundColor = UIColor(red: 36.0/255.0, green: 187.0/255.0, blue: 89.0/255.0, alpha: 1)
    }
    func disableButton(){
        sendButton.isUserInteractionEnabled = false
        sendButton.backgroundColor = UIColor(red: 185.0/255.0, green: 185.0/255.0, blue: 185.0/255.0, alpha: 1)
        groupHeadSelectStandardBtn.isUserInteractionEnabled = false
        groupHeadSelectStandardBtn.backgroundColor = UIColor(red: 185.0/255.0, green: 185.0/255.0, blue: 185.0/255.0, alpha: 1)
    }
    
    func ValidateField()
    {
        if DefaultsKeys.SelectInstantSchedule == 1 {
            if SelectHistory == true{
                if initiateCallLbl.text != "Time" && doNotCallLbl.text != "Time"  && durationString != "0" && dateArr.count != 0 && self.SelectedVoiceHistoryArray.count > 0 {
                    enableButton()
                    
                }else{
                    disableButton()
                }
            }else{
                if initiateCallLbl.text != "Time" && doNotCallLbl.text != "Time"  && durationString != "0" && dateArr.count != 0 && urlData != nil {
                    
                    enableButton()
                    
                }else{
                    disableButton()
                }
            }
        }else{
            if durationString != "0" && initiateCallLbl.text != "Time" && doNotCallLbl.text != "Time" && urlData != nil{
                enableButton()
            }else{
                disableButton()
            }
        }
    }
    
    @objc func actionVoiceHistoryCheckboxButton(sender: UIButton){
        let dict = self.voiceHistoryArray[sender.tag] as! NSDictionary
        
        if((self.SelectedVoiceHistoryArray.contains(dict))){
            self.SelectedVoiceHistoryArray.remove(dict)
        }else{
            self.SelectedVoiceHistoryArray.removeAllObjects()
            self.SelectedVoiceHistoryArray.add(dict)
        }
        self.voiceHistoryTableView.reloadData()
        
        if DefaultsKeys.SelectInstantSchedule != 0{
            if initiateCallLbl.text != "Time" && doNotCallLbl.text != "Time"  && durationString != "0" && dateArr.count != 0 && self.SelectedVoiceHistoryArray.count > 0 {
                self.enableButton()
            }else{
                self.disableButton()
            }
        }else{
            checkHistoryArray()
        }
        
    }
    
    @objc func actionplayAudioButton(sender: UIButton){
        self.SelectedVoiceDict = self.voiceHistoryArray[sender.tag] as! NSDictionary
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "VoiceMessageToDetailSeg", sender: self)
        }
    }
    
    // MARK: TITLE FOR START AND STOP RECORD
    func TitleForStartRecord(){
        let firstword : String =  commonStringNames.teacher_txt_start_record.translated() as? String ?? "Press the button to"
        let secondWord : String  =  commonStringNames.record.translated() as? String ?? " RECORD"
        let comboWord = firstword + secondWord
        let attributedText = NSMutableAttributedString(string:comboWord)
        var attrs =  [NSAttributedString.Key : NSObject]()
        var attrfirst =  [NSAttributedString.Key : NSObject]()
        
        if(UIDevice.current.userInterfaceIdiom == .pad){
            attrfirst = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),NSAttributedString.Key.foregroundColor:UIColor.black]
            attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black]
        }else{
            attrfirst = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),NSAttributedString.Key.foregroundColor:UIColor.black]
            attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
        }
        
        let range = NSString(string: comboWord).range(of: secondWord)
        let range2 = NSString(string: comboWord).range(of: firstword)
        attributedText.addAttributes(attrs, range: range)
        attributedText.addAttributes(attrfirst, range: range2)
        TitleLabel.attributedText = attributedText
        TitleLabel.textAlignment = .center
        
    }
    
    func TitleForStopRecord(){
        
        let firstword : String =  commonStringNames.teacher_txt_start_record.translated() as? String ?? "Press the button to"
        let secondWord  : String =  commonStringNames.stop_record.translated() as? String ?? " STOP RECORD"
        let comboWord = firstword + secondWord
        let attributedText = NSMutableAttributedString(string:comboWord)
        var attrs =  [NSAttributedString.Key : NSObject]()
        var attrfirst =  [NSAttributedString.Key : NSObject]()
        
        if(UIDevice.current.userInterfaceIdiom == .pad){
            attrfirst = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),NSAttributedString.Key.foregroundColor:UIColor.black]
            attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black]
        }else{
            attrfirst = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),NSAttributedString.Key.foregroundColor:UIColor.black]
            attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
            
        }
        let range = NSString(string: comboWord).range(of: secondWord)
        let range2 = NSString(string: comboWord).range(of: firstword)
        attributedText.addAttributes(attrs, range: range)
        attributedText.addAttributes(attrfirst, range: range2)
        TitleLabel.attributedText = attributedText
        TitleLabel.textAlignment = .center
        
    }
    
    func TitleForListenVoice(){
        let firstword : String = commonStringNames.listen.translated() as? String ??  "Listen"
        let secondWord : String  = commonStringNames.voice.translated() as? String ?? " Voice "
        let thirdWord  : String = commonStringNames.message.translated() as? String ?? "Message"
        let comboWord = firstword  + secondWord  + thirdWord
        let attributedText = NSMutableAttributedString(string:comboWord)
        var attrs =  [NSAttributedString.Key : NSObject]()
        var attrfirst =  [NSAttributedString.Key : NSObject]()
        
        if(UIDevice.current.userInterfaceIdiom == .pad){
            attrfirst = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),NSAttributedString.Key.foregroundColor:UIColor.black]
            attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.black]
        }else{
            attrfirst = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),NSAttributedString.Key.foregroundColor:UIColor.black]
            attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
        }
        
        let range = NSString(string: comboWord).range(of: secondWord)
        let range2 = NSString(string: comboWord).range(of: firstword)
        attributedText.addAttributes(attrs, range: range)
        attributedText.addAttributes(attrfirst, range: range2)
        if(strLanguage == "ar"){
            ListenVoiceMsglabel.textAlignment = .right
        }else{
            ListenVoiceMsglabel.textAlignment = .left
        }
        ListenVoiceMsglabel.attributedText = attributedText
        
    }
    
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        if(UIDevice.current.userInterfaceIdiom == .pad){
            return 190
        }else{
            return 175
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.voiceHistoryArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dateArr.count == 0{
            return 0
        }else{
            return dateArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rowId, for: indexPath) as! ScheduleCallCollectionViewCell
        cell.dateLbl.text = dateArr[indexPath.row]
        let deleteGes = deleteGesture(target: self, action: #selector(deleteAction))
        deleteGes.id = indexPath.row
        deleteGes.datestring = dateArr[indexPath.row]
        cell.deleteView.addGestureRecognizer(deleteGes)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2, height: 100)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyVoiceHistoryTVCell", for: indexPath) as! EmergencyVoiceHistoryTVCell
        let dict = self.voiceHistoryArray[indexPath.row] as! NSDictionary
        cell.DateLbl.text = String(describing: dict["SentOn"]!)
        cell.SubjectLbl.text = String(describing: dict["Description"]!)
        cell.playAudioButton.addTarget(self, action: #selector(actionplayAudioButton(sender:)), for: .touchUpInside)
        cell.playAudioButton.tag = indexPath.row
        cell.PressThePlayButtonLabel.text = commonStringNames.hint_play_voice.translated() as? String
        cell.playAudioButton.setTitle(commonStringNames.teacher_btn_voice_play.translated() as? String, for: .normal)
        cell.audioCheckBoxButton.tag = indexPath.row
        cell.audioCheckBoxButton.addTarget(self, action: #selector(actionVoiceHistoryCheckboxButton(sender:)), for: .touchUpInside)
        
        if(self.SelectedVoiceHistoryArray.contains(dict)){
            cell.audioCheckBoxButton.setImage(UIImage(named: "PurpleCheckBoxImage"), for: .normal)
        }else{
            cell.audioCheckBoxButton.setImage(UIImage(named: "UnChechBoxImage"), for: .normal)
        }
        return cell
        
    }
    
    
    //MARK: Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == "VoiceToPrincipalGroupSegue"){
            if checkSchoolId == "1" {
                let segueid = segue.destination as! PrincipalGroupSelectionVC
                segueid.fromViewController = "VoiceToParents"
                segueid.SchoolID = strSchoolID as NSString
                segueid.StaffID = strStaffID as NSString
                segueid.urlData = urlData
                segueid.selectedSchoolDictionary = selectedSchoolDictionary
                segueid.VoiceHistoryArray = SelectedVoiceHistoryArray
                segueid.fromView = self.fromView
                segueid.selType = "1"
            }else{
                let segueid = segue.destination as! PrincipalGroupSelectionVC
                segueid.fromViewController = "VoiceToParents"
                segueid.SchoolID = strSchoolID as! NSString
                segueid.StaffID = strStaffID as NSString
                segueid.urlData = urlData
                segueid.selectedSchoolDictionary = selectedSchoolDictionary
                segueid.VoiceHistoryArray = SelectedVoiceHistoryArray
                segueid.fromView = self.fromView
                segueid.selType = "1"
            }
            
        }else if (segue.identifier == "VoiceMessageToSchoolSelectionSegue"){
            let segueid = segue.destination as! SchoolSelectionVC
            segueid.urlData = urlData
            segueid.fromView = self.fromView
            segueid.strDuration = durationString
            segueid.strDescription = descriptionTextField.text!
            segueid.voiceHistoryArray = SelectedVoiceHistoryArray
            segueid.senderName = "GroupHeadVoice"
        }else if (segue.identifier == "VoiceMessageToDetailSeg"){
            let segueid = segue.destination as! VoiceDetailVC
            segueid.SenderName = "VoiceHistory"
            segueid.urlData = urlData
            segueid.selectedDictionary = self.SelectedVoiceDict
        }
    }
    
    
    //MARK: Api Calling
    func callVoiceToEntireSchools(){
        showLoading()
        strApiFrom = "VoiceEntireSchoolsApi"
        VoiceData = NSData(contentsOf: urlData!)
        let baseUrlString = UserDefaults.standard.object(forKey:BASEURL) as? String
        print("DefaultsKeys.SelectInstantSchedule",DefaultsKeys.SelectInstantSchedule)
        let defaults = UserDefaults.standard
        var initialTime = DefaultsKeys.initialDisplayDate
        var doNotDial =  DefaultsKeys.doNotDialDisplayDate
        
        if DefaultsKeys.SelectInstantSchedule == 0 {
            let requestStringer = baseUrlString! + SendVoiceToEntireSchools
            
            let arrUserData : NSMutableArray = []
            let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            let myDict:NSMutableDictionary = ["Description" : descriptionTextField.text!,
                                              "CallerType" : CallerTyepString,
                                              "Duration" : durationString,
                                              "isEmergency":"0",
                                              "School" : selectedSchoolsArray, COUNTRY_CODE: strCountryCode]
            arrUserData.add(myDict)
            let apiCall = API_call.init()
            apiCall.delegate = self;
            let myString = Util.convertDictionary(toString: myDict)
            apiCall.callPassVoiceParms(requestString, myString, "EmergencyVoice", VoiceData as Data?)
        }else{
            let requestStringer = baseUrlString! + ScheduleSendVoiceToEntireSchools
            
            let arrUserData : NSMutableArray = []
            let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            let myDict:NSMutableDictionary = ["Description" : descriptionTextField.text!,
                                              "CallerType" : CallerTyepString,
                                              "Duration" : durationString,
                                              "isEmergency":"0",
                                              "School" : selectedSchoolsArray, COUNTRY_CODE: strCountryCode, "StartTime" : initialTime , "EndTime" : doNotDial , "Dates" : DefaultsKeys.dateArr ]
            
            arrUserData.add(myDict)
            let apiCall = API_call.init()
            apiCall.delegate = self;
            let myString = Util.convertDictionary(toString: myDict)
            apiCall.callPassVoiceParms(requestString, myString, "EmergencyVoice", VoiceData as Data?)
        }
    }
    
    func callVoiceHistoryApi(){
        showLoading()
        strApiFrom = "VoiceHistoryApi"
        let baseUrlString = UserDefaults.standard.object(forKey:BASEURL) as? String
        var requestStringer = baseUrlString! + GetVoiceHistory
        let baseReportUrlString = UserDefaults.standard.object(forKey:NEWLINKREPORTBASEURL) as? String
        
        if(appDelegate.isPasswordBind == "1"){
            requestStringer = baseReportUrlString! + GetVoiceHistory
        }
        
        let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        let idArray : NSMutableArray = NSMutableArray()
        let schoolidArray : NSMutableArray = NSMutableArray()
        for i in 0..<appDelegate.LoginSchoolDetailArray.count{
            let Dict : NSDictionary =  appDelegate.LoginSchoolDetailArray[i] as! NSDictionary
            idArray.add(String(describing: Dict["StaffID"]!))
            schoolidArray.add(String(describing: Dict["SchoolID"]!))
            
            
        }
        
        let strStaffIDs = idArray.componentsJoined(by: "~")
        let strSchoolIDs = schoolidArray.componentsJoined(by: "~")
        
        let myDict:NSMutableDictionary = ["StaffID" : strStaffIDs,
                                          "SchoolId" : strSchoolIDs,
                                          "isEmergency": "0"]
        
        let apiCall = API_call.init()
        apiCall.delegate = self;
        let myString = Util.convertDictionary(toString: myDict)
        apiCall.nsurlConnectionFunction(requestString, myString, "VoiceHistoryApi")
    }
    
    //MARK: Api Response
    @objc func responestring(_ csData: NSMutableArray?, _ pagename: String!){
        hideLoading()
        if(csData != nil){
            if((csData?.count)! > 0){
                if(self.strApiFrom == "VoiceHistoryApi"){
                    if((csData?.count)! > 0){
                        let dicUser : NSDictionary = csData!.object(at: 0) as! NSDictionary
                        if let status = dicUser["Status"] as? NSString
                        {
                            let Status = status
                            let Message = dicUser["Message"] as! NSString
                            
                            if(Status .isEqual(to: "1")){
                                self.voiceHistoryArray = csData!
                            }else{
                                self.alertWithAction(strAlert: Message as String)
                                
                            }
                        }else{
                            Util.showAlert("", msg: strSomething )
                        }
                    }else{
                        Util.showAlert("", msg: strSomething)
                    }
                    self.voiceHistoryTableView.reloadData()
                }else if(self.strApiFrom == "VoiceEntireSchoolsApi"){
                    let dicUser : NSDictionary = csData!.object(at: 0) as! NSDictionary
                    if let status = dicUser["Status"] as? NSString{
                        let Status = status
                        let Message = dicUser["Message"] as! NSString
                        
                        if(Status .isEqual(to: "1")){
                            Util.showAlert("", msg: Message as String?)
                            dismiss(animated: false, completion: nil)
                        }else{
                            Util.showAlert("", msg: Message as String?)
                        }
                    }
                }
            }
        }else{
            Util.showAlert("", msg: strSomething)
        }
    }
    
    @objc func failedresponse(_ pagename: Error!) {
        hideLoading()
        Util .showAlert("", msg: strSomething);
    }
    
    //MARK: Loading Indicator
    func showLoading() -> Void {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.animationType = MBProgressHUDAnimationFade
        hud.labelText = "Loading"
    }
    
    func hideLoading() -> Void{
        hud.hide(true)
    }
    
    @objc func catchNotification(notification:Notification) -> Void{
        dismiss(animated: false, completion: nil)
    }
    
    func alertWithAction(strAlert : String){
        let alertController = UIAlertController(title: "", message: strAlert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: commonStringNames.teacher_btn_ok.translated() as? String, style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.actionNewVoiceRecording()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Language Selection
    
    func callSelectedLanguage(){
        strLanguage = UserDefaults.standard.object(forKey: SELECTED_LANGUAGE) as! String
        
        let bundle = Bundle(for: type(of: self))
        if let theURL = bundle.url(forResource: strLanguage, withExtension: "json") {
            do {
                let data = try Data(contentsOf: theURL)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as AnyObject {
                    self.loadLanguageData(LangDict: parsedData as! NSDictionary, Language: strLanguage)
                }else{
                    self.loadViewData()
                }
            } catch {
                self.loadViewData()
            }
        }
    }
    
    func loadLanguageData(LangDict : NSDictionary, Language : String){
        languageDictionary = LangDict
        if(Language == "ar"){
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            self.navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
            self.view.semanticContentAttribute = .forceRightToLeft
            self.VoiceMessageLabel.textAlignment = .right
            self.descriptionTextField.textAlignment = .right
            self.ListenVoiceMsglabel.textAlignment = .right
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
            self.view.semanticContentAttribute = .forceLeftToRight
            self.VoiceMessageLabel.textAlignment = .left
            self.descriptionTextField.textAlignment = .left
            self.ListenVoiceMsglabel.textAlignment = .left
        }
        self.NewVoiceRecordingLabel.text = commonStringNames.record_new_voice_msg.translated() as? String
        self.SelectFromVoiceHistoryLabel.text =  commonStringNames.record_voice_history.translated() as? String
        self.VoiceMessageLabel.text = commonStringNames.voice_compose_msg.translated() as? String
        self.descriptionTextField.placeholder = commonStringNames.teacher_txt_onwhat.translated() as? String
        strNoRecordAlert = commonStringNames.no_records.translated() as? String ?? "No Record Found"
        strNoInternet = commonStringNames.check_internet.translated() as? String ?? "Check your Internet connectivity"
        strSomething = commonStringNames.catch_message.translated() as? String ?? "Something went wrong.Try Again"
        self.loadViewData()
        
    }
    
    func loadViewData(){
        TitleForListenVoice()
        playVoiceMessageView.isHidden = true
        count = 0
        HomeWorkSecondStr = Int(appDelegate.MaxGeneralVoiceDuartionString)!
        let strSeconRecord : String = commonStringNames.teacher_txt_general_title.translated() as? String ?? "You can record general voice message upto "
        let strSeconds : String = commonStringNames.seconds.translated() as? String ?? " seconds "
        let strminutes : String = commonStringNames.minutes.translated() as? String ?? " minutes "
        
        if(HomeWorkSecondStr < 60)
        {
            UtilObj.printLogKey(printKey: "", printingValue: HomeWorkSecondStr)
            ApiHomeWorkSecondInt = HomeWorkSecondStr
            TimeTitleLabel.text = strSeconRecord + String(ApiHomeWorkSecondInt) + strSeconds
        }else{
            UtilObj.printLogKey(printKey: "", printingValue: HomeWorkSecondStr)
            ApiHomeWorkSecondInt = HomeWorkSecondStr/60
            TimeTitleLabel.text = strSeconRecord + String(ApiHomeWorkSecondInt) + strminutes
        }
        self.actionNewVoiceRecording()
        
        self.TitleForStartRecord()
        let idGroupHead = appDelegate.idGroupHead as NSString
        let isPrincipal = appDelegate.isPrincipal as NSString
        if(isPrincipal .isEqual(to: "true")){
            CallerTyepString = "M"
            strSchoolID = String(describing: SchoolDict["SchoolID"]!)
            strStaffID =  String(describing: SchoolDict["StaffID"]!)
        }
        else if(idGroupHead .isEqual(to: "true")){
            CallerTyepString = "A"
        }
        
        AudioSlider.value = 0.0
        sendButton.isUserInteractionEnabled = false
        audioRecorder = nil
        recordingSession = AVAudioSession.sharedInstance()
        do {
            if #available(iOS 11.0, *) {
                try recordingSession.setCategory(.playAndRecord, mode: .default, policy: .default, options: .defaultToSpeaker)
            } else {
                try recordingSession.setCategory(AVAudioSession.Category.playAndRecord)
            }
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        
                    } else {
                        
                    }
                }
            }
        } catch {
            
        }
        
        settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey:2,
            AVLinearPCMBitDepthKey:16,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        self.Config()
        
    }
    
    
    @IBAction func addFileAct () {
        var documentPicker: UIDocumentPickerViewController
        if #available(iOS 14.0, *) {
            let supportedTypes: [UTType] = [UTType.audio]
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        } else {
            documentPicker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: UIDocumentPickerMode.import)
        }
        documentPicker.delegate = self
        
        if let popoverController = documentPicker.popoverPresentationController {
            popoverController.sourceView = self.voiceView //set your view name here
        }
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        
        print("urlsurls11",urls)
        guard let url = urls.first else { return }
        let _ = url.startAccessingSecurityScopedResource()
        let asset = AVURLAsset(url: url)
        guard asset.isComposable else {
            print("Your music is Not Composible")
            return
        }
        urlData = url
        addAudio(audioUrl: url)
    }
    
    func addAudio(audioUrl: URL) {
        
        
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
        var str = destinationUrl.lastPathComponent
        destinationUrl.deleteLastPathComponent()
        destinationUrl.appendPathComponent("sample.mp4")
        pathImg.isHidden = false
        pathLbl.text = destinationUrl.path
        pathLbl.isHidden = false
        
        self.ValidateField()
        playerDidFinishPlaying()
        playVoiceMessageView.isHidden = false
        calucalteDuration()
        if(UIDevice.current.userInterfaceIdiom == .pad){
            count = appDelegate.LoginSchoolDetailArray.count
            self.durationLabel.text = TotaldurationFormat
            self.currentPlayTimeLabel.text = "00.00"
        }else{
            count = appDelegate.LoginSchoolDetailArray.count
            self.durationLabel.text = TotaldurationFormat
            self.currentPlayTimeLabel.text = "00.00"
        }
        
        
    }
    
    
    
    @IBAction func selectSchoolAction(_ sender: UIButton) {
        let schoolVC  = self.storyboard?.instantiateViewController(withIdentifier: "SchoolSelectionVC") as! SchoolSelectionVC
        
        schoolVC.typeList = "1"
        schoolVC.urlData = urlData
        schoolVC.selectedSchoolDictionary = selectedSchoolDictionary
        schoolVC.fromView = fromView
        schoolVC.duration = durationString
        schoolVC.desc =  descriptionTextField.text
        schoolVC.voiceHistoryArray = SelectedVoiceHistoryArray
        schoolVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(schoolVC, animated: true, completion: nil)
    }
    
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: Date())!
    }
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        
        if !dateArr.contains(result) {
            dateArr.append(result)
            DefaultsKeys.dateArr.append(result)
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("DefaultsKeysdateArr",DefaultsKeys.dateArr)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        if let index = dateArr.firstIndex(of: result) {
            
            dateArr.remove(at: index)
            DefaultsKeys.dateArr.remove(at: index)
        }
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let today = Date()
        let thirtyDaysFromToday = Calendar.current.date(byAdding: .day, value: 7, to: today)!
        
        if (date.isSameDay(as: today) || (date >= today && date <= thirtyDaysFromToday)) {
            return true
        } else {
            return false
        }
    }
    
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let today = Date()
        let thirtyDaysFromToday = Calendar.current.date(byAdding: .day, value: 7, to: today)!
        
        if date < today || date > thirtyDaysFromToday {
            return .gray
        } else {
            return nil
        }
    }
    
    
    @IBAction func selectDateAct() {
        calendarView.isHidden  = false
        doneView.isHidden  = false
        fsCaleView.isHidden  = false
    }
    
    @IBAction func calendarAction() {
        fsCaleView.isHidden = false
        calendarView.isHidden = false
        doneView.isHidden = false
    }
    
    
    @IBAction func initiateCallAction(ges : dateGesture) {
        
        timeId = "1"
        timeSS()
        
    }
    
    func timeSS() {
        print("timeId1", timeId)
        
        RPickerTwo.selectDate(title: "Select time", cancelText: "Cancel", datePickerMode: .time, style: .Wheel, didSelectDate: { [weak self] (today_date) in
            guard let self = self else { return }
            
            self.display_date = today_date.dateString("HH:mm")
            self.url_time = today_date.dateString("a:mm:hh")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            if self.timeId == "1" {
                // Initial Call Time Selection
                self.initiateCallLbl.text = self.display_date
                DefaultsKeys.initialDisplayDate = self.display_date
                self.ValidateField()
                
            } else if self.timeId == "2" {
                // Do Not Call Time Selection (Should be at least 5 mins greater than start time)
                guard let startTimeString = self.initiateCallLbl.text, startTimeString != "Time",
                      let startTime = dateFormatter.date(from: startTimeString),
                      let selectedTime = dateFormatter.date(from: self.display_date) else {
                    Util.showAlert(commonStringNames.Alert.translated(), msg: "Please select the initial call time first.")
                    return
                }
                
                let minEndTime = startTime.addingTimeInterval(5 * 60) // 5 minutes in seconds
                
                if selectedTime < minEndTime {
                    Util.showAlert(commonStringNames.Alert.translated(), msg: "End time must be at least 5 minutes after the initial call time.")
                    self.doNotCallLbl.text = "Time"
                    self.ValidateField()
                } else {
                    self.doNotCallLbl.text = self.display_date
                    DefaultsKeys.doNotDialDisplayDate = self.display_date
                    self.ValidateField()
                }
            }
        })
    }

    @IBAction func closeAction() {
        
        sheduleCallListView.isHidden = true
        initiateCallView.isHidden = true
        doNotCallView.isHidden = true
        selectDateView.isHidden = true
    }
    
    
    @IBAction func deleteAction(ges: deleteGesture) {
        dateArr.remove(at: ges.id )
        DefaultsKeys.dateArr.remove(at: ges.id)
        
        var dateFormat = "dd-MM-yyyy"
        let dateString = ges.datestring
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let dates = dateFormatter.date(from: dateString!) {
            print("Converted Date:", dates)
            self.fsCaleView.deselect(dates)
        }
        
        fsCaleView.isHidden  = true
        if DefaultsKeys.dateArr.isEmpty {
            
            disableButton()
        } else {
            self.ValidateField()
        }
        
        if dateArr.count >= 6{
            collectionViewHeight.constant = 200
        }else{
            collectionViewHeight.constant = CGFloat(30*dateArr.count)
        }
        cv.isHidden  = false
        cv.delegate = self
        cv.dataSource = self
        cv.reloadData()
    }
    @IBAction func doneActionVc(_ sender: Any) {
        ValidateField()
        if dateArr.count == 0{
            calendarView.isHidden  = true
            cv.isHidden  = true
            cvconstant.constant = 0
        }
        else{
            calendarView.isHidden  = true
            cv.isHidden  = false
            if dateArr.count >= 6{
                cvconstant.constant = 200
            }else{
                cvconstant.constant = CGFloat(30*dateArr.count)
            }
            cv.delegate = self
            cv.dataSource = self
            cv.reloadData()
        }
    }
}

class dateGesture : UITapGestureRecognizer {
    var id : String!
    var datestring : String!
}


extension Date {
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
}
