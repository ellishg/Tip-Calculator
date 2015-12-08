//
//  SettingsViewController.swift
//  tips
//
//  Created by Ellis Sparky Hoag on 12/5/15.
//  Copyright © 2015 Ellis Sparky Hoag. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var roundingSwitch: UISwitch!
    
    @IBOutlet weak var signControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        tipSlider.value = Float(defaults.integerForKey("Default Tip"))
        
        tipLabel.text = ("Default Tip: \(defaults.integerForKey("Default Tip"))%")
        
        let red = defaults.floatForKey("Red Background")
        
        let green = defaults.floatForKey("Green Background")
        
        let blue = defaults.floatForKey("Blue Background")
        
        redSlider.value = red
        
        greenSlider.value = green
        
        blueSlider.value = blue
        
        colorView.backgroundColor = UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: 1.0)
        
        colorView.layer.borderColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).CGColor
        
        colorView.layer.borderWidth = 1.5
        
        signControl.selectedSegmentIndex = defaults.integerForKey("Currency Sign")
        
        roundingSwitch.on = defaults.boolForKey("Rounding Switch")
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func tipValueChanged(sender: AnyObject) {
        
        tipLabel.text = "Default Tip: \(Int(tipSlider.value))%"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(Int(tipSlider.value), forKey: "Default Tip")
        
        defaults.synchronize()
    }
    
    @IBAction func colorSlider(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let red = redSlider.value
        let green = greenSlider.value
        let blue = blueSlider.value
        
        let color = UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: 1.0)
        
        defaults.setFloat(red, forKey: "Red Background")

        defaults.setFloat(green, forKey: "Green Background")

        defaults.setFloat(blue, forKey: "Blue Background")

        defaults.synchronize()
        
        
        colorView.backgroundColor = color
        
    }
    
    @IBAction func signControlChanged(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        signControl.titleForSegmentAtIndex(signControl.selectedSegmentIndex)
        
        defaults.setInteger(signControl.selectedSegmentIndex, forKey: "Currency Sign")
        
        defaults.synchronize()
    }
    
    @IBAction func roundingSwitchValueChanged(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setBool(roundingSwitch.on, forKey: "Rounding Switch")
        
        defaults.synchronize()
    }
    
}
