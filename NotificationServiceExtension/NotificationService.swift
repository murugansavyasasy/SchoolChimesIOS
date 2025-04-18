//
//  NotificationService.swift
//  NotificationService
//
//  Created by admin on 26/03/24.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?

        var bestAttemptContent: UNMutableNotificationContent?



        override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {

               self.contentHandler = contentHandler

               bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

               if let bestAttemptContent = bestAttemptContent {

                   guard let body = bestAttemptContent.userInfo["fcm_options"] as? Dictionary<String, Any>, let imageUrl = body["image"] as? String else { fatalError("Image Link not found") }

                   downloadImageFrom(url: "https://schoolchimes-files-india.s3.ap-south-1.amazonaws.com/communication/IOS+App/call.png") { (attachment) in

                       if let attachment = attachment {

                           bestAttemptContent.attachments = [attachment]

       //                  bestAttemptContent.categoryIdentifier = "myNotificationCategory"    //COMMENT IT FOR NOW

                           contentHandler(bestAttemptContent)

                       }

                   }

               }

           }

       //MARK: - Image Downloader

           private func downloadImageFrom(url: String, handler: @escaping (UNNotificationAttachment?) -> Void) {

               let task = URLSession.shared.downloadTask(with: URL(string: url)!) { (downloadedUrl, response, error) in

                   guard let downloadedUrl = downloadedUrl else { handler(nil) ; return }

                   var urlPath = URL(fileURLWithPath: NSTemporaryDirectory())

                   let uniqueUrlEnding = ProcessInfo.processInfo.globallyUniqueString + ".jpg"

                   urlPath = urlPath.appendingPathComponent(uniqueUrlEnding)

                   try? FileManager.default.moveItem(at: downloadedUrl, to: urlPath)

                   do {

                       let attachment = try UNNotificationAttachment(identifier: "picture", url: urlPath, options: nil)

                       handler(attachment)

                   } catch {

                       print("attachment error")

                       handler(nil)

                   }

               }

               task.resume()

           }

           override func serviceExtensionTimeWillExpire() {

               // Called just before the extension will be terminated by the system.

               // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.

               if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {

                   contentHandler(bestAttemptContent)

               }

           }



       }

