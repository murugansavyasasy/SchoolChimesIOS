//
//  Constants.h
//
//  Game805Stats
//
//  Created by Shenll-Mac2 on 13/06/16.
//  Copyright © 2016 Shenll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark - Debug Mode
/*
 ***  Decide to print log. ***
 ***  0 - Debug Mode ***
 ***  1 - Live mode ***
 */
//Debug mode ("0" Enabled)  ("1" Disabled)
#define IS_DEBUG_MODE @"0"
//#define IS_DEBUG_MODE @"0"

#pragma mark - APP Nameß

#define APP_NAME @"Vociesnap School App"
/*
 *  Webservice URL variables
 */
#define ISERROR @"0" 


#pragma mark - API Domain URL

/*
 *** Select domain mode as live/demo ***
 */
/***********************/
//Parent app V5
/**********************/


#define ENTER_VALID_EMAILID @"Please enter valid Email ID"
#define SELECT_SCHOOL_ALERT @"Please choose school"
#define ENTER_CONTACTPERSON_ALERT @"Please enter contact person"
#define ENTER_CONTACTMOBILE_ALERT @"Please enter contact mobile number"
#define ENTER_CONTACTEMAILID_ALERT @"Please enter contact Email ID"
#define INSERT_FEEDBACK_DETAIL @"InsertFeedbackDetails"
#define AT_VERY_FIRST_TIME @"AtveryFirstTime"
#define ACCEPT_TERMS_CONDITION @"acceptTermsCondition"
#define PASSWORD_RESET_STATUS @"GetPasswordResetStatus"

#define CHECK_MOBILENO_UPDATE @"CheckMobileNumberforUpdatePassword"
#define CHECK_MOBILENO_UPDATE_BY_COUNTRYID @"ValidateUser"

#define VALIDATE_OTP_METHOD @"ValidateOTP"
#define UPDATE_NEWPASSWORD_MEHTOD @"UpdateNewPasswordforNewUser"
#define GET_MESSAGE_COUNT @"GetMessageCount"
#define MAKE_CONFERENCE_CALL @"InitiatePrincipalCall"
#define NO_EXAM_FOUND @"No Exam Found"
#define NO_MARK_FOUNT @"No Marks Found"
#define NO_PAID_FOUNT @"No Paid Records Found"
#define NO_PENDING_FOUNT @"No Pending Records Found"
#define GET_PAID_FEE_METHOD @"GetStudentInvoice_App"
#define GET_PAIDFEE_INVOICE_METHOD @"GetInvoiceById"
#define GET_PENDING_FEE_METHOD @"GetStudentPendingFee"
#define GET_EXAM_DETAIL_METHOD @"GetStudentExamMarks"
#define GET_EXAM_LIST_METHOD @"GetStudentExamList"
#define PARENT_LOGIN_METHOD @"ManageParentLogin"
#define PARENT_LIBRARY_METHOD @"GetMemberBookList"
#define OPTION_LIBRARY_METHOD @"BOOKDETAILS"
#define SERVER_RESPONSE_FAILED @"Something went wrong!"
#define GET_ABSENTENCE_DATE @"GetAbsentDatesForChild"
#define EXAM_TEST_MESSAGE @"GetExamsOrTests"
#define READ_STATUS_UPDATE @"ReadStatusUpdate"
#define GET_FILES @"GetFiles"
#define GET_ABSENTENCE_DATE @"GetAbsentDatesForChild"
#define GET_EMERGENCY_FILES @"GetEmergencyVoiceOrImageOrPDF"
#define GETFILES @"getfiles"
#define GET_MSG_CONT @"getmessagecount"
#define HOMEWORK_MESSAGE_COUNT @"GetHomeWorkCount"
#define UNREAD_MSG_COUNT @"GetOverallUnreadCount"
#define DATE_WISE_MESSAGE @"GetDateWiseUnreadCount"
#define UNREAD_MSG_CONT @"unreadmessagecount"
#define SCHOOL_EVENT_MESSAGE @"GetSchoolEvents"
#define GET_HELP @"GetHelp"
#define CHANGEPASSWROD @"ChangePassword"
#define NOTICE_BOARD_MESSAGE @"GetNoticeBoard"
#define GET_HELP @"GetHelp"
#define GET_HOMEWORK_FILES @"GetHomeWorkFiles"
#define APPLY_LEAVE_REQUEST @"InsertLeaveInformation"
#define GET_FILES_STAFF @"GetFilesStaff"
#define GET_STAFF_DETAIL @"getStaffDetails"
#define GET_STAFF_DETAIL_CHAT_SCREEN @"getStaffDetailsForChat"
#define GET_LEAVE_REQUEST @"GetLeaveRequests"
#define UPDATE_LEAVE_REQUEST @"Updateleavestatus"
#define GET_FAQ @"getFAQLink?MemberID="
#define GET_USERTYPE @"&Usertype="
#define POST_LANGUAGE_CHANGE @"GetMenuDetails" // GetMenuDetails //ChangeLanguage
#define POST_STUDENT_ASSIGNMENT_LIST @"GetAssignmentForStudent"
#define POST_VIEW_STUDENT_ASSIGNMENT @"ViewAssignmentContent"
#define POST_SUBMIT_STUDENT_ASSIGNMENT @"SubmitAssignmentFromApp"
#define POST_STAFF_ASSIGNMENT_LIST @"ViewAllAssignmentListByStaff"
#define POST_DELETE_ASSIGNMENT @"DeleteAssignmentFromApp"
#define POST_TOTAL_ASSIGNMENT @"GetAssignmentMemberCount"
#define GET_VIDEO_FILES @"GetVideosForStudent"
#define POST_SUBMIT_STUDENT_ASSIGNMENT_NEW @"SubmitAssignmentFromAppWithCloudURL"
#define GET_NEW_PAID_FEE_METHOD @"institute-fee-rate/student-fee-details-app?ChildID="
#define POST_PAYMENT_FEE @"institute-fee-rate/student-fee-payment-app"
#define VIDEOSIZELIMIT @"VideoSizeLimit"
#define VIDEOSIZELIMITALERT @"VideoSizeLimitAlert"
#define VIDEOJSON @"VideoJson"
#define ADTIMERINTERVAL @"adTimerInterval"
#define POST_UPLOAD_DOC_PHOTO @"studentform/uploads-student-document"

