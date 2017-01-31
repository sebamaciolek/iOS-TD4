//
//  CategoriesTableViewController.swift
//  DAM-TD4
//
//  Created by MACIOLEK Sebastian on 30/01/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import UIKit
import SWXMLHash
import SDWebImage

class CategoriesTableViewController: UITableViewController {
    
    //var xml = SWXMLHash.parse("")
    var tab = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        if let url = URL(string: "http://fairmont.lanoosphere.com/mobile/getdata?lang=en")
        {
            do{
                let data = try Data(contentsOf: url)
                let xml = SWXMLHash.parse(String(data: data, encoding: .utf8)!)
                
                for elem in xml["data"]["categories"]["category"].all {
                    let id = elem.element?.attribute(by: "id")?.text
                    let nom = elem.element?.attribute(by: "name")?.text
                    
                    tab.append(Category(id: Int(id!)!, nom: nom!))
                    
                    for elem2 in elem["element"].all{
                        let id = elem2.element?.attribute(by: "id")?.text
                        let nom = elem2.element?.attribute(by: "name")?.text
                        let image = elem2.element?.attribute(by: "image")?.text
                        let description = elem2.element?.attribute(by: "descr")?.text
                        
                        tab.append(Element(id: Int(id!)!, image: image!, nom: nom!, description: description!))
                    }  
                }

            }
            catch{
                print("error retrieving file")
            }
        }
        else{
            print("not an URL")
        }
                print(tab)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tab.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var objet = tab[indexPath.row]
        
        var cell = UITableViewCell()
        
        if objet is Category{
            cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
            var categoryCell = objet as! Category
            
            if let labelName = cell.viewWithTag(101) as? UILabel {
                labelName.text = categoryCell.nom
            }

            if let imageView = cell.viewWithTag(100) as? UIImageView {
                imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
            }
            
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "Element", for: indexPath)
            var elementCell = objet as! Element
            
            if let labelName = cell.viewWithTag(102) as? UILabel {
                labelName.text = elementCell.nom
                
            }
            
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
