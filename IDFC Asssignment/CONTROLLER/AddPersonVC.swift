//
//  AddPersonVC.swift
//  IDFC Asssignment
//
//  Created by Mahima Gupta on 11/2/19.
//  Copyright © 2019 Kartik Gupta. All rights reserved.
//

import UIKit

class AddPersonVC: UIViewController {
    @IBOutlet var txtFFirstName : UITextField!
    @IBOutlet var txtFLastName : UITextField!
    var delegatePerson:getPersonData!
    let commonF = CommonFunction()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //Employee Sign In
    @IBAction func btnSubmit(_ sender: UIButton) {
        if txtFFirstName.text?.count != 0 && txtFLastName.text?.count != 0{
            let addPerson  =   DatabaseService.insertDataIntoPersonTable(first_name: txtFFirstName.text ?? "", last_name: txtFLastName.text ?? "")
            if addPerson.flag == true{
                self.view.makeToast(message: ADDED, duration: 1.0, position: HRToastPositionCenter as AnyObject)
                commonF.performAfter(delay: 2) {
                    self.delegatePerson.personListAdd(result: true)
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                self.view.makeToast(message: kWarning, duration: 2.0, position: HRToastPositionCenter as AnyObject)
            }
        }else{
            self.view.makeToast(message: kEMPTY_NAME, duration: 2.0, position: HRToastPositionCenter as AnyObject)
        }
    }
}

protocol getPersonData:class {
    func personListAdd(result: Bool)
}
