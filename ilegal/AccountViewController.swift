//
//  AccountViewController.swift
//  ilegal
//
//  Created by Matthew Rigdon on 2/7/17.
//  Copyright © 2017 Jordan. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var userProperties = [UserProperty]()
    private var contactLoaded = false
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 111.0/255.0, green: 42.0/255.0, blue: 59.0/255.0, alpha:1.0)
        
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background2.png"));
    
        
        
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 113.0/255.0, green: 158.0/255.0, blue: 255.0/255.0, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? userProperties.count : 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseID = ""
        if (indexPath.section == 0){
            reuseID = "userPropertyCell"
        }
        else{
            if indexPath.row == 0 {
                reuseID = "contactUsCell"
            }
            else if indexPath.row == 1{
                reuseID = "chatCell"
            }
            else {
                reuseID = "logoutCell"
            }
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0.4);

        
        if indexPath.section == 0 {
            (cell as! UserPropertyCell).userProperty = userProperties[indexPath.row]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 1 {
            if User.currentUser.email == "peterjlu@usc.edu" {
                self.performSegue(withIdentifier: "chatListSegue", sender: indexPath);
            }
            else {
                self.performSegue(withIdentifier: "chatSegue", sender: indexPath);
            }
        }
    }
    
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue" {
            Backend.clearUserLocal()
        }
        else if segue.identifier == "updateUserSegue" {
            let indexPath = tableView.indexPathForSelectedRow
            (segue.destination as! UpdateUserViewController).userProperty = userProperties[indexPath!.row]
        }
        else if segue.identifier == "chatSegue" {
            self.tabBarController?.tabBar.isHidden = true
        }
        else if segue.identifier == "chatListSegue" {
            self.tabBarController?.tabBar.isHidden = true
        }
     }
    
    //

    // MARK: - Methods
    
    private func reloadData() {
        userProperties = [
            UserProperty(displayName: "First Name", value: User.currentUser.firstName, sqlName: "FirstName"),
            UserProperty(displayName: "Last Name", value: User.currentUser.lastName, sqlName: "LastName"),
            UserProperty(displayName: "Email", value: User.currentUser.email, sqlName: "Email"),
            UserProperty(displayName: "Driver's License", value: User.currentUser.license, sqlName: "DLNumber"),
            UserProperty(displayName: "Address", value: User.currentUser.addressOne, sqlName: "Address1"),
            UserProperty(displayName: "City", value: User.currentUser.city, sqlName: "City"),
            UserProperty(displayName: "State", value: User.currentUser.state, sqlName: "State"),
            UserProperty(displayName: "Zip", value: User.currentUser.zipcode, sqlName: "ZipCode"),
        ]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
