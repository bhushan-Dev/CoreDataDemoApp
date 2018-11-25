//
//  ListViewController.swift
//  CoreDataAppDemo
//
//  Created by Bhushan Udawant on 17/11/18.
//  Copyright © 2018 Bhushan Udawant. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    //MARK: Constants

    var listArray: Array<Person>?
    let dateFormatter = DateFormatter()
    var context: NSManagedObjectContext?

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext

        // Fetch database result
        fetchResult()
    }

    // MARK: Helpers

    func fetchResult() {
        // Create obj of fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")

        // List data
        do {
            listArray = try context?.fetch(fetchRequest) as? Array<Person>
            print(listArray?.count)

            if let listArray = listArray,
                listArray.count > 0 {
                tableView.dataSource = self
                tableView.delegate = self
                tableView.reloadData()
            }

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

// MARK: Delegates

extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {

            if let context = context,
                let _ = listArray {
                context.delete(listArray![indexPath.row])
                do {
                    try context.save()
                    listArray!.remove(at: indexPath.row)
                    print(listArray?.count)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    //tableView.reloadData()
                }catch let error {
                    print(error)
                }

            //    tableView.deleteRows(at: [indexPath], with: .automatic)

            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = listArray {
            let detailsViewController: DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            detailsViewController.person = listArray![indexPath.row]

            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}

// MARK: Data source

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PersonCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PersonCellTableViewCell
        //let cell = UITableViewCell()

        if let listArray = listArray {
            let person = listArray[indexPath.row]
            print(person)
            cell.nameLbl.text = person.name
            cell.addressLbl.text = person.address

            dateFormatter.dateFormat = "yyyy-dd-MM"
            let strDate = dateFormatter.string(from: (person.dob as Date?)!)
            cell.dateLbl.text = strDate

        }

        return cell
    }
}
