//
//  WebViewController.swift
//  DAM-TD4
//
//  Created by MACIOLEK Sebastian on 09/02/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import UIKit
import SDWebImage

class WebViewController: UIViewController {
    
    var element = Element()
    var webView = UIWebView()
    var imageView = UIImageView()

    override func viewDidLoad(){
        super.viewDidLoad()
        
        if element.imageLarge == ""{
            webView = UIWebView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
            self.webView.isOpaque = false
            self.webView.backgroundColor = UIColor(red: 86.00/255, green: 86.00/255, blue: 86.00/255, alpha: 1.00)
            
            loadWebView(webView: webView)
            
            self.view.addSubview(webView)
        }
        else{
            imageView = UIImageView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
            
            self.view.addSubview(imageView)
            
            imageView.sd_setImage(with: URL(string: element.imageLarge), placeholderImage: UIImage(named: "Doge"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadWebView(webView: UIWebView){
        webView.loadHTMLString(element.description, baseURL: nil)
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
