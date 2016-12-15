//
//  SMViewTableViewController.swift
//  LGCPD
//
//  Created by Aashish Adhikari on 12/8/16.
//  Copyright © 2016 Aashish Adhikari. All rights reserved.
//

import UIKit

struct SM{
    var id: String
    var name: String
    var address: String
    var phone: String
    var vdc: String
}

class SMViewTableViewController: UITableViewController {
    
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    
    
    var sm = Array<SM>()
    var json: [AnyObject]!
    
    /**
     * value -> name of the Disstrict or Municipality
     * location -> District / Municipality
     * method -> SM / LSP
     */
    
    var value: String!
    var location: String!
    var method: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Spinner
        indicator.color = UIColor.black
        indicator.frame = CGRect(origin: CGPoint.init(x: 0, y: 0), size: CGSize(width: 10, height: 10) )
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        //indicator.bringSubview(toFront: UIView)
        indicator.startAnimating()
        
        DispatchQueue.global(qos: .background).async {
            self.getDataForList()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        self.indicator.stopAnimating()
        self.indicator.hidesWhenStopped = true
        
        tableView.rowHeight = 100

    }
    
    private func getDataForList(){
        
        sm.removeAll()
        var url_str: String = ""
        
        print("Location: ",location)
        print("Value: ",value)
        print("method: ",method)
        
        if ( self.method == "sm"){
            if (self.location == "district"){
                print(Constants.API + method + "/" + location + "/" + value)
                url_str = Constants.API + method + "/" + location + "/" + value
                let url = URL(string: url_str)
                dataForSM(url: url!)
                
            }
            
            if(self.location == "munic"){
                print(Constants.API + method + "/" + location + "/" + value)
                url_str = Constants.API + method + "/" + location + "/" + value
                let url = URL(string: url_str)
                dataForSM(url: url!)
            }
        
        }else{
            if (self.location == "district"){
                print(Constants.API + method + "/" + location + "/" + value)
                url_str = Constants.API + method + "/" + location + "/" + value
                let url = URL(string: url_str)
                dataForLSP(url: url!)
                
            }
            
            if(self.location == "munic"){
                print(Constants.API + method + "/" + location + "/" + value)
                url_str = Constants.API + method + "/" + location + "/" + value
                let url = URL(string: url_str)
                dataForLSP(url: url!)
            }
        
        }
    }
    
    private func dataForSM(url: URL){
        
        
        if let data = try? Data(contentsOf: url){
            do{
                json = try JSONSerialization.jsonObject(with: data, options: [] ) as? Array
            } catch {
                print(error)
            }
            
            if(json.count != 0){
                for index in 0...json.count-1{
                    if let item = json[index] as? [String: AnyObject] {
                        sm.append( SM(id: item["id"] as! String,
                                      name: item["name"] as! String,
                                      address: item["address"] as! String,
                                      phone: item["phone"] as! String,
                                      vdc: item["vdc"] as! String)
                        )
                    }
                }
                
            }
        }
    }
    
    private func dataForLSP(url: URL){
        
        
        if let data = try? Data(contentsOf: url){
            do{
                json = try JSONSerialization.jsonObject(with: data, options: [] ) as? Array
            } catch {
                print(error)
            }
            
            if(json.count != 0){
                for index in 0...json.count-1{
                    if let item = json[index] as? [String: AnyObject] {
                        sm.append( SM(id: item["id"] as! String,
                                      name: item["name"] as! String,
                                      address: item["contact_email"] as! String,
                                      phone: item["office_phone"] as! String,
                                      vdc: item["address"] as! String)
                        )
                    }
                }
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let controller = segue.destination as! DetailViewController
                controller.id = sm[indexPath.row].id
                controller.method = self.method
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sm.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "LabelCell",for: indexPath) as! SMListTableViewCell
       
        cell.name.text = sm[indexPath.row].name
        cell.address.text = sm[indexPath.row].address
        cell.phoneNo.text = sm[indexPath.row].phone
        cell.vdc.text = sm[indexPath.row].vdc
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You Selected : \(sm[indexPath.row].name)")
    }
}
