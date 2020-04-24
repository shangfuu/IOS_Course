//
//  ViewController.swift
//  0422-CoreData
//
//  Created by mac07 on 2020/4/22.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let app = UIApplication.shared.delegate as! AppDelegate
    var viewContext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewContext = app.persistentContainer.viewContext
        print(NSPersistentContainer.defaultDirectoryURL())
        deleteAllUserData()
        // insertUserData()
        // queryAllUserData()
        // queryWithPredicate()
        /* One to Many */
        insert_onetoMany()
        query_onetoMany()
    }
    
    
    func insert_onetoMany(){
        let user = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: viewContext) as! UserData
        user.cid = "M10955933"
        user.cname = "Jack"
        
        var car = NSEntityDescription.insertNewObject(forEntityName: "Car", into: viewContext) as! Car
        car.plate = "811-MYG"
        user.addToOwn(car)
        
        car = NSEntityDescription.insertNewObject(forEntityName: "Car", into: viewContext) as! Car
        car.plate = "BBT-9088"
        user.addToOwn(car)
        app.saveContext()
    }
    
    func query_onetoMany(){
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        let predicate = NSPredicate(format: "cid like 'M10955933'")
        fetchRequest.predicate = predicate
        
        do{
            let allUsers = try viewContext.fetch(fetchRequest)
            for user in allUsers{
                if user.own == nil{
                    print("\((user.cname)!), No car")
                }
                else {
                    print("\((user.cname)!) has \((user.own?.count)!) car")
                    for car in user.own as! Set<Car>{
                        print("Car number \((car.plate)!)")
                    }
                }
            }
        } catch{
            print(error)
        }
    }
    
    
    func insertUserData(){
        var user = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: viewContext) as! UserData
        user.cid = "B10615045"
        user.cname = "Shung"
        
        user = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: viewContext) as! UserData
        user.cid = "M10815066"
        user.cname = "Evan"
        
        user = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: viewContext) as! UserData
        user.cid = "M10815069"
        user.cname = "Elen"
        
        user = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: viewContext) as! UserData
        user.cid = "M10815099"
        user.cname = "Ellie"
        
        app.saveContext()
    }
    
    func queryAllUserData(){
        do{
            let allUsers = try viewContext.fetch(UserData.fetchRequest())
            for user in allUsers as! [UserData]{
                print("\((user.cid)!),\((user.cname)!)")
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAllUserData() {
        do {
            let allUsers = try viewContext.fetch(UserData.fetchRequest())
            for user in allUsers as! [UserData]{
                viewContext.delete(user)
            }
            app.saveContext()
            print("Successful delete")
        } catch {
            print(error)
        }
    }
    
    func queryWithPredicate() {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        let predicate = NSPredicate(format: "cname like 'E*'")
        fetchRequest.predicate = predicate
        let sort = NSSortDescriptor(key: "cid", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do{
            let allUsers = try viewContext.fetch(fetchRequest)
            for user in allUsers{
                print("\((user.cid)!),\((user.cname)!)")
            }
        } catch {
                print(error)
        }
    }

}

