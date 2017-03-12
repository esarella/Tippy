//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Emmanuel Sarella on 2/27/17.
//  Copyright © 2017 Emmanuel Sarella. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    let defaults = UserDefaults.standard
    var darkModeEnabled: Bool?

    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var darkModeLabel: UILabel!

    @IBAction func darkModeChanged() {

        defaults.set(darkModeSwitch.isOn, forKey: "DarkModeEnabled")
        defaults.synchronize()

        if (self.darkModeSwitch.isOn == false) {
            self.view.backgroundColor = UIColor.white
            self.darkModeSwitch.superview?.backgroundColor = UIColor.white
            self.darkModeLabel.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
            UIApplication.shared.statusBarStyle = .default
            self.darkModeEnabled = false
        }
        //Dark Mode ON
        else {
            self.view.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
            self.darkModeSwitch.superview?.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
            self.darkModeLabel.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
            self.darkModeEnabled = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.darkModeEnabled = defaults.bool(forKey: "DarkModeEnabled")

        if (self.darkModeEnabled!) {
            self.darkModeSwitch.setOn(true, animated: false)
        } else {
            self.darkModeSwitch.setOn(false, animated: false)
        }

        darkModeChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }

}
