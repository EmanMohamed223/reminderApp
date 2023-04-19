//
//  ViewController.swift
//  ReminderApp
//
//  Created by Eman on 27/01/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    var reminder : Reminder?
    
    @IBOutlet weak var tittttle: UITextField!
    
    
    @IBOutlet weak var Note: UITextField!
    
    @IBOutlet weak var date: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if reminder == nil {
            self.navigationItem.title = "add new reminder "
        }
        else {
            self.navigationItem.title = "edit reminder "
            
            tittttle.text = reminder?.title
            Note.text = reminder?.notes
            date.date = reminder!.date
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "save" else {return}
        var title = tittttle.text ?? ""
        var note = Note.text ?? ""
        var date = date.date
       //  reminder = Reminder(title: title, notes: note, date: date)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ReminderC", in: managedContext)
        let reminder = NSManagedObject(entity: entity!, insertInto: managedContext)
        reminder.setValue(tittttle.text!, forKey: "title")
        reminder.setValue(Note.text!, forKey: "note")
        reminder.setValue(date, forKey: "date")
       
        do{
            try managedContext.save()
        }catch let error as NSError
        {
            print(error)
        }
    }
    
}





struct Reminder
{
    var title : String
    var notes : String
    var date : Date
    
}
