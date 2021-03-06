//
//  DistrictViewController.swift
//  LGCPD
//
//  Created by Aashish Adhikari on 12/14/16.
//  Copyright © 2016 Aashish Adhikari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var actionButton: ActionButton!
    
    // place here is either name or district or name of municipalities
    var place = [String]()
    var json: [AnyObject]!
    
    // location defines either district or Municipalities are selected
    var location: String!
    
    //method defines are we searching sm or lsp
    var method: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LabelCell")
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let progressHUD = ProgressHUD(text: "Loading Data")
        self.view.addSubview(progressHUD)
        
        DispatchQueue.global(qos: .background).async {
            self.getDataForList()
            
            DispatchQueue.main.async {
                print("District \(self.place)")
                self.tableView.reloadData()
                progressHUD.hide()
            }
        }
        
        location = "district"
        method = "sm"
        
        let district = ActionButtonItem(title: "District", image: #imageLiteral(resourceName: "place"))
        district.action = { item in self.setLocation(location: "district") }
        
        let municapility = ActionButtonItem(title: "Municipality", image: #imageLiteral(resourceName: "place"))
        municapility.action = { item in self.setLocation(location: "munic") }
        
        actionButton = ActionButton(attachedToView: self.view, items: [district, municapility])
        actionButton.action = { button in button.toggleMenu() }
        //actionButton.setTitle("⌆", forState: UIControlState())
        actionButton.setImage(#imageLiteral(resourceName: "menu-w"), forState: UIControlState())
        
        actionButton.backgroundColor = UIColor.blue
        
    }
    
    private func getDataForList(){
        place.removeAll()
        let url=URL(string: Constants.SM_URL_LIST + location )
        if let data = try? Data(contentsOf: url!){
            do{
                json = try JSONSerialization.jsonObject(with: data, options: [] ) as? Array
            } catch {
                print(error)
            }
            
            for index in 0...json.count-1{
                if let item = json[index] as? [String: AnyObject] {
                    place.append(item["name_en"] as! String)
                }
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showList" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let controller = segue.destination as! TableViewController
                controller.value = place[indexPath.row]
                controller.location = self.location
                controller.method = self.method
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = self.place[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showList", sender: tableView)
    }
    
    
    private func setLocation(location: String){
        self.location = location
        getDataForList()
        self.tableView.reloadData()
        actionButton.toggleMenu()
        
    }
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
            case 0:
                self.method = "sm";
            case 1:
                self.method = "lsp";
            default:
                break; 
        }
        print(method)
    }
}
