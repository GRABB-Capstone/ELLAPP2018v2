//
//  ManageClassesViewController.swift
//
//
//  Created by Nick Ponce on 1/18/18.
//

import UIKit

class ManageClassesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var username = String()
    var classes: [String] = []
    
    @IBOutlet weak var MCTitleLabel: UILabel!
    @IBOutlet weak var classTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let backButton = UIBarButtonItem(barButtonSystemItem: .bak, target: <#T##Any?#>, action: <#T##Selector?#>)
        // self.navigationItem.backBarButtonItem
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Tableview Datasource
    
    // Defines number of sections for the table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageClassesTableViewCell", for: indexPath) as? ManageClassesTableViewCell
        // Add cell initialization
        
        return cell!
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
