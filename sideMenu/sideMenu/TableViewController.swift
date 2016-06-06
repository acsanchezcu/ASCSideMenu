//
//  TableViewController.swift
//  sideMenu
//
//  Created by Abel Sánchez Custodio on 6/6/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var rightSideSwitch: UISwitch!
    @IBOutlet weak var leftSideSwitch: UISwitch!
    
    @IBOutlet weak var behindNavigationBarModeSwitch: UISwitch!
    @IBOutlet weak var behindNavigationViewModeSwitch: UISwitch!
    @IBOutlet weak var overNavigationBarModeSwitch: UISwitch!
    @IBOutlet weak var overNavigationViewModeSwitch: UISwitch!

    @IBOutlet weak var widthLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    var menuMode: MenuMode {
        get {
            if behindNavigationBarModeSwitch.on {
                return .BehindNavigationBar
            } else if behindNavigationViewModeSwitch.on {
                return .BehindNavigationView
            } else if overNavigationBarModeSwitch.on {
                return .OverNavigationBar
            } else {
                return .OverNavigationView
            }
        }
    }

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.minimumValue = 100.0
        slider.maximumValue = Float(view.frame.width - 40.0)
        slider.value = 300.0
        
        widthLabel?.text = String(format: "%.2f", 300.0)
    }
    
    // MARK: - Actions
    
    @IBAction func userDidChangedSliderValue(sender: AnyObject) {
        
        widthLabel?.text = String(format: "%.2f", slider.value)
    }
    
    @IBAction func userDidChangedLeftSideSwitch(sender: AnyObject) {
        rightSideSwitch.on = !leftSideSwitch.on
    }
    
    @IBAction func userDidChangedRightSideSwitch(sender: AnyObject) {
        leftSideSwitch.on = !rightSideSwitch.on
    }
    
    @IBAction func userDidChangedBehindNavigationBarSwitch(sender: AnyObject) {
        if behindNavigationBarModeSwitch.on {
            behindNavigationViewModeSwitch.on = false
            overNavigationBarModeSwitch.on = false
            overNavigationViewModeSwitch.on = false
        } else {
            behindNavigationViewModeSwitch.on = true
        }
    }
    
    @IBAction func userDidChangedBehindNavigationViewSwitch(sender: AnyObject) {
        if behindNavigationViewModeSwitch.on {
            behindNavigationBarModeSwitch.on = false
            overNavigationBarModeSwitch.on = false
            overNavigationViewModeSwitch.on = false
        } else {
            behindNavigationBarModeSwitch.on = true
        }
    }
    
    @IBAction func userDidChangedOverNavigationBarSwitch(sender: AnyObject) {
        if overNavigationBarModeSwitch.on {
            behindNavigationViewModeSwitch.on = false
            behindNavigationBarModeSwitch.on = false
            overNavigationViewModeSwitch.on = false
        } else {
            behindNavigationBarModeSwitch.on = true
        }
    }
    
    @IBAction func userDidChangedOverNavigationViewSwitch(sender: AnyObject) {
        if overNavigationViewModeSwitch.on {
            behindNavigationViewModeSwitch.on = false
            overNavigationBarModeSwitch.on = false
            behindNavigationBarModeSwitch.on = false
        } else {
            behindNavigationBarModeSwitch.on = true
        }
    }
    
    @IBAction func userDidTapGenerateMenuButton(sender: AnyObject) {
        performSegueWithIdentifier("goToViewController", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let viewController =  segue.destinationViewController as! ViewController
        
        let menuTableView = MenuTableView.init()
        
        let menuWidth: CGFloat = CGFloat(slider.value)
        let menuSide: MenuSide = (rightSideSwitch.on) ? .Right : .Left
        let menuView: UIView = menuTableView
        
        let menuConfiguration : MenuConfiguration = MenuConfiguration.init(menuWidth: menuWidth, menuSide: menuSide, menuMode: menuMode, menuView: menuView)
        
        viewController.menuConfiguration = menuConfiguration
    }
}
