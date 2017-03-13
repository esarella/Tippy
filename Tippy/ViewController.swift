//
//  ViewController.swift
//  Tippy
//
//  Created by Emmanuel Sarella on 2/26/17.
//  Copyright © 2017 Emmanuel Sarella. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!

    var darkMode: Bool?

    var Timestamp: TimeInterval {
        return Date().timeIntervalSince1970
    }

    let defaults = UserDefaults.standard

    override func viewWillAppear(_ animated: Bool) {

        billField.borderStyle = .none
        billField.layer.borderWidth = 0

        self.tipControl.selectedSegmentIndex = defaults.integer(forKey: "DefaultTipPercentage")

        self.darkMode = defaults.bool(forKey: "DarkModeEnabled")
        setBackgroundColours()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        billField.placeholder = Locale.current.currencySymbol
        billField.delegate = self
        billField.becomeFirstResponder()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(applicationWillResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        notificationCenter.addObserver(self, selector: #selector(applicationWillEnterForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func applicationWillResignActive(notification: NSNotification) {
        setUserDefaults()
    }

    func applicationWillEnterForeground(notification: NSNotification) {
        self.darkMode = false
        let elapsed = Date().timeIntervalSince1970 - defaults.double(forKey: "TimeStamp")

        if (elapsed < (5 * 60)) {
            billField.text = defaults.string(forKey: "BillAmount")
            tipControl.selectedSegmentIndex = defaults.integer(forKey: "TipControlSegmentIndex")

            calculateTip(self)
        } else {

            billField.text = ""
            billField.placeholder = Locale.current.currencySymbol
            tipControl.selectedSegmentIndex = 0

            calculateTip(self)
        }
        billField.becomeFirstResponder()

    }

    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {

        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.decimalSeparator = Locale.current.decimalSeparator

        let tipPercentage = [0.18, 0.2, 0.25]

        let billDoubleValue = billField.text!.doubleValue
        let tip = billDoubleValue * tipPercentage[tipControl.selectedSegmentIndex]
        let total = billDoubleValue + tip

        let myTip = NSNumber(value: Double(tip))
        let myTotal = NSNumber(value: Double(total))

        let localizedTip = formatter.string(from: myTip)
        let localizedTotal = formatter.string(from: myTotal)

        tipLabel.text = localizedTip!
        totalLabel.text = localizedTotal!
        setUserDefaults()

    }

    func setUserDefaults() {
        defaults.set(Timestamp, forKey: "TimeStamp")
        defaults.set(billField.text, forKey: "BillAmount")
        defaults.set(tipControl.selectedSegmentIndex, forKey: "TipControlSegmentIndex")

        defaults.synchronize()
    }

    func setBackgroundColours() {
        if (self.darkMode!) {
            setDarkMode()
            billField.keyboardAppearance = .dark
            billField.resignFirstResponder()
            billField.becomeFirstResponder()
        }
        else {
            setLightMode()
            billField.keyboardAppearance = .light
            billField.resignFirstResponder()
            billField.becomeFirstResponder()
        }

    }

    func setDarkMode() {
        let darkColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
        let lightTextColor = UIColor.white

        self.view.backgroundColor = darkColor
        billField.textColor = lightTextColor
        billField.attributedPlaceholder = NSAttributedString(string: billField.placeholder!,
                attributes: [NSForegroundColorAttributeName: UIColor.white])
        tipLabel.textColor = lightTextColor
        totalLabel.textColor = lightTextColor
        totalLabel.backgroundColor = darkColor

        tipControl.tintColor = lightTextColor
        UIApplication.shared.statusBarStyle = .lightContent
    }

    func setLightMode() {
        let lightColor = UIColor.white
        let darkTextColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)

        self.view.backgroundColor = lightColor
        billField.textColor = darkTextColor
        tipLabel.textColor = darkTextColor
        totalLabel.textColor = darkTextColor
        totalLabel.backgroundColor = lightColor
        tipControl.tintColor = darkTextColor
        UIApplication.shared.statusBarStyle = .default
    }

}

extension String {
    var doubleValue: Double {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: self) {
            return result.doubleValue
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}