#define GET_MEETINGS_LIST @"GetUpcomingOnlineClassRooms"
#define GET_MEETINGS_TYPES_LIST @"GetOnlineMeetingPlatformTypes"
#define POST_CANCEL_MEETING @"CancelOnlineClassRoom"

#define GET_MEETINGS_STAFF @"GetOnlineClassRoomsByStaffID"

#define POST_MEETING_STAFF @"SendOnlineClassAsStaffToEntireSection"

#define POST_MEETING_GROUP_STANDARDS @"SendOnlineClassToGroupsAndStandards"

#define GET_VIEW_EXAMS @"GetStudentExamMark"
#define GET_PROGRESS_CARD @"GetProgressCardLink"
#define POST_LATE_FEES @"calculate-late-fee-details"


#define GET_EMERGENCY_FILES_SEEMORE @"GetEmergencyVoiceOrImageOrPDF_Archive"
#define DATE_WISE_MESSAGE_SEEMORE  @"GetDateWiseUnreadCount_Archive"
#define POST_STUDENT_ASSIGNMENT_LIST_SEEMORE @"GetAssignmentForStudent_Archive"
#define GET_ABSENTENCE_DATE_SEEMORE @"GetAbsentDatesForChild_Archive"
#define HOMEWORK_MESSAGE_COUNT_SEEMORE @"GetHomeWorkCount_Archive"
#define NOTICE_BOARD_MESSAGE_SEEMORE @"GetNoticeBoard_Archive"
#define SCHOOL_EVENT_MESSAGE_SEEMORE @"GetSchoolEvents_Archive"
#define VIEW_HOLIDAYS_METHOD_SEEMORE @"ViewHolidays_Archive"
#define GET_VIDEO_FILES_SEEMORE @"GetVideosForStudent_Archive"

#define READ_STATUS_UPDATE_SEEMORE @"ReadStatusUpdate_Archive"
#define GET_FILES_SEEMORE @"GetFiles_Archive"
#define GET_HOMEWORK_FILES_SEEMORE @"GetHomeWorkFiles_Archive"
#define POST_VIEW_STUDENT_ASSIGNMENT_SEEMORE @"ViewAssignmentContent_Archive"
#define POST_SUBMIT_STUDENT_ASSIGNMENT_NEW_SEEMORE @"SubmitAssignmentFromAppWithCloudURL_Archive"
#define POST_STAFF_ASSIGNMENT_LIST_SEEMORE @"ViewAllAssignmentListByStaff_Archive"
#define GET_MESSAGE_COUNT_SEEMORE @"GetMessageCount_Archive"
#define GET_FILES_STAFF_ARCHIVE @"GetFilesStaff_Archive"
#define POST_DELETE_ASSIGNMENT_SEEMORE @"DeleteAssignmentFromApp_Archive"
#define POST_TOTAL_ASSIGNMENT_SEEMORE @"GetAssignmentMemberCount_Archive"

#define NEWHWARCHIEVE @"GetHomeWork_archive"


/**************************************************************************************************************************************************/


