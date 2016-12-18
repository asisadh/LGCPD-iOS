//
//  OfflineListViewController.swift
//  LGCPD
//
//  Created by Aashish Adhikari on 12/17/16.
//  Copyright © 2016 Aashish Adhikari. All rights reserved.
//

import UIKit
import CoreData

class OfflineListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getData () {
//        //create a fetch request, telling it about the entity
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = LGCPD.fetchRequest()
//        
//        do {
//            //go get the results
//            let searchResults = try getContext().fetch(fetchRequest)
//            
//            //I like to check the size of the returned results!
//            print ("num of results = \(searchResults.count)")
//            
//            //You need to convert to NSManagedObject to use 'for' loops
//            
//        } catch {
//            print("Error with request: \(error)")
//        }
    }

}
