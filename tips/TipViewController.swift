//
//  ViewController.swift
//  tips
//
//  Created by Ellis Sparky Hoag on 12/5/15.
//  Copyright © 2015 Ellis Sparky Hoag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var tipPercentageLabel: UILabel!

    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var percentageSlider: UISlider!
    
    @IBOutlet weak var totalTextLabel: UILabel!
    
    @IBOutlet weak var tipTextLabel: UILabel!
    
    @IBOutlet weak var billAmountTextLabel: UILabel!
    
    @IBOutlet weak var barView: UIView!
    
    var inputIsEmpty = true
    
    let animationTime = 0.69
    
    var currency: String!
    
    var rounding: Bool = false
    
    let numberFormator = NSNumberFormatter()
    
    let memoryDuration = NSTimeInterval.init(600) //10 minutes
    
    func fadeIn() {
        
        self.barView.alpha = 1.0
        self.tipLabel.alpha = 1.0
        self.totalLabel.alpha = 1.0
        self.tipTextLabel.alpha = 1.0
        self.totalTextLabel.alpha = 1.0
        self.billAmountTextLabel.alpha = 1.0
    }
    
    func fadeOut() {
        
        self.barView.alpha = 0.0
        self.tipLabel.alpha = 0.0
        self.totalLabel.alpha = 0.0
        self.tipTextLabel.alpha = 0.0
        self.totalTextLabel.alpha = 0.0
        self.billAmountTextLabel.alpha = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Did Load")
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let defaultsDictionary = ["Default Tip": 15, "Red Background": 1.0, "Green Background": 1.0, "Blue Background": 1.0, "Currency Sign": 0, "Rounding Switch": false, "Bill Field": 0, "Last Active Time": NSDate()]
        
        defaults.registerDefaults(defaultsDictionary)
        
        percentageSlider.value = Float(defaults.integerForKey("Default Tip"))
        
        tipPercentageLabel.text = "Tip: \(defaults.integerForKey("Default Tip"))%"
        
        
        barView.alpha = 0.0
        tipLabel.alpha = 0.0
        totalLabel.alpha = 0.0
        tipTextLabel.alpha = 0.0
        totalTextLabel.alpha = 0.0
        billAmountTextLabel.alpha = 0.0

        
        let red = defaults.floatForKey("Red Background")

        let green = defaults.floatForKey("Green Background")

        let blue = defaults.floatForKey("Blue Background")
        
        view.backgroundColor = UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: 1.0)
        
        switch (defaults.integerForKey("Currency Sign")) {
        
        case 0:
            currency = "$"
        case 1:
            currency = "€"
        case 2:
            currency = "£"
        case 3:
            currency = "¥"
            
        default:
            currency = "?"
        }
        
        billField.placeholder = currency + "0.00"
        
        rounding = defaults.boolForKey("Rounding Switch")
        
        numberFormator.numberStyle = .CurrencyStyle
        
        numberFormator.currencySymbol = currency

        let lastActiveTime = defaults.valueForKey("Last Active Time") as? NSDate
                
        if (-lastActiveTime!.timeIntervalSinceNow <= memoryDuration) {
            
            billField.text = defaults.valueForKey("Bill Field") as? String
            
            onEditingChanged()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        print("Did Appear")
        
        [billField .becomeFirstResponder()]
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        print("Will Disappear")
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue(billField.text, forKey: "Bill Field")
        
        defaults.setValue(NSDate(), forKey: "Last Active Time")
        
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onEditingChanged() {
        
        let tipPercentage = Int(percentageSlider.value)
        
        tipPercentageLabel.text = "Tip: \(tipPercentage)%"
        
        
        if let billAmount = Float(billField.text!)  {
            
            if (billAmount == 0 && !inputIsEmpty) {
                
                inputIsEmpty = true
                
                UIView.animateWithDuration(animationTime, animations: fadeOut)
            }
            else if (inputIsEmpty) {
                
                inputIsEmpty = false
                
                UIView.animateWithDuration(animationTime, animations: fadeIn)
            }
            
            var tipAmount = billAmount * Float(tipPercentage) / 100.0
            
            var totalAmount = tipAmount + billAmount
            
            if (rounding) {
                
                totalAmount = ceil(totalAmount)
                
                tipAmount = totalAmount - billAmount
            }
            
            tipLabel.text = numberFormator.stringFromNumber(tipAmount)!
            
            totalLabel.text = numberFormator.stringFromNumber(totalAmount)!
            
        }
        else if (!inputIsEmpty) {
            
            inputIsEmpty = true
            
            UIView.animateWithDuration(animationTime, animations: fadeOut)
        }
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        onEditingChanged()
    }
    
}

