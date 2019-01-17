//
//  ViewController.swift
//  SearchBarTest
//
//  Created by Taco Kind on 17/01/2019.
//  Copyright © 2019 Taco Kind. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    lazy var data: [String] = {
        var items = (0..<20).map { "Item \($0)" }
        items[2] = "Search Bar does not hide with a few data items."
        items[3] = "Please, press Toggle data."

        items[6] = "... but now it can. "

        items[7] = "- How can this be fixed?"
        items[8] = "- How to hide it programmatically?"
        items[9] = "- How to avoid the ugly stuttered animations?"
        items[10] = "- Pressing just below the statusbar will show the SearchBar with an undesired inset above the table view."
        return items
    }()

    var numberOfItemsToDisplay: Int = 5

    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        searchController.searchBar.tintColor = .black
        searchController.searchBar.backgroundColor = .green
        searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchController.searchBar.isTranslucent = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self

        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = true
        }

        view.backgroundColor = UIColor.white
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isUserInteractionEnabled = true
        tableView.rowHeight = 44
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInsetAdjustmentBehavior = .never
        let emptyView = UIView()
        emptyView.tintColor = UIColor.clear
        tableView.tableFooterView = emptyView
        view.addSubview(self.tableView)

        navigationItem.title = "SearchBarTest"

        //
        // Navigation Bar
        //
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .green
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blue
        ]
        navigationController?.navigationBar.tintColor = .red

        let toggleButton = UIBarButtonItem(title: "Toggle data", style: .plain, target: self, action: #selector(ViewController.toggleItemsToDisplay(_:)))
        navigationItem.setRightBarButton(toggleButton, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Constraints
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    ////////////////////////////////////////////////////////////////////////////
    // MARK: - Actions
    ////////////////////////////////////////////////////////////////////////////

    @objc public func toggleItemsToDisplay(_ sender: AnyObject) {
        if numberOfItemsToDisplay < 20 {
            numberOfItemsToDisplay = 20
        } else {
            numberOfItemsToDisplay = 5
        }
        tableView.reloadData()
    }



    ////////////////////////////////////////////////////////////////////////////
    // MARK: - Table view data source
    ////////////////////////////////////////////////////////////////////////////

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[0..<numberOfItemsToDisplay].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .left
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }


    public func updateSearchResults(for searchController: UISearchController) {

        // update search
    }

}

