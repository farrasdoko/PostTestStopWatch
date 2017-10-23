//
//  ViewController.swift
//  iStopWatch
//
//  Created by Gw on 19/10/17.
//  Copyright © 2017 Gw. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    //MARK: - Global Variables
    var timer = Timer()
    var seconds:Int = 0
    var minutes: Int = 0
    var fractions:Int = 0
    var startStopWatch = true
    var addLap = false
    var displayString = ""
    var lapsArray = [String]()
    
    
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var DisplayLB: UILabel!
    @IBOutlet weak var lapsTableView: UITableView!
    @IBOutlet weak var startStopLB: UIButton!
    @IBOutlet weak var lapResetLB: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DisplayLB.text = "00:00.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = "Lap \(lapsArray.count -    indexPath.row)"
        cell.detailTextLabel?.textColor = UIColor.white
        
        cell.detailTextLabel?.text = lapsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapsArray.count
    }
    
    //updateStopWatch function
    
    func updateStopWatch() {
        
        fractions += 1
        if fractions == 100 {
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = (fractions > 9) ? "\(fractions)" : "0\(fractions)"
     
        let secondsString = (seconds > 9) ? "\(seconds)" : "0\(seconds)"
        let minutesString = (minutes > 9) ? "\(minutes)" : "0\(minutes)"
        
        displayString = "\(minutesString):\(secondsString).\(fractionsString)"
        DisplayLB.text = displayString
    }
    
    
    
    

    //MARK: - IBActions
    
    @IBAction func startStopBTPressed(_ sender: UIButton) {
        
        
        if startStopWatch == true {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateStopWatch), userInfo: nil, repeats: true)
            startStopWatch = false
            
            startStopLB.setImage(UIImage(named: "Stop.png"), for: .normal)
            lapResetLB.setImage(UIImage(named: "Lap.png"), for: .normal)
            addLap = true
            
            
            
        } else {
            timer.invalidate()
            startStopWatch =  true
            startStopLB.setImage(UIImage(named: "Start.png"), for: .normal)
            lapResetLB.setImage(UIImage(named: "Reset.png"), for: .normal)
            addLap = false
            
        }
        
        
        
    }
    
    @IBAction func lapResetBTPressed(_ sender: UIButton) {
        
        
        if addLap == true {
            
            lapsArray.insert(displayString, at: 0)
            lapsTableView.reloadData()
            
            
            
        } else {
            addLap = false
            lapResetLB.setImage(UIImage(named: "Lap.png"), for: .normal)
            lapsArray.removeAll()
            lapsTableView.reloadData()
            
            fractions = 0
            seconds = 0
            minutes = 0
            
            displayString = "00:00.00"
            DisplayLB.text = displayString
        }
        
        
        
        
        
        
    }
    
    
    
    
    

}






