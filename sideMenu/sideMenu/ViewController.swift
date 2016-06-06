//
//  ViewController.swift
//  sideMenu
//
//  Created by Abel Sánchez Custodio on 2/6/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

class ViewController: ASCMenuViewController {
    
    var menuConfiguration : MenuConfiguration?

    override func viewDidLoad() {
        super.viewDidLoad()

        initMenuConfiguration(menuConfiguration!)
    }
}