/*
#define TERMS_AND_CONDITION @"http://vs3.voicesnapforschools.com/School/TermsConditions"

#define LIVE_DOMAIN @"https://vs3.voicesnapforschools.com/api/MergedApi/"
#define LIVE_COUNTRY_LIST @"https://vs3.voicesnapforschools.com/api/MergedApi/GetCountryListV4"
#define ACCEPT_TERMS_AND_CONDITION @"https://vs3.voicesnapforschools.com/api/MergedApi/AgreeTermsAndConditions"
*/

//#define TERMS_AND_CONDITION @"https://gradit.voicesnap.com/School/SchoolTermsConditions"
//

#define TERMS_AND_CONDITION @"https://schoolchimes.com/vs_web/terms_conditions/"
//#define TERMS_AND_CONDITION@"https://gradit.voicesnap.com/School/SchoolTermsConditions" Old

//(https://api.schoolchimes.com/nodejs/api/MergedApi/` Nov 27 Change this domain name
#define LIVE_DOMAIN @"https://api.schoolchimes.com/nodejs/api/MergedApi/"
#define LIVE_COUNTRY_LIST @"https://api.schoolchimes.com/nodejs/api/MergedApi/GetCountryList"

//#define LIVE_DOMAIN @"https://vstest3.voicesnapforschools.com/nodejs/api/MergedApi/"
//#define LIVE_COUNTRY_LIST @"https://vstest3.voicesnapforschools.com/nodejs/api/MergedApi/GetCountryListV4"

#define ACCEPT_TERMS_AND_CONDITION @"https://api.schoolchimes.com/nodejs/api/MergedApi/AgreeTermsAndConditions"


//#define LIVE_COUNTRY_LIST @"http://202.21.35.54/nodejs/api/MergedApi/GetCountryListV4"

//#define LIVE_DOMAIN @"http://202.21.35.54/nodejs/api/MergedApi/"
//#define LIVE_COUNTRY_LIST @"http://202.21.35.54/nodejs/api/MergedApi/GetCountryListV4"
//#define ACCEPT_TERMS_AND_CONDITION @"http://202.21.35.54/nodejs/api/MergedApi/AgreeTermsAndConditions"

/*****************************************************************************************************************************/
#define FORCE_UPDATE_AVAIL_MESSAGE @"The developer of this app needs to update it to improve its compatibility"
#define UPDATE_AVAIL_MESSAGE @"New updates are available. Would you like to update them now?"
#define UPDATE_TITLE @"Needs to Update"

#define LIVE_ITUNES @"https://itunes.apple.com/us/app/voicesnap-parents/id700513732?ls=1&mt=8"
#define FORGOT_PASSWORD_CLICKED @"forgotPassword"
#define FORGOT_PASSWORD_DICT @"forgotPasswordDict"
#define SEARCH_DOMAIN @"http://106.51.127.215:8092/api/App/"
#define SEARCHCORPMEMBERS @"SearchCorpMembers"
#define TERMS_CONDITION_URL @"http://voicehuddle.com/terms/index/"
#define FAQ_URL @"http://voicehuddle.com/faq/index/"
#define LOGIN_TYPE @"GetChildList"
#define FEEDBACKQUE @"GetFeedbackQuestions"
#define LOGIN_METHOD @"GetUserDetailsWithValidation" // Dhanush Aug-2022
#define VALIDATE_PASSWORD_METHOD @"ValidatePassword"
#define FORGOTPSWD_METHOD @"ForgetPassword"
#define FORGOTPSWD_METHOD_BY_COUNTRYID @"ForgetPasswordByCountryID"
#define CHANGEPSWD_METHOD @"ChangePassword"
#define SCHOOLDETAIL_METHOD @"GetSchoolLists"
#define VIEW_HOLIDAYS_METHOD @"ViewHolidays"
#define SENDSMSTOALL_PRINCIPLE @"SendSmsMgtAdmin"
#define SENDIMAGETOALL_PRINCIPLE @"GetImageMgtAdmin"
#define SENDVOICETOALL_PRINCIPLE @"SendVoiceMgtAdmin"
#define SENDVOICE_STAFF @"StaffwiseVoice"
#define SENDVOICETOPARTICULARCLASS_PRINCIPLE @"SnrMgtStdGrp"
#define PARENT_ARRAY_INDEX @"ParentArrayIndex"
#define STAFF_ARRAY_INDEX @"StaffArrayIndex"
#define PRINCIPLE_ARRAY_INDEX @"PrincipleArrayIndex"
#define ADMIN_ARRAY_INDEX @"AdminArrayIndex"
#define GROUPHEAD_ARRAY_INDEX @"GroupheadArrayIndex"

