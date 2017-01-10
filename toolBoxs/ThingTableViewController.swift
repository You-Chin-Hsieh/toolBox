//
//  ThingTableViewController.swift
//  Demo
//
//  Created by Peter  on 13/12/2016.
//  Copyright © 2016 Peter. All rights reserved.
//

import UIKit
import UserNotifications
class ThingTableViewController: UITableViewController {
//ssssssss
    @IBAction func addNoti(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "注意"
        content.subtitle = "使用者"
        content.body = "過來這裡治療。"
        content.badge = 1
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
   
     
    var lovers = [[String:String]]()

    func updateFile() {
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("lovers.txt")
        print("url \(url)")
        let result = (lovers as NSArray).write(to: url!, atomically: true)
        print("result \(result)")
    }
    
    func addLoverNoti(noti:Notification) {
        let dic = noti.userInfo as! [String:String]
        lovers.append(dic)
        updateFile()
        
        
        self.tableView.reloadData()
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("lovers.txt")
        let array = NSArray(contentsOf: url!)
        if array != nil {
            lovers = array as! [[String:String]]
        }
        
      
        let notiName = Notification.Name("addLover")
        NotificationCenter.default.addObserver(self, selector: #selector(ThingTableViewController.addLoverNoti(noti:)), name: notiName, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return lovers.count

        
    }
    private func showNotificationWidtFireDate(){
        
        // 建立通知物件
        let myNotification: UILocalNotification = UILocalNotification()
        
        // 通知訊息內容
        myNotification.alertBody = "通知訊息測試使用 FireDate"
        
        // 通知訊息發送時的聲音
        myNotification.soundName = UILocalNotificationDefaultSoundName
        
        // 時區Timezone設定
        myNotification.timeZone = NSTimeZone.default
        
        // 10秒後發送訊息
        myNotification.fireDate = Date(timeIntervalSinceNow: 15)
        
        // 將通知物件入通知排程
        UIApplication.shared.scheduleLocalNotification(myNotification)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoverCell", for: indexPath) as! ThingTableViewCell
        let dic = lovers[indexPath.row]

        
    
        // Configure the cell...
    cell.nameLabel.text = dic["name"]
    cell.time.text=dic["time"]
        
        
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      
        lovers.remove(at: indexPath.row)
        updateFile()

        
        self.tableView.reloadData()
        
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let dic:[String:String]
            dic = lovers[indexPath!.row]
            
            
            let controller = segue.destination as! ThingDetailViewController
            controller.ThingDic = dic

        }
        
    }


}
