//
//  SettingsTableViewController.swift
//  zodiacFun
//
//  Created by C4Q on 12/11/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var dateCell: UITableViewCell!
    @IBOutlet weak var nameCell: UITableViewCell!
    
    let defaults = UserDefaults.standard
    let nameKey = "nameKey"
    let dateKey = "dateKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = self.defaults.value(forKey: self.nameKey) as? String{
            self.nameCell.textLabel?.text = name
        }
        if self.defaults.value(forKey: self.nameKey) as? String == "" {
            self.nameCell.textLabel?.text = "Please Edit Your Name"
        }
        
        if let date = self.defaults.value(forKey: self.dateKey) as? String{
            self.dateCell.textLabel?.text = date
        }
        
        if self.defaults.value(forKey: self.dateKey) as? String == ""{
            self.dateCell.textLabel?.text = "Please Edit Your Birthday"
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.indexPathForSelectedRow?.section == 0{
            let alert = UIAlertController(title: "Please Enter Your Name ", message: "", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.text = ""
            }
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                self.defaults.set(textField?.text, forKey: self.nameKey)
                
                
                if let name = self.defaults.value(forKey: self.nameKey) as? String{
                self.nameCell.textLabel?.text = name
                }
                
                if self.defaults.value(forKey: self.nameKey) as? String == ""{
                    self.nameCell.textLabel?.text = "Please Edit Your Name"
                }
                tableView.reloadData()
                
                }
                )
            )
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            
        } else{
            let alert = UIAlertController(title: "Please Enter Your Birthday", message: "ex. April 26", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = ""
            }
            
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
               
                self.defaults.set(textField?.text, forKey: self.dateKey )
                
                
                if let date = self.defaults.value(forKey: self.dateKey) as? String{
                    self.dateCell.textLabel?.text = date
                }
                
                if self.defaults.value(forKey: self.dateKey) as? String == ""{
                    self.dateCell.textLabel?.text = "Please Edit Your Birthday"
                }
                tableView.reloadData()
            }))
            
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