#define MENU_ARRAY_INDEX @"MenuArrayIndex"
#define IS_PARENT_ID @"isParentID"
#define IS_STAFF_ID @"isStaffID"
#define IS_PRINCIPLE_ID @"isPrincipalID"
#define IS_ADMIN_ID @"isAdminID"
#define IS_GROUPHEAD_ID @"idGroupHeadID"
#define IS_MENU_ID @"menu_id"
#define SENDSMSTOSCHOOL_ADMIN @"adminsendsmstoschools"
#define SELECTSCHOOL @"GetSchoolLists"
#define STANDARD_DETAIL @"GetSchoolClass"
#define SUBJECT_DETAIL @"SubjectHandling"
#define SECTION_DETAIL @"GetSchoolSec"
#define SENDSMS_STAFF @"SendSmsStaffwise"
#define SendSMSToEntireSchools @"SendSMSToEntireSchools"
#define SendVoiceToEntireSchools @"SendVoiceToEntireSchools"
#define ScheduleSendVoiceToEntireSchools @"ScheduleVoiceToEntireSchools"
#define GetSchoolStrengthBySchoolID @"GetSchoolStrengthBySchoolID"
#define SendVoiceToGroupsAndStandards @"SendVoiceToGroupsAndStandards"
#define ScheduleSendVoiceToGroupsAndStandards @"ScheduleVoiceToGroupsAndStandards"
#define SendSMSToGroupsAndStandards @"SendSMSToGroupsAndStandards"
#define ManageNoticeBoard @"ManageNoticeBoard"
#define ManageSchoolEvents @"ManageSchoolEvents"
#define SendImageToGroupsAndStandards @"SendImageToGroupsAndStandards"
#define GetVoiceHistory @"GetVoiceHistory"
#define GetSMSHistory @"GetSMSHistory"
#define SENDIMAGE_SELECTEDSTANDARD_GROUP_PRINCIPAL @"GetImageSnrMgt"
#define SENDIMAGE_STAFF @"GetImageStaff"
#define SELECTEDSTANDARD_GROUP_PRINCIPAL @"SendGroupMessageSnrMgt"
#define SECTIONCODE_ATTENDANCE @"GetSecAtt"
#define SUBJECT_DETAIL_STAFF @"GetClassSubjects"
//#define MARK_ATTENDANCE @"SendAbsenteesSMS"
#define MARK_ATTENDANCE @"SendAbsenteesSMSWithSessionType"
#define HELP_METHOD @"HelpText"
#define APPINSERTREPLY @"InsertQueReply"
#define LISTALLCONFRENCE_TYPE @"ListAllGroupDetails"
#define GETBROADCASTLIST_TYPE @"getBroadcastList"
#define GETCONFRENCELIST_TYPE @"getConferenceList"
#define APPVERSION @"4"
#define CHECK_UPDATE @"VersionCheck"
#define VERSION_VALUE @"79"
//74Oct20
//73
//"72"

//already 69 (aug 20)
//already 70 (aug 22)
//already 68 (aug 19)
//already 67 (july 30)
//already 66 (july 17)
//already 65 (july 8)
//already 63 (jun 17)
//already 59 n(jun 4)
//already 62 n(jun 10)

//already 61 n(jun 7)
//already 60 n(jun 6)
//already version value 54 (Jan2)
//already version value 55 (Jan11)
//alreadyText message crash  version value 56 (Jan24)
//already Kh school GetAds  crash  version value 57 (Jan30)
//already GET MENU DETAILS ,Ad,Img size width  version value 58 irunthathu ippo 59(Apr6)

 
#define IMAGE_COUNT @"ImageCount"
#define UPLOAD_YOUTUBE_VIDEO @"UploadVideostoYoutube"

#define GET_PAYMENT_URL @"GetPaymentGatewayLink"





//VERSION 2 METHODS

#define GET_ALL_STAFFLIST @"GetAllStaffs"
#define GET_FEEDBACK_QUESTION @"GetFeedbackQuestions"
#define GET_DATEVICE_ATTENDANCE_DETAIL @"GetAbsenteesCountByDate"
#define GET_SCHOOL_STRENGTH_DETAIL @"GetSchoolStrengthBySchoolID"
#define GETSTANDARD_SECTION @"GetSchoolStrengthBySchoolID"
#define STUDENT_DETAIL @"GetStudDetailForSection"
#define INTERNET_ERROR @"Please check your internet connection"
#define SEND_TEXT_HOMEWORK @"InsertHomeWork"
#define NEW_STANDARD_GROUP @"GetAllStandardsAndGroups"
#define GET_STANDARD_SECTION_SUBJECT @"GetStandardsAndSubjectsAsStaff"
#define GET_STANDARD_SECTION_SUBJECT_NEWOLD @"GetStandardsAndSubjectsAsStaffWithoutNewOld"
#define SEND_VOICE_HOMEWORK @"InsertHomeWorkVoice"
#define SEND_EXAM_HOMEWORK @"InsertExamToEntireSection"
#define INSERT_EXAM_PARTICULARSTUDENT @"InsertExamToSpecificStudents"

