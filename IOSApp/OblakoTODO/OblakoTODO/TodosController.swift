//
//  TodosController.swift
//  OblakoTODO
//
//  Created by superroot on 27.12.18.
//  Copyright © 2018 superroot. All rights reserved.
//

import Foundation
import UIKit

class TodosController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    var data = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = [
            ["Family", "Do it", "Do that", "Do this"],
            ["Family1", "Do it1", "Do that1", "Do this1"],
            ["Family2", "Do it2", "Do that2", "Do this2"],
            ["Family3", "Do it3", "Do that3", "Do this3"],
        ]
        
        print("dksajdksadjlsajdklsadjsakldjsadkasjl!!!!!!111")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count-1;
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header: HeaderCell = tableView.dequeueReusableCellWithIdentifier("header") as! HeaderCell;
        
        header.header.text = data[section][0]
        
        return header
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: TodoCell = tableView.dequeueReusableCellWithIdentifier("task") as! TodoCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.task.text = data[indexPath.section][indexPath.row+1];
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        let navVC = segue.destinationViewController as? UINavigationController

        let tableVC = navVC?.viewControllers.first as! AddTodoController

        tableVC.data = data
        
    }
}
