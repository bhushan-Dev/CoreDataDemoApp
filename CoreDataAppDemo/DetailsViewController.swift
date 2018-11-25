//
//  DetailsViewController.swift
//  CoreDataAppDemo
//
//  Created by Bhushan Udawant on 18/11/18.
//  Copyright © 2018 Bhushan Udawant. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateofBirthButton: UIButton!
    @IBOutlet weak var pickerBackgroundView: UIView!

    // MARK: Constant

    let dateFormatter = DateFormatter()
    var person: Person?

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerBackgroundView.isHidden = true

        if let person = person {
            addressTextField.text = person.address
            nameTextField.text = person.name

            dateFormatter.dateFormat = "yyyy-dd-MM"
            let date = (person.dob as Date?)!
            let strDate = dateFormatter.string(from: date)
            dateofBirthButton.setTitle(strDate, for: UIControlState.normal)
        }
    }


    @IBAction func dobPressed(_ sender: UIButton) {
        pickerBackgroundView.isHidden = false
    }

    @IBAction func updateRecord(_ sender: UIButton) {
        pickerBackgroundView.isHidden = true

        if (nameTextField.text?.isEmpty)! {

        } else if (addressTextField.text?.isEmpty)! {

        } else if dateofBirthButton.currentTitle == "DOB" {

        } else {
            // Core Date Execution

            // Create NSManagedObjectContext

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            // Create Entity object i.e NSManagedObject

            //            // if entity was not created  then create (Programaticcally)
            //            let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: context)

            person?.name = nameTextField.text
            person?.address = addressTextField.text
            let strDate = dateofBirthButton.currentTitle
            let date = dateFormatter.date(from: strDate!)
            person?.dob = date! as NSDate

            do {
                try context.save()

                navigationController?.popViewController(animated: true)
            } catch let error {
                print(error.localizedDescription)
            }


        }
    }
    
    @IBAction func doneWithEditingDatePickerr(_ sender: UIButton) {
        pickerBackgroundView.isHidden = true
    }

    @IBAction func setDate(_ sender: UIDatePicker) {
        let data = sender.date

        dateFormatter.dateFormat = "yyyy-dd-MM"
        let strDate = dateFormatter.string(from: data)


        dateofBirthButton.setTitle(strDate, for: UIControlState.normal)
    }
}