#define SEND_EXAM_HOMEWORK_SYLLABUS @"InsertExamToEntireSection_WithSubjectSyllabus"
#define INSERT_EXAM_PARTICULARSTUDENT_SYLLABUS @"InsertExamToSpecificStudents_WithSubjectSyllabus"

#define STAFF_SEND_TEXT_MESSAGE @"SendSMSAsStaffToEntireSection"
#define SEND_TEXT_TO_STUDENT @"SendSMSAsStaffToSpecificStudents"
#define STAFF_SEND_VOICE_MESSAGE @"SendVoiceAsStaffToEntireSection"
#define SCHEDULE_STAFF_SEND_VOICE_MESSAGE @"ScheduleVoiceAsStaffToEntireSection"

#define STAFF_SEND_VOICE_MESSAGE_TO_GROUPS @"SendVoiceAsStaffToGroups"
#define SCHEDULE_STAFF_SEND_VOICE_MESSAGE_TO_GROUPS @"ScheduleVoiceAsStaffToGroups"
#define STAFF_SEND_VOICE_MESSAGE_TO_STUDENT @"SendVoiceAsStaffToSpecificStudents"
#define SCHEDULE_STAFF_SEND_VOICE_MESSAGE_TO_STUDENT @"ScheduleVoiceAsStaffToSpecificStudents"

#define STAFF_SEND_IMAGE_MESSAGE @"SendImageAsStaffToEntireSection"
#define STAFF_SEND_IMAGE_MESSAGE_TO_STUDENT @"SendImageAsStaffToSpecificStudents"
#define DEVICE_TYPE @"Iphone"
#define RESET_FORGOT_PASSWORD @"ResetPasswordAfterForget"

#define MULTIPLE_IMAGE_MESSAGE_TO_SCHOOL @"SendMultipleImageAsStaffToEntireSection"
#define MULTIPLE_IMAGE_MESSAGE_GROUP_STANDARD @"SendMultipleImageToGroupsAndStandards"
#define MULTIPLE_IMAGE_MESSAGE_STUDENT @"SendMultipleImageAsStaffToSpecificStudents"

#define MULTIPLE_IMAGE_MESSAGE_TO_SECTION_CLOUD @"SendMultipleImagePDFAsStaffToEntireSectionWithCloudURL"
#define MULTIPLE_IMAGE_MESSAGE_GROUP_STANDARD_CLOUD @"SendMultipleImagePDFToGroupsAndStandardsWithCloudURL"
#define MULTIPLE_IMAGE_MESSAGE_STUDENT_CLOUD @"SendMultipleImagePDFAsStaffToSpecificStudentsWithCloudURL"
#define MULTIPLE_IMAGE_MESSAGE_TO_SCHOOL_CLOUD @"SendMultipleImagePDFToEntireSchoolsWithCloudURL"

#define GET_COMMON_SUBJECT_FOR_SECTIONS @"GetCommonSubjectsForSections"


#define FORWARD_ASSIGNMENT @"ForwardAssignment"
#define SEND_ASSIGNMENT @"ManageAssignmentFromApp"
#define SEND_ASSIGNMENT_NEW @"ManageAssignmentFromAppWithCloudURL"
#define SEND_VIMEO_VIDEO_ENTIRE_SCHOOL @"SendVideoFromAppForEnitireSchool"
#define SEND_VIMEO_VIDEO_GROUP_STANDARD @"AppSendVideoToGroupsAndStandards"
#define SEND_VIMEO_VIDEO_ENTIRE_SECTION @"SendVideoAsStaffToEntireSection"
#define SEND_VIMEO_VIDEO_STUDENT @"SendVideoAsStaffToSpecificStudents"

// New history Apis

#define STAFF_ENTIRE_SECTION_VOICE_HISTORY @"SendVoiceAsStaffToEntireSectionfromVoiceHistory"
#define SCHEDULE_STAFF_ENTIRE_SECTION_VOICE_HISTORY @"ScheduleVoiceAsStaffToEntireSectionfromVoiceHistory"

#define VOICE_HISTORY_SPECIFIC_STUDENT @"SendVoicetoSpecificStudentsfromVoiceHistory"
#define SCHEDULE_VOICE_HISTORY_SPECIFIC_STUDENT @"ScheduleVoicetoSpecificStudentsfromVoiceHistory"

#define VOICE_HISTORY_ENTIRE_SCHOOL @"SendVoiceToEntireSchoolsByVoiceHistory"
#define SCHEDULE_VOICE_HISTORY_ENTIRE_SCHOOL @"ScheduleVoiceToEntireSchoolsByVoiceHistory"

