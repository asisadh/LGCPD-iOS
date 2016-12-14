//
//  ViewController.swift
//  LGCPD
//
//  Created by Aashish Adhikari on 12/8/16.
//  Copyright © 2016 Aashish Adhikari. All rights reserved.
//

import UIKit

class DistrictViewController: UITableViewController {
    
    var indicator:UIActivityIndicatorView!
    
    var district = [String]()
    var json: [AnyObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progressHUD = ProgressHUD(text: "Loading Data")
        self.view.addSubview(progressHUD)
        
        DispatchQueue.global(qos: .background).async {
            self.getDataForList()
            
            DispatchQueue.main.async {
                print("District \(self.district)")
                self.tableView.reloadData()
                progressHUD.hide()
            }
        }
    }
    
    private func getDataForList(){
        let url=URL(string: Constants.SM_URL_LIST + "district")
        if let data = try? Data(contentsOf: url!){
            do{
                json = try JSONSerialization.jsonObject(with: data, options: [] ) as? Array
            } catch {
                print(error)
            }
            
            for index in 0...json.count-1{
                if let item = json[index] as? [String: AnyObject] {
                    print("JSON \(item["name_en"])")
                    district.append(item["name_en"] as! String)
                }
                
            }
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showList" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let controller = segue.destination as! SMViewTableViewController
                controller.district = district[indexPath.row]
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return district.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = self.district[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You Selected : \(district[indexPath.row])")
    }
    
}
