//
//  PersonListVC.swift
//  IDFC Asssignment
//
//  Created by Mahima Gupta on 11/2/19.
//  Copyright © 2019 Kartik Gupta. All rights reserved.
//

import UIKit

class PersonListVC: UIViewController, UITableViewDataSource, UITableViewDelegate,getPersonData {
    @IBOutlet var tblList : UITableView!
    @IBOutlet var lblNodata : UILabel!
    var person = [PersonTable]()
    var arrPersonList:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PersonData()
        tblList.estimatedRowHeight = 89
        tblList.rowHeight = UITableView.automaticDimension
        tblList.register(UINib(nibName: "PersonListTVCell", bundle: nil), forCellReuseIdentifier: "PersonListTVCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(self.btnAddPerson) )
    }
    @objc func btnAddPerson(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddPersonVC") as? AddPersonVC
        vc?.delegatePerson = self
        self.navigationController?.pushViewController(vc ?? AddPersonVC(), animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPersonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PersonListTVCell = tblList.dequeueReusableCell(withIdentifier: "PersonListTVCell") as! PersonListTVCell
        let data = arrPersonList[indexPath.row]
        cell.lblName.text = "\(data)"
        return cell
    }
    
    func PersonData(){
        if DatabaseService.fetchPersonList().count != 0{
            lblNodata.isHidden = true
            self.person = DatabaseService.fetchPersonList()
            arrPersonList = [String]()
            if person.count != 0{
                for name in 0..<self.person.count{
                    arrPersonList.append("\(self.person[name].first_name ?? "") \(self.person[name].last_name ?? "")")
                }
            }else{
                lblNodata?.isHidden = false
            }
        }else{
            lblNodata.isHidden = false
        }
        tblList.delegate = self
        tblList.dataSource = self
        tblList.reloadData()
    }
    func personListAdd(result: Bool){
        self.PersonData()
    }
}