#define VOICE_HISTORY_GROUP_STANDARD @"SendVoicetoGroupsStandardsfromVoiceHistory"
#define SCHEDULE_VOICE_HISTORY_GROUP_STANDARD @"ScheduleVoicetoGroupsStandardsfromVoiceHistory"
#define VIDEO_AGREEMENT_POST @"GetVideoContentRestriction"
#define GET_STAFF_CLASSES_CHAT @"GetStaffClassesforChat"
#define GET_STUDENT_CHAT_MESSAGE @"GetStudentChatScreen"
#define POST_STUDENT_QUESTION @"StudentAskQuestion"
#define GET_STAFF_CHAT_MESSAGE @"GetStaffChatScreen"
#define POST_STAFF_ANSWER @"AnswerStudentQuestion"
//warning Errors
#define CHOOSE_COUNTRY_ALERT @"Please choose your country"
#define GETVOICERESPONSE_TYPE @"getvoiceresponse"
#define BOOK_INSTANT_CONFERENCE @"BookInstantConference"
#define ADD_NEW_MEMBER_IN_LIVE_MONITOR @"AddNewMemberInLiveConference"
#define GETCONFRENCEREPORT_TYPE @"getConfReportsByConference"
#define LOADICICIGRP_TYPE @"corpgroup"
#define BOOK_VOICE_BLAST @"BookVoiceBlast"
#define BOOK_SCHEDULE_CONFERENCE @"BookScheduleConference"
#define MYGROUP_TYPE @"Mygroup"
#define MYGMEMBERS_TYPE @"MyMembers"
#define OPERATION @"operation"
#define ROOMNO @"RoomNo"
#define OPTION @"option"
#define MEMBERS @"members"
#define MOBILE_NO @"mobileno"
#define ALT_MOBILE @"Please enter mobile number"
#define ALT_VALID_MOBILE @"Please enter valid mobile number"
#define NEW_PASSWORD @"Please enter new password"
#define CONFIRM_PASSWORD @"Please enter confirm password"
#define ALT_LASTNAME @"Please enter last name"
#define ALT_ADDRESS @"Please enter address"
#define PASSWORD_MISMATCH @"New passwords mismatching"
#define ALT_PASSWORD_RESET_TITLE @"Password reset"
#define ALT_PASSWORD_RESET @"Password reset started. Please check your inbox for futher instructions."
#define ALT_GRPNAME @"Please enter group name"
#define ENTER_NAME @"Enter name"
#define VOICE_BLAST_SUCCESS_MSG @"VoiceBlast Success"
#define INSTANTCONFERENCEGROUP @"InstantgroupConference"
#define SCHEDULECONFERENCEGROUP @"ScheduleCoferencegroups"
#define CREATEGROUP @"CreateGroup"
#define GROUPMEMBERSLIST @"insertGroupMemberslist"
#define DELETEGROUP @"deletemygroup"
#define GETMYGROUPMEMBERS @"getmygroupmembers"
#define GETCORPGROUPMEMBERS @"getcorpgroupmembers"
#define GETGROUPBROADCAST @"groupbroadcast"
#define POSTRECORD @"Record"
#define POSTVALIDATERECORD @"validaterecord"
#define POSTRE_RECORD @"reRecord"
#define VIEWCONFERENCE @"ViewConference"
#define OPERATECONFERENCE @"OperateConference"
#define REPLYSMSALL @"ReplySMSToAll"
#define REPLYSMSMEMBER @"ReplySMSBymember"
#define ADD_NEW_MEMBER_INLIVE_CONFERENCE @"AddNewMemberInLiveConference"
#define CONNECTCONFERENCEMEMBERS @"ConnectmemberConference"
#define LIVECONFERENCE @"getliveconferencebymoderatorwithoptions"
#define CONTACTID @"ContactID"
#define PASSWORD @"Password"
#define MODERTORID @"ModeratorId"
#define DISPLAYNAME @"displayname"
#define EMAIL @"email"
#define MOBILE @"mobile"
#define STATUS @"status"
#define OWNERID @"ownerid"
#define USERID @"userid"
#define OPERATION @"operation"
#define ROOMNO @"RoomNo"
#define OPTION @"option"
#define COUNTRY @"Country"
#define MUTE @"Mute"
#define HASHKEY @"hashkey"
#define GROUPNAME @"groupname"
#define GROUPCODE @"groupcode"
#define BROADCASTMODERTORID @"moderatorId"
#define CONFID @"ConfId"
#define CONFID_SMALL @"confid"
#define VERSION14 @"version16"
#define FIRSTTIME @"firsttime"
#define BASEURL @"baseurl"
#define PARENTBASEURL @"Parentbaseurl"
#define NEWLINKREPORTBASEURL @"ReportsLink"
#define RESEND_OTP @"CheckMobileNumberforUpdatePasswordByCountryID"
#define STAFFID @"staffid"
#define SCHOOLID @"schoolid"
#define CHILDIDS @"ChildID"
#define COUNTRYFIRST @"countryfirsttime"
#define FIRSTTIMELOGINAS @"firsttimeloginas"
#define DATASELECTED @"dataselected"
#define LOGOUT @"logout"
#define MOBILE_LENGTH @"mobilelength"
#define USERNAME @"username"
#define LOGINASNAME @"loginasname"
#define IMAGEARRAY @"imagearray"
#define AUDIOARRAY @"audioarray"
#define PDFARRAY @"pdfarray"
#define TEXTARRAY @"textarray"
#define USERPASSWORD @"userpassword"
#define CANCELCONFERENCE @"cancelconference"
#define UPDATECONFERENCE @"updateconference"
#define UPDATE_PASSWORD @"updatepassword"
#define COMBINATION @"Combination"
#define SELECT_FEEDBACK @"Please select the feedback"
#define SAVE_ERROR @"Save Error"
#define SAVE_SUCCESS @"Your image has been download to your photos"
#define SERVER_ERROR @"Something went wrong!"
#define SERVER_CONNECTION_FAILED @"Something went wrong!"
#define MOBILE_NOT_EXIST @"Mobile number does not exists"
#define UPDATEGROUP @"updategroup"
#define GROUPCODE @"groupcode"
#define LANGUAGE_ARRAY @"language"
#define LANGUAGES @"Languages"
#define SELECTED_LANGUAGE @"Selected Language"
#define SCRIPTCODE @"ScriptCode"
#define COUNTRY_CODE @"CountryID"
#define COUNTRY_ID @"CountryID"
#define COUNTRY_Name @"CountryName"
#define OLD_BASE_URL @"OldBaseURl"
#define LANGUAGE_NOTIFICATION @"Language Notification"
#define SCHOOLIID @"SchoolID"

