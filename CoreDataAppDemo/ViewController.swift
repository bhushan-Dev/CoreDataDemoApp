//
//  ViewController.swift
//  CoreDataAppDemo
//
//  Created by Bhushan Udawant on 17/11/18.
//  Copyright © 2018 Bhushan Udawant. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // MARK: Constant

    let dateFormatter = DateFormatter()

    // MARK: IBOutlets

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var dobButton: UIButton!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var pickerBackgroundView: UIView!
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: IBAction

    @IBAction func dobPressed(_ sender: UIButton) {
        pickerBackgroundView.isHidden = false
    }

    @IBAction func savePressed(_ sender: UIButton) {
        nameField.resignFirstResponder()
        addressField.resignFirstResponder()
        pickerBackgroundView.isHidden = true

        if (nameField.text?.isEmpty)! {

        } else if (addressField.text?.isEmpty)! {

        } else if dobButton.currentTitle == "DOB" {

        } else {
            // Core Date Execution

            // Create NSManagedObjectContext

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            // Create Entity object i.e NSManagedObject

//            // if entity was not created  then create (Programaticcally)
//            let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: context)


            let personEntityObject = Person(context: context)
            personEntityObject.name = nameField.text
            personEntityObject.address = addressField.text
            let strDate = dobButton.currentTitle
            let date = dateFormatter.date(from: strDate!)
            personEntityObject.dob = date! as NSDate

            do {
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }

            nameField.text = ""
            addressField.text = ""
            dobButton.setTitle("DOB", for: .normal)

        }

    }

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let data = sender.date

        dateFormatter.dateFormat = "yyyy-dd-MM"
        let strDate = dateFormatter.string(from: data)


        dobButton.setTitle(strDate, for: UIControlState.normal)
    }

    @IBAction func doneButtonTappedd(_ sender: UIButton) {
        pickerBackgroundView.isHidden = true
    }
}

