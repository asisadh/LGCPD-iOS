//
//  DetailViewController.swift
//  LGCPD
//
//  Created by Aashish Adhikari on 12/10/16.
//  Copyright © 2016 Aashish Adhikari. All rights reserved.
//

import UIKit

struct DetailSM{
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

struct DetailLSP{
    var name: String
    var address: String
    var officePhone: String
    var contactPerson: String
    var chairman: String
    var contactEmail: String
    var contactPhone: String
    var contactMobile: String
    var chairmanMobile: String
    var chairmanEmail: String
    var remarks: String
    
}

class DetailViewController: UIViewController {
    
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
    var method: String!
 
    var detailSM: DetailSM?
    var detailLSP: DetailLSP?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Spinner
        let progressHUD = ProgressHUD(text: "Loading Data")
        self.view.addSubview(progressHUD)
        
        DispatchQueue.global(qos: .background).async {
            self.getDataForDetail()
            
            DispatchQueue.main.async {
                if self.method == "sm" {
                    self.setLabelSM()
                }
                else{
                    self.setLabelLSP()
                }
               
                progressHUD.hide()
            }
        }
    }
    
    private func getDataForDetail(){
        
        if method == "sm" {
            populateSM()
        }
        else{
            populateLSP()
        }
        
    }
    
    private func populateSM(){
        
        let url=URL(string: Constants.SM_DETAIL_API + id)
        do {
            let data = try Data(contentsOf: url!)
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            print (json["name"])
            detailSM = DetailSM(name: json["name"] as! String,
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
    
    private func populateLSP(){
        
        let url=URL(string: Constants.LSP_DETAIL_API + id)
        do {
            let data = try Data(contentsOf: url!)
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
            detailLSP = DetailLSP(name: json["name"] as! String,
                                  address: json["address"] as! String,
                                  officePhone: json["office_phone"] as! String,
                                  contactPerson: json["contact_person"] as! String,
                                  chairman: json["chairman"] as! String,
                                  contactEmail: json["contact_email"] as! String,
                                  contactPhone: json["contact_phone"] as! String,
                                  contactMobile: json["contact_mobile"] as! String,
                                  chairmanMobile: json["chairman_mobile"] as! String,
                                  chairmanEmail: json["chairman_email"] as! String,
                                  remarks: json["remarks"] as! String
            )
        }
        catch {
            
        }
    
    }
    
    private func setLabelSM(){
        var s = ""
        
        self.name.text = self.detailSM?.name
        
        s = "Address: " + (self.detailSM?.address)!
        self.address.text = s
        
        s = "Email: " + (self.detailSM?.email)!
        self.email.text = s
        
        s = "Phone: " + (self.detailSM?.phone)!
        self.phone.text = s
        
        s = "LSP: " + (self.detailSM?.lsp)!
        self.lsp.text = s
        
        s = "Hired: " + (self.detailSM?.hired)!
        self.hired.text = s
        
        s = "VDC: " + (self.detailSM?.vdc)!
        self.vdc.text = s
        
        s = "Sex: " + (self.detailSM?.sex)!
        self.sex.text = s
        
        s = "Dalit: " + (self.detailSM?.dalit)!
        self.dalit.text = s
        
        s = "Janajati: " + (self.detailSM?.janajati)!
        self.janajati.text = s
        
        s = "Dag: " + (self.detailSM?.dag)!
        self.dag.text = s
        
        s = "Education: " + (self.detailSM?.education)!
        self.education.text = s
        
        s = "Work Experience: " + (self.detailSM?.workExperience)!
        self.workExperience.text = s
        
        s = "Belong To: " + (self.detailSM?.belongTo)!
        self.belongTo.text = s
        
        
        s = "Training: " + (self.detailSM?.training)!
        self.training.text = s
        
        s = "Remark: " + (self.detailSM?.remark)!
        self.remark.text = s
        
    }
    
    private func setLabelLSP(){
        var s = ""
        
        self.name.text = self.detailLSP?.name
        
        s = "Address: " + (self.detailLSP?.address)!
        self.address.text = s
        
        s = "Office Phone: " + (self.detailLSP?.officePhone)!
        self.email.text = s
        
        s = "Contact Person: " + (self.detailLSP?.contactPerson)!
        self.phone.text = s
        
        s = "Contact Phone: " + (self.detailLSP?.contactPhone)!
        self.lsp.text = s
        
        s = "Contact Mobile: " + (self.detailLSP?.contactMobile)!
        self.hired.text = s
        
        s = "Contact Email: " + (self.detailLSP?.contactEmail)!
        self.vdc.text = s
        
        s = "Chairman " + (self.detailLSP?.chairman)!
        self.sex.text = s
        
        s = "Chairman Mobile: " + (self.detailLSP?.chairmanEmail)!
        self.dalit.text = s
        
        s = "Chairman Email: " + (self.detailLSP?.chairmanEmail)!
        self.janajati.text = s
        
        s = ""
        self.dag.text = s
        
        s = ""
        self.education.text = s
        
        s = ""
        self.workExperience.text = s
        
        s = ""
        self.belongTo.text = s
        
        
        s = ""
        self.training.text = s
        
        s = "Remark: " + (self.detailLSP?.remarks)!
        self.remark.text = s
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
