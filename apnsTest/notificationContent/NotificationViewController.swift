//
//  NotificationViewController.swift
//  notificationContent
//
//  Created by Maksim Kigan on 23/02/17.
//  Copyright © 2017 Maxim Keegan. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var items : NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        
        let pushResponse = notification.request.content.userInfo as NSDictionary

        self.items = pushResponse.object(forKey: "tableItems") as! NSArray
        tableView.reloadData()
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        print("did receive")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        cell.textLabel?.text = self.items.object(at: indexPath.row) as? String;
        
        return cell
    }
    
}
