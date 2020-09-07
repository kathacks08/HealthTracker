//
//  Cell.swift
//  Health Tracker
//
//  Created by Katherine Sullivan on 9/5/20.
//  Copyright © 2020 Katherine Sullivan. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var box: UIButton!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var time: UILabel!
    
    var count = Int()
    var imageValue = UIImage()
    var imageName = String()
    
    let defaults = UserDefaults.standard
    
    var checked = Bool()
    var messageValue = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checked = false;
        
        messageValue = defaults.string(forKey: "messageValue")!
        imageName = defaults.string(forKey: "pictureName")!
        imageValue = UIImage(named: imageName)!
        
        message.text = messageValue
        icon.image = imageValue
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func checkClicked(_ sender: Any) {
        
        //change image to checked box
        
        if checked == false {
        
        box.setImage(UIImage(named: "resizedcheck.png")?.withRenderingMode(.alwaysOriginal), for:[])
            
            NotificationCenter.default.post(name: Notification.Name("checkPressed"), object: nil)
            
            checked = true
            
        } else {
            
            
            box.setImage(UIImage(named: "newbox.png")?.withRenderingMode(.alwaysOriginal), for:[])
            
            NotificationCenter.default.post(name: Notification.Name("uncheckPressed"), object: nil)
            
            checked = false
            
        }

        
        //setting count of the cell to current Row
//        defaults.set(count, forKey: time.text!)
//        defaults.set(time.text!, forKey: "timeLabel")
        
        
    
        
    
    }
    
}
