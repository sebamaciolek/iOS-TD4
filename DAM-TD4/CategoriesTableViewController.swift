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
    var arrayCategory : [Category] = []
    
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
                
                for category in xml["data"]["categories"]["category"].all {
                    let id = category.element?.attribute(by: "id")?.text
                    let nom = category.element?.attribute(by: "name")?.text

                    arrayCategory.append(Category(id: String(id!)!, nom: nom!))
                    print(nom)
                    
                    for element in category["element"].all{
                        let id = element.element?.attribute(by: "id")?.text
                        let nom = element.element?.attribute(by: "name")?.text
                        let image = element.element?.attribute(by: "image")?.text
                        let description = element.element?.attribute(by: "descr")?.text

                        tab.append(Element(id: String(id!)!, image: image!, nom: nom!, description: description!))
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arrayCategory.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tab.count
    }
    
    /*override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return (arrayCategory[section].nom)
        
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var objet = tab[indexPath.row]
        
        var cell = UITableViewCell()
        
        if objet is Category{
            cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
            var categoryCell = objet as! Category
            print(cell)
            
           if let labelName = cell.viewWithTag(1) as? UILabel {
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 86.00/255, green: 86.00/255, blue: 86.00/255, alpha: 1.00)
        
        let label = UILabel()
        
        label.text = (arrayCategory[section].nom)
        label.textColor = UIColor.white
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 45)
        
        view.addSubview(label)
        
        return view
    }

    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
   // override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    /*override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var objet = tab[section]
        
        var cell = UITableViewCell()
        
        if objet is Category{
           // cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: section)
            var categoryCell = objet as! Category
            return (categoryCell.nom)
        } else if objet is Element{
            var elementCell = objet as! Element
            return (elementCell.nom)
        }
        else{
            return "";
        }
        //return (tab[section] as AnyObject).nom
        
    }*/
    
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