#define SELECT_COUNTRY @"US" // Dhanush_Aug 2002

#pragma mark - Static API.PHP

#pragma mark - Url Tags

#pragma mark - Alerts

#define ALERT @""
#define ALERT_TITLE @"Error!"
#define ENTER_EMAIL_ALERT @"Please enter email"
#define WRONG_EMAIL_ALERT @"Wrong email format"
#define ENTER_MOBILENUMBER_ALERT @"Please enter mobile number"
#define NO_DATA_FOUND @"Currently no records found"
#define OK @"Ok"
#define CANCEL @"Cancel"
#define DELETE @"Delete"
#define MOBILE_NUMBER @"MobileNumber"


#pragma Alerts

#define ALT_MOBILE @"Please enter mobile number"
#define ALT_VALID_MOBILE @"Please enter valid mobile number"
#define ALT_LASTNAME @"Please enter last name"
#define ALT_ADDRESS @"Please enter address"
#define PASSWORD_MISMATCH @"New passwords mismatching"
#define ENTER_VALID_PASSWORD @"Please enter valid password"
#define ENTER_PASSWORD_ALERT @"Please enter password"
#define REGISTERED_MOBILE_ALERT @"Enter registered mobile number"
#define VOICE_RECORD_MESSAGE @"You can record general voice message upto "
#define NO_RECORD_MESSAGE @"No Record Found"
#define NO_DATA_MESSAGE @"No data Found"
#define NO_SUBJECT_FOUND @"No subject found"
#define NO_STANDARD_FOUND @"No standard found"
#define NO_SECTION_FOUND @"No section found"
#define SELECT_SUBJECT_ALERT @"please select subject"
#define SELECT_STANDARD_ALERT @"please select standard"
#define SELECT_SECTION_ALERT @"please select section"
#define CHOOSE_ALL_FIELDS @"Choose All The Fields"
#define STANDARD_FIRST @"Please choose standard first"
#define NO_STUDENT_FOUND @"No student found in this school"
#define EXAM_TITLE_ALERT @"Please enter exam title"
#define STANDARD_SECTION_SELECTION_ALERT @"Select Standard and Section Field"
#define ENTER_OTP @"Please enter OTP"
#define NO_CALL_FACILITY @"Call facility is not available!!!"

//"Select Standard and Section Field"
#define ALT_PASSWORD_RESET_TITLE @"Password reset"
#define ALT_PASSWORD_RESET @"Password reset started. Please check your inbox for futher instructions."

#define ALT_GRPNAME @"Please enter group name"
#define ENTER_NAME @"Enter name"
#define PAYMENT_FAILED_ALERT @"Sorry! Your Payment could not be processed.If money debited from your bank,it will credited back"

#pragma mark - Device Orientations
/*
 *  Device Common Variables
 */
