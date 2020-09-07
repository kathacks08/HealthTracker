//
//  ViewController.swift
//  Health Tracker
//
//  Created by Katherine Sullivan on 9/5/20.
//  Copyright © 2020 Katherine Sullivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var studytips: UIButton!
    @IBOutlet weak var fitness: UIButton!
    @IBOutlet weak var music: UIButton!
    @IBOutlet weak var stayConnected: UIButton!
    @IBOutlet weak var mind: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        food.addTarget(self, action: "food", for: .touchUpInside)
        
        studytips.addTarget(self, action: "studytips", for: .touchUpInside)
        
        fitness.addTarget(self, action: "fitness", for: .touchUpInside)
        
        music.addTarget(self, action: "music", for: .touchUpInside)
        
        mind.addTarget(self, action: "mind", for: .touchUpInside)
        
        stayConnected.addTarget(self, action: "stayConnected", for: .touchUpInside)
    }

    @IBAction func food(_ sender: Any) {
       
        UIApplication.shared.openURL(NSURL(string: "https://pinchofyum.com/fluffiest-blueberry-pancakes")! as URL)
    }
    

    @IBAction func studytips(_ sender: Any) {
        
        UIApplication.shared.openURL(NSURL(string: "https://goodcolleges.online/study-tips-for-success/")! as URL)
        
    }
    
    
    @IBAction func fitness(_ sender: Any) {

        UIApplication.shared.openURL(NSURL(string: "https://www.chloeting.com/program/")! as URL)
        
    }
    
    @IBAction func music(_ sender: Any) {
        
        UIApplication.shared.openURL(NSURL(string: "https://open.spotify.com/playlist/37i9dQZF1DX9sIqqvKsjG8")! as URL)
    }
    
    
    @IBAction func mind(_ sender: Any) {
        
        UIApplication.shared.openURL(NSURL(string: "https://mindworks.org/blog/")! as URL)
    }
    
    
    @IBAction func stayConnected(_ sender: Any) {
        
        UIApplication.shared.openURL(NSURL(string: "https://www.brainandlife.org/the-magazine/online-exclusives/how-to-stay-connected-during-covid-19/")! as URL)
    }
    
}

