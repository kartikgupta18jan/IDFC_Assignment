//
//  DatabaseService.swift
//  IDFC ASSIGNMENT


import UIKit
import CoreData
class DatabaseService: NSObject {
      static let appDelegate =  UIApplication.shared.delegate as! AppDelegate
      static let managedContext = appDelegate.persistentContainer.viewContext

    class func fetchPersonList() ->([PersonTable]){
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonTable")
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "PersonTable", in: self.managedContext)
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        do {
            let result = try self.managedContext.fetch(fetchRequest) as? [PersonTable]
            return result!
        } catch {
            _ = error as NSError
            return [PersonTable]()
            
        }
    }

    // MARK: - Insert Person
    class func insertDataIntoPersonTable(first_name:String,last_name:String) -> (flag: Bool, result: String){
        let userEntity = NSEntityDescription.entity(forEntityName: "PersonTable", in: self.managedContext)
        let person :PersonTable = NSManagedObject(entity: userEntity!, insertInto: self.managedContext) as! PersonTable
        
        person.first_name = first_name;
        person.last_name =  last_name;
        do {
            try managedContext.save()
            return (true, "Item added into cart successfully!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return (false,"Item not added into cart")
        }
    }

}

