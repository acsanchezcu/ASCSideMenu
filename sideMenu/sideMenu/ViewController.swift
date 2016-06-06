//
//  ViewController.swift
//  sideMenu
//
//  Created by Abel Sánchez Custodio on 2/6/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

class ViewController: ASCMenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let menuTableView = MenuTableView.init()
        
        initMenuConfiguration(MenuConfiguration(menuWidth: 300.0, menuSide: .Left, menuMode: .BehindNavigationView, menuView: menuTableView))
    }
}
