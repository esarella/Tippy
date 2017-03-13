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
    @IBOutlet weak var defaultTipPercentageControl: UISegmentedControl!

    @IBAction func darkModeChanged() {

        defaults.set(darkModeSwitch.isOn, forKey: "DarkModeEnabled")
        defaults.synchronize()

        if (self.darkModeSwitch.isOn == true) {
            self.darkModeEnabled = true
            setDarkMode()
        } else {
            self.darkModeEnabled = false
            setLightMode()
        }
    }

    @IBAction func defaultTipChanged(_ sender: Any) {
        defaults.set(defaultTipPercentageControl.selectedSegmentIndex, forKey: "DefaultTipPercentage")
        defaults.synchronize()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.defaultTipPercentageControl.selectedSegmentIndex = defaults.integer(forKey: "DefaultTipPercentage")
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

    func setDarkMode() {
        self.view.backgroundColor = Style.darkMode
        self.darkModeSwitch.superview?.backgroundColor = Style.darkMode
        self.darkModeLabel.textColor = Style.lightColor

        self.defaultTipPercentageControl.tintColor = Style.darkMode
        self.defaultTipPercentageControl.backgroundColor = Style.lightColor
        UIApplication.shared.statusBarStyle = .lightContent
    }

    func setLightMode() {
        self.view.backgroundColor = Style.lightColor
        self.darkModeSwitch.superview?.backgroundColor = Style.lightColor
        self.darkModeLabel.textColor = Style.darkColor

        self.defaultTipPercentageControl.tintColor = Style.lightColor
        self.defaultTipPercentageControl.backgroundColor = Style.darkColor
        UIApplication.shared.statusBarStyle = .default
    }
}
