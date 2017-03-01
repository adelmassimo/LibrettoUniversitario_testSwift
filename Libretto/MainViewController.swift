//
//  MainViewController.swift
//  Libretto
//
//  Created by adel on 02/04/16.
//  Copyright © 2016 Adel. All rights reserved.
//

import Cocoa

class MainViewController: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.selectedTabViewItemIndex = 0
        self.view.window?.title = "Libretto"
    }
}
