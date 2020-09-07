//
//  MessagesViewController.swift
//  Health Tracker
//
//  Created by Katherine Sullivan on 9/5/20.
//  Copyright © 2020 Katherine Sullivan. All rights reserved.
//

import UIKit
//import SwipeCellKit

class MessagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var reminders: UITableView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let defaults = UserDefaults.standard
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    var messagesArray = [Cell]()
    let messages = ["Save your eyes and look away from the screen!", "Be flexible and take a stretch!", "Hydrate or diedrate! Go get a glass of water :) "]
    let images = [UIImage]()
   
    var patternCount = 0;
    var notifPatternCount = 0;
    
    
    //VIEW DID LOAD STARTS HERE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 10)
    
        
        
        //for testing purposes
        
        progressBar.progress = 0.0
        
        
        reminders.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //enabling notification functions
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkPressed), name: Notification.Name("checkPressed"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(uncheckPressed), name: Notification.Name("uncheckPressed"), object: nil)

        
        //set todayProgress to 0 at 12:00am

        
        //check value for progress bar
        let curFloat = defaults.float(forKey: "todayProgress")
        progressBar.progress = curFloat
        
        //setting up data table
        
        reminders.dataSource = self
        reminders.delegate = self
        reminders.reloadData()
        
        //setting up local notifications to run in the background
        
    
        self.userNotificationCenter.delegate = self
        self.requestNotificationAuthorization()
        self.sendNotification()
        
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: (#selector(MessagesViewController.pattern)), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: (#selector(MessagesViewController.checkTime)), userInfo: nil, repeats: true)
        
            
        
    }
    
    @objc func checkTime() {
        
         let calendar = Calendar.current
         let now = Date()
         
         let midnight = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: now)!
         
        if(now == midnight) {
            
            self.messagesArray.removeAll()
            
        }
        
    }
    
    //method that loops through messages in a pattern and then restarts
    
    @objc func pattern(){
        
        var curNotif = String()
        //pattern: hydrate, screen time, hydrate, stretch, screen time
        
        //array: screen time, stretch, hydrate
        
        if(patternCount == 0) {
            curNotif = messages[2]
            patternCount += 1
        } else if (patternCount == 1) {
            curNotif = messages[0]
            patternCount += 1
        } else if (patternCount == 2) {
            curNotif = messages[2]
            patternCount += 1
        } else if (patternCount == 3) {
            curNotif = messages[1]
            patternCount += 1
        } else if (patternCount == 4) {
            curNotif = messages[0]
            patternCount = 0
        } else {
            print("something's wrong")
        }
        
        localNotificationSent(String: curNotif)
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reminders.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        
        return cell
    }
    
    @objc func checkPressed(notification: NSNotification) {
        
        if progressBar.progress <= 0.8 {
            
            progressBar.progress += 0.2
            
        } else {
            //maybe play confetti or some kind of popup
        }
        
        //if necessary delete cell
    }
    
    @objc func uncheckPressed(notification: NSNotification) {
        
        if progressBar.progress >= 0.2 {
            
            progressBar.progress -= 0.2
        
        }
        
    }
    
    func requestNotificationAuthorization() {
        
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    func sendNotification() {
        
        // Create new notifcation content instance
        let notificationContent = UNMutableNotificationContent()

        // Add the content to the notification content
        
        notificationContent.body = "Here's your next reminder to take a break! Click me :)"
        
        //not sure what this does
        notificationContent.badge = NSNumber(value: 3)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60,
        repeats: true)
        
        let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
        if let error = error {
            print("Notification Error: ", error)
        } }
        
        
    }
    
    
    //add parameter for time later
    func localNotificationSent(String mess: String) {
        
        //change content of first blank cells
        
        let cell: Cell = Cell()
        // var text = String()
        var picture = UIImage()
        var pictureName = String()
        

        if mess == "Save your eyes and look away from the screen!" {
            picture = UIImage(named: "cartoonphone.png")!
            pictureName = "cartoonphone.png"
        } else if mess == "Be flexible and take a stretch!" {
            picture = UIImage(named: "stretch.jpg")!
            pictureName = "stretch.jpg"
        } else if mess == "Hydrate or diedrate! Go get a glass of water :) " {
            picture = UIImage(named: "cup.jpg")!
            pictureName = "cup.jpg"
        } else {
            print("error: no image found")
        }
                
        
        defaults.set(mess, forKey: "messageValue")
        defaults.set(pictureName, forKey: "pictureName")
        
        print("ORIGINAL MESSAGE ARRAY + \(messagesArray.count)")
        self.messagesArray.append(cell)
        print("CURRENT MESSAGE ARRAY + \(messagesArray.count)")
        
        DispatchQueue.main.async{
            self.reminders.reloadData()
        }
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    

}
