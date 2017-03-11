//
//  ViewController.swift
//  Tippy
//
//  Created by Emmanuel Sarella on 2/26/17.
//  Copyright © 2017 Emmanuel Sarella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {

        let tipPercentage = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        
    }
    
    func getUserDefaults() -> UserDefaults
    {
        let defaults = UserDefaults.standard
        
        let timeStamp = defaults.integer(forKey: "TimeStamp")
        let billAmount = defaults.integer(forKey: "BillAmount")
        let tipControlSegmentIndex = defaults.integer(forKey: "TipControlSegmentIndex")
        
        return defaults
    }

    func setUserDefaults()
    {
        let defaults = UserDefaults.standard
        defaults.set(25, forKey: "TimeStamp")
        defaults.set(25, forKey: "BillAmount")
        defaults.set(1, forKey: "TipControlSegmentIndex")

        defaults.synchronize()
    }
}

