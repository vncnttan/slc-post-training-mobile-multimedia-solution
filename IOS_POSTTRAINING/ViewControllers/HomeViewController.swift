//
//  HomeViewController.swift
//  IOS_POSTTRAINING
//
//  Created by prk on 18/08/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfNames = [String]()
    var arrayOfRooms = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentName = arrayOfNames[indexPath.row]
        let currentRoom = arrayOfRooms[indexPath.row]
        
        let currentCell = tableView.dequeueReusableCell(withIdentifier: "BookingCell") as! BookingTableViewCell
        currentCell.nameTxt.text = currentName
        currentCell.roomTxt.text = currentRoom
        
        currentCell.updatehandler = {
            self.updateHandler(cell: currentCell, indexPath: indexPath)
        }
        currentCell.deletehandler = {
            self.deleteHandler(cell: currentCell, indexPath: indexPath)
        }
        
        return currentCell
    }
    
    func updateHandler(cell: BookingTableViewCell, indexPath: IndexPath){
        let oldName = arrayOfNames[indexPath.row]
        let oldRoom = arrayOfRooms[indexPath.row]
        
        let newName = cell.nameTxt.text
        let newRoom = cell.roomTxt.text
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookings")
        request.predicate = NSPredicate(format: "name == %@ AND room == %@", oldName, oldRoom)
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for data in result{
                data.setValue(newName, forKey: "name")
                data.setValue(newRoom, forKey: "room")
            }
            
            try context.save()
            loadData()
            print("Success update data")
        }
        catch {
            print("Failed to update data")
        }
    }
    
    func deleteHandler(cell: BookingTableViewCell, indexPath: IndexPath){
        let oldName = arrayOfNames[indexPath.row]
        let oldRoom = arrayOfRooms[indexPath.row]
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookings")
        request.predicate = NSPredicate(format: "name == %@ AND room == %@", oldName, oldRoom)
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for data in result {
                context.delete(data)
            }
            try context.save()
            loadData()
            print("Delete successful")
        }
        catch {
            print("Delete failed")
        }
    }
    
    
    func loadData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookings")
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            
            arrayOfNames.removeAll()
            arrayOfRooms.removeAll()
            for data in result {
                arrayOfNames.append(data.value(forKey: "name") as! String)
                arrayOfRooms.append(data.value(forKey: "room") as! String)
            }
            
            BookingTV.reloadData()
        }
        catch{
            print("Failed loading data")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext

        // Add this
        BookingTV.delegate = self
        BookingTV.dataSource = self
        loadData()
    }
    

    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var roomTxt: UITextField!
    var context: NSManagedObjectContext!
    
    @IBAction func addBookingBtnOnClick(_ sender: Any) {
        let name = nameTxt.text!
        let room = roomTxt.text!
        
        let entity = NSEntityDescription.entity(forEntityName: "Bookings", in: context)
        
        let newBooking = NSManagedObject(entity: entity!, insertInto: context)
        
        newBooking.setValue(name, forKey: "name")
        newBooking.setValue(room, forKey: "room")
        
        do{
            try context.save()
            nameTxt.text = ""
            roomTxt.text = ""
            loadData()
            print("Insert booking successful")
        }
        catch{
            print("Error inserting booking")
        }
    }
    
    
    @IBOutlet var BookingTV: UITableView!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
