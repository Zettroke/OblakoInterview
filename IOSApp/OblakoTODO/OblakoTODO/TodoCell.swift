//
//  File.swift
//  OblakoTODO
//
//  Created by superroot on 27.12.18.
//  Copyright © 2018 superroot. All rights reserved.
//

import Foundation
import UIKit

import M13Checkbox


class TodoCell: UITableViewCell{
    @IBOutlet weak var task: UILabel!
    
    @IBAction func check(sender: M13Checkbox) {
        if sender.checkState == M13Checkbox.CheckState.Checked{
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: task.attributedText!.string)
            
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            
            
            task.attributedText = attributeString;
        }else{
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: task.attributedText!.string)            
            
            task.attributedText = attributeString;
        }
        
    }
    @IBOutlet weak var checkbox: M13Checkbox!
    
    
}