//
//  ContactViewController.swift
//  DAM-TD4
//
//  Created by MACIOLEK Sebastian on 06/02/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var outletNom: UITextField!
    @IBOutlet weak var outletPrenom: UITextField!
    @IBOutlet weak var outletEmail: UITextField!
    @IBOutlet weak var outletTelephone: UITextField!
    @IBOutlet weak var outletRappeller: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.outletNom.delegate = self
        self.outletPrenom.delegate = self
        self.outletEmail.delegate = self
        self.outletTelephone.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func actionEnvoyer(_ sender: UIButton) {
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        var statutSwitchRappeler = ""
        if outletRappeller.isOn{
            statutSwitchRappeler = "OUI"
        }
        else{
            statutSwitchRappeler = "NON"
        }
        
        
        let bodyMail = "Nom : " + outletNom.text! + "\nPrénom : " + outletPrenom.text! + "\nEmail : " + outletEmail.text! + "\nTéléphone : " + outletTelephone.text! + "\nMe rappeler : " + statutSwitchRappeler
        
        mailComposerVC.setToRecipients(["se.ba95@icloud.com"])
        mailComposerVC.setSubject("Ma demande de contact")
        mailComposerVC.setMessageBody(bodyMail, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        outletNom.resignFirstResponder()
        outletPrenom.resignFirstResponder()
        outletEmail.resignFirstResponder()
        outletTelephone.resignFirstResponder()
        outletRappeller.resignFirstResponder()
        return true
    }
}
