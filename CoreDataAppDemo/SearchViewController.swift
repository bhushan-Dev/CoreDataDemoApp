//
//  SearchViewController.swift
//  CoreDataAppDemo
//
//  Created by Bhushan Udawant on 18/11/18.
//  Copyright © 2018 Bhushan Udawant. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {

    //MARK: Constants

    var listArray: Array<Person>?
    let dateFormatter = DateFormatter()
    var context: NSManagedObjectContext?

    // MARK: IBOutlets

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!

    
    // MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.setShowsCancelButton(false, animated: true)
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
                searchTableView.dataSource = self
                searchTableView.delegate = self
                searchTableView.reloadData()
            }

        } catch let error {
            print(error.localizedDescription)
        }
    }
}


// MARK: Delegates

extension SearchViewController: UITableViewDelegate {
    
}

// MARK: Data source

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
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

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard !(searchBar.text == "") else {
//            return
//        }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        // name == %@ ---->
        fetchRequest.predicate = NSPredicate(format: "name contains[c] %@", searchBar.text!)

        do {
            listArray = try context?.fetch(fetchRequest) as? Array<Person>
            print(listArray?.count)
            searchTableView.reloadData()
        } catch {

        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.resignFirstResponder()
        fetchResult()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

}

