//
//  ReminderTable.swift
//  ReminderApp
//
//  Created by Eman on 27/01/2023.
//

import UIKit
import UserNotifications
import CoreData
class ReminderTable: UITableViewController {
    var reminders:[NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound , .badge] , completionHandler: { success , error in
            if success {
            }
            else if let error = error { print( error.localizedDescription)}
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ReminderC")
        do
        {
            reminders = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError {
            print(error)
        }
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reminders.count
    }

    
    @IBSegueAction func addedit(_ coder: NSCoder, sender: Any?) -> ViewController? {
        
        guard let cell = sender as? UITableViewCell, let indexPath =
                             tableView.indexPath(for: cell) else {
                              return nil
                          }
        tableView.deselectRow(at: indexPath, animated: true)

        let screen = ViewController(coder: coder)
      //  screen?.reminder = reminders[indexPath.row]
        
        
        return screen
    }
    
    
    @IBAction func unwind(segue : UIStoryboardSegue){
        guard segue.identifier == "save" else {return}
//            let sourceViewController = segue.source
//               as? ViewController,
//            let rem = sourceViewController.reminder else { return }
//        if let selectedIndexPath = tableView.indexPathForSelectedRow {
//            reminders[selectedIndexPath.row] = rem
//            tableView.reloadRows(at: [selectedIndexPath], with: .none)
//        } else {
//            let newIndexPath = IndexPath(row: reminders.count, section: 0)
//            reminders.append(rem)
//            let contet = UNMutableNotificationContent()
//            contet.title = rem.title
//            contet.sound = .default
//            contet.body = rem.notes
//            let targetDate = Date().addingTimeInterval(10)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year , .month , .day , .hour , .minute , .second], from: targetDate), repeats: false)
//            let request = UNNotificationRequest(identifier: "id", content: contet, trigger: trigger)
//            UNUserNotificationCenter.current().add(request , withCompletionHandler: {error in
//                if error != nil {print(error?.localizedDescription)}
//            })
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
        //}
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ReminderC")
        do
        {
            reminders = try managedContext.fetch(fetchRequest)
            for reminder in reminders {
                           let contet = UNMutableNotificationContent()
                contet.title = reminder.value(forKey: "title") as! String
                         contet.sound = .default
                contet.body = reminder.value(forKey: "note")as! String
                        let targetDate = Date().addingTimeInterval(10)
                          let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year , .month , .day , .hour , .minute , .second], from: targetDate), repeats: false)
                         let request = UNNotificationRequest(identifier: "id", content: contet, trigger: trigger)
                         UNUserNotificationCenter.current().add(request , withCompletionHandler: {error in
                           if error != nil {print(error?.localizedDescription)}
                       })
            }
        }
        catch let error as NSError {
            print(error)
        }
        tableView.reloadData()
        
    }
  
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = reminders[indexPath.row].value(forKey: "title") as! String
        cell.detailTextLabel!.text = reminders[indexPath.row].value(forKey: "note") as! String
        // Configure the cell...

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