#define dDeviceOrientation [[UIDevice currentDevice] orientation]
#define isPortrait  UIDeviceOrientationIsPortrait(dDeviceOrientation)
#define isLandscape UIDeviceOrientationIsLandscape(dDeviceOrientation)
#define isFaceUp    dDeviceOrientation == UIDeviceOrientationFaceUp   ? YES : NO
#define isFaceDown  dDeviceOrientation == UIDeviceOrientationFaceDown ? YES : NO
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
#define IS_IPHONE (!IS_IPAD)

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

/*
 *  Storyboard Constants
 */


#define MAIN_STORYBOARD_NAME @"Main"

#define SEG @"Segue"

/*
 * Resource Constants
 */

#define NETWORK_ERROR @"Please connect your internet!"


/*
 * Color Constants
 */

#define kGreenColor colorWithRed:(0/255.0) green:(213/255.0) blue:(90/255.0) alpha:1.0

#define SCHOOL_NAV_BAR_COLOR [UIColor colorWithRed:88.0/255.0 green:21.0/255.0 blue:69.0/255.0 alpha:1.0]

#define PARENT_NAV_BAR_COLOR [UIColor colorWithRed:0/255.0 green:96/255.0 blue:100/255.0 alpha:1.0]

#define TABLE_HEADING_COLOR [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1.0]

#define TEXT_RED_COLOR [UIColor colorWithRed:183./255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]

#define TEXT_WHITE_COLOR [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]

#define NAV_BAR_COLOR [UIColor colorWithRed:88./255.0 green:115.0/255.0 blue:145.0/255.0 alpha:1.0]

#define GREEN_COLOR [UIColor colorWithRed:0/255.0 green:128/255.0 blue:0/255.0 alpha:1.0]

//red:183.0/255.0, green: 55.0/255.0, blue: 55.0/255.0, alpha: 1
/*
 *  Toast animation variables
 */

#define TRANSITIONDURATION 0.4
#define TOASTTIMING  1
#define LOADINGDELAY 0.4

/*
 *  Common variables
 */
#define BUNDLE_ID @"com.workout."
#define NUMBER_ZERO @"0"
#define NUMBER_ONE @"1"


/*
 *  View Controller Name variables
 */

#define VIWECONTROLLER @"ViewController"


/*
 *  Class Name variables
 */

#define APIDEVICETYPE @"/ios/"
#define APIVERSION @"/1.0"
#define APP_LIVE_VERSION 1.0
#define LIVE_VERSION @"/1.0"
#define DEVICETOKEN @"deviceToken"
#define LIVE_POST_VERSION @"1.0"
#define DB_VERSION @"version"
#define DB_UPGRADE_URL @"upgradeURL"
#define APP_CONFIG @"app"
#define APP_EXECUTION_TYPE @"executionType"
#define APP_EXECUTION_FOR_DEVICE_IDS @"executionDeviceIDs"
#define APP_NEW_VERSION @"latestVersion"
#define APP_ENABLE_BUG_REPORT @"enableBugReport"
#define DB_CONFIG @"database"
#define DB_EXECUTION_TYPE @"executionType"
#define DB_EXECUTION_FOR_DEVICE_IDS @"executionDeviceIDs"
#define DB_NEW_VERSION @"latestVersion"
#define DB_VERSIONS @"versions"
#define DB_VERSION_NUMBER @"versionNumber"
#define DB_QUERIES @"queries"

/*
 *  Alert Message  variables
 */
#define NO_INTERNET @"Please connect your internet!"
#define NO_INTERNET_FIRST @"Please make sure you have a valid connection and try again!"

/*
 *  User Default  variables
 */
#define FIRST_TIME_LAUNCH_AFTER_UNINSTALL @"FIRST_INSTALL_AFTER_UNINSTALL"
#define DEVICE_UDID_KEY @"UDID"
#define AUTH_KEY @"AUTHKEY"
#define AUTH_SECRET_KEY @"AUTHSECRET"

/*
 *  DB & Table related constants
 */
#pragma DB & Table related constants

#define DB_NAME @"school"
#define FULL_DB_NAME @"school.sqlite"
#define DB_FOLDER @"DatabaseFolder"

#pragma Alerts

#define ALT_FIRSTNAME @"Please enter first name"
#define ALT_LASTNAME @"Please enter last name"
#define ALT_ADDRESS @"Please enter address"
#define PASSWORD_MISMATCH @"New passwords mismatching"
#define ALT_PASSWORD_RESET_TITLE @"Password reset"
#define ALT_PASSWORD_RESET @"Password reset started. Please check your inbox for futher instructions."
#define ALT_GRPNAME @"Please enter group name"
#define ENTER_NAME @"Enter name"
#define FILL_ALL_FIELDS_ALERT @"Fill all the fields"
#define ATLEAST_ONE_MSG_ALERT @"Please select atleast one message"

#define SEE_MORE_TITLE "See More >>"

@interface Constants : NSObject{
 
 
    
}
+(void)printLogKey:(NSString *)printKey printValue:(id)printingValue;
@end
