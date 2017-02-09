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
    var arrayCategory : [String] = []
    var arrayElement : [[Element]] = []
    
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
                    let nom = category.element?.attribute(by: "name")?.text

                    arrayCategory.append(nom!)
                    
                    var newArrayElement: [Element] = []
                    
                    for element in category["element"].all{
                        let id = element.element?.attribute(by: "id")?.text
                        let nom = element.element?.attribute(by: "name")?.text
                        let image = element.element?.attribute(by: "image")?.text
                        let description = element.element?.attribute(by: "descr")?.text
                        let imageLarge = element.element?.attribute(by: "image_large")?.text

                        newArrayElement.append(Element(id: String(id!)!, image: image!, nom: nom!, description: description!, imageLarge: imageLarge!))
                    }
                    arrayElement.append(newArrayElement)
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
        return arrayElement[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Element", for: indexPath)
        
        if let labelName = cell.viewWithTag(101) as? UILabel {
            labelName.text = self.arrayElement[indexPath.section][indexPath.row].nom
        }
        else{
            print("Cannot find labelName by tag")
        }
        
        if let imageView = cell.viewWithTag(100) as? UIImageView {
            var url = self.arrayElement[indexPath.section][indexPath.row].image
            imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "Doge"))
        }
        else{
            print("Cannot find imageView by tag")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 86.00/255, green: 86.00/255, blue: 86.00/255, alpha: 1.00)
        
        let label = UILabel()
        
        label.text = (arrayCategory[section])
        label.textColor = UIColor.white
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 45)
        
        view.addSubview(label)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let theWebViewController = WebViewController()
        theWebViewController.element = self.arrayElement[indexPath.section][indexPath.row]
        
        
        navigationController?.pushViewController(theWebViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
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
