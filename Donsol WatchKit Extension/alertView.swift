//
//  alertView.swift
//  Donsol WatchKit Extension
//
//  Created by Patrick Winchell on 5/5/15.
//  Copyright (c) 2015 Patrick Winchell. All rights reserved.
//

import WatchKit
import Foundation

class alertView: WKInterfaceController
{

    @IBOutlet var returnButton:WKInterfaceButton?
    @IBOutlet var alertLabel:WKInterfaceLabel?

    override func awakeWithContext(context: AnyObject?)
    {
        if let values = context as? Dictionary<String,String>
        {
            self.setTitle(values["title"])
            self.alertLabel?.setText(values["text"])
            self.returnButton?.setTitle(values["button"])
        }
    }

    @IBAction func buttonPressed()
    {
        self.dismissController()
    }
}
