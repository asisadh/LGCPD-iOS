//
//  DetailViewController.swift
//  LGCPD
//
//  Created by Aashish Adhikari on 12/10/16.
//  Copyright © 2016 Aashish Adhikari. All rights reserved.
//

import UIKit

struct Details{
    var name: String
    var address: String
    var email: String
    var phone: String
    var lsp: String
    var hired: String
    var vdc: String
    var sex: String
    var dalit: String
    var janajati: String
    var dag: String
    var education: String
    var workExperience: String
    var belongTo: String
    var training: String
    var remark: String
}

class DetailViewController: UIViewController {
    
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)


    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var lsp: UILabel!
    @IBOutlet weak var hired: UILabel!
    @IBOutlet weak var vdc: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var dalit: UILabel!
    @IBOutlet weak var janajati: UILabel!
    @IBOutlet weak var dag: UILabel!
    @IBOutlet weak var education: UILabel!
    @IBOutlet weak var workExperience: UILabel!
    @IBOutlet weak var belongTo: UILabel!
    @IBOutlet weak var training: UILabel!
    @IBOutlet weak var remark: UILabel!
    
    var id: String!
 
    var details: Details?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Spinner
        indicator.color = UIColor.black
        indicator.frame = CGRect(origin: CGPoint.init(x: 0, y: 0), size: CGSize(width: 10, height: 10) )
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.bringSubview(toFront: view)
        indicator.startAnimating()
        
        DispatchQueue.global(qos: .background).async {
            self.getDataForDetail()
            
            DispatchQueue.main.async {
               self.setLabel()            }
        }
      
        self.indicator.stopAnimating()
        self.indicator.hidesWhenStopped = true

    }
    
    private func getDataForDetail(){
        
        let url=URL(string: Constants.SM_DETAIL_API + id)
        do {
            let data = try Data(contentsOf: url!)
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            print (json["name"])
            details = Details(name: json["name"] as! String,
                    address: json["address"] as! String,
                    email: json["email"] as! String,
                    phone: json["phone"] as! String,
                    lsp: json["lsp_id"] as! String,
                    hired: json["hired"] as! String,
                    vdc: json["vdc"] as! String,
                    sex: json["sex"] as! String,
                    dalit: json["dalit"] as! String,
                    janajati: json["janajati"] as! String,
                    dag: json["dag"] as! String,
                    education: json["education"] as! String,
                    workExperience: json["work_experience"] as! String,
                    belongTo: json["belong_to"] as! String,
                    training: json["training"] as! String,
                    remark: json["remarks"] as! String
            )
            
        }
        catch {
            
        }
        
    }
    
    private func setLabel(){
        var s = ""
        
        self.name.text = self.details?.name
        
        s = "Address: " + (self.details?.address)!
        self.address.text = s
        
        s = "Email: " + (self.details?.email)!
        self.email.text = s
        
        s = "Phone: " + (self.details?.phone)!
        self.phone.text = s
        
        s = "LSP: " + (self.details?.lsp)!
        self.lsp.text = s
        
        s = "Hired: " + (self.details?.hired)!
        self.hired.text = s
        
        s = "VDC: " + (self.details?.vdc)!
        self.vdc.text = s
        
        s = "Sex: " + (self.details?.sex)!
        self.sex.text = s
        
        s = "Dalit: " + (self.details?.dalit)!
        self.dalit.text = s
        
        s = "Janajati: " + (self.details?.janajati)!
        self.janajati.text = s
        
        s = "Dag: " + (self.details?.dag)!
        self.dag.text = s
        
        s = "Education: " + (self.details?.education)!
        self.education.text = s
        
        s = "Work Experience: " + (self.details?.workExperience)!
        self.workExperience.text = s
        
        s = "Belong To: " + (self.details?.belongTo)!
        self.belongTo.text = s
        
        
        s = "Training: " + (self.details?.training)!
        self.training.text = s
        
        s = "Remark: " + (self.details?.remark)!
        self.remark.text = s
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
