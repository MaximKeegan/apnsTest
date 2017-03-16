//
//  NotificationService.swift
//  serviceExtention
//
//  Created by Maksim Kigan on 23/02/17.
//  Copyright © 2017 Maxim Keegan. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var mutableNotificationContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        mutableNotificationContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let notificationContent = mutableNotificationContent {
            notificationContent.body = "\(notificationContent.body) [modified]"
            
            if let image = request.content.userInfo["image"] as? String {
                let url = URL(string: image)!
                self.store(url: url, extension: "jpg", completion: { (path, error) in
                    if let path = path {
                        let attachment = try! UNNotificationAttachment(identifier: "image", url: path, options: nil)
                        notificationContent.attachments = [attachment]
                        contentHandler(notificationContent)
                    } else {
                        contentHandler(notificationContent)
                    }
                })
            } else {
                contentHandler(self.mutableNotificationContent!)
            }
        
            
            
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  mutableNotificationContent {
            contentHandler(bestAttemptContent)
        }
    }

    func store(url: URL, extension: String, completion: ((URL?, NSError?) -> ())?) {
        // obtain path to temporary file
        let filename = ProcessInfo.processInfo.globallyUniqueString
        let path = try! URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(filename).\(`extension`)")
        
        // fetch attachment
        let session  = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            let _ = try! data?.write(to: path)
            completion?(path, error as NSError?)
        }
        task.resume()
    }

}
