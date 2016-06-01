//
//  ViewController.swift
//  sideMenu
//
//  Created by Abel Sánchez Custodio on 31/5/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let menuWidth : CGFloat = 300.0

    var isMenuOpen = false
    
    var menuVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var userDidTapMenuButton: UIBarButtonItem!

    @IBAction func userDidTapMenuButton(sender: AnyObject) {
        
        isMenuOpen = !isMenuOpen
        
        openMenu(isMenuOpen)
        
        
        
        return
        
        if isMenuOpen {
            menuVC?.dismissViewControllerAnimated(true, completion: { 
                self.isMenuOpen = false
            });
        } else {
            menuVC = ASCMenuViewController(nibName:"ASCMenuViewController", bundle: nil)
//            menuVC?.modalTransitionStyle = 
            menuVC?.modalPresentationStyle = .OverCurrentContext
            
            navigationController?.presentViewController(menuVC!, animated: true, completion: {
                self.isMenuOpen = true
            })
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if isMenuOpen {
            isMenuOpen = false
            
            openMenu(isMenuOpen)
        }
        
    }
    
    func openMenu(open: Bool) {
        let translation : CGFloat = (open) ? menuWidth : 0.0
        
        UIView.animateWithDuration(0.3) {
            self.navigationController!.view.transform = CGAffineTransformMakeTranslation(translation, 0)
        }
    }
}

