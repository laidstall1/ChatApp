//
//  ProfileController.swift
//  ChatApp
//
//  Created by mac on 02/08/2021.
//

import UIKit

private let reuseIdentifier = "ProfileCell"

class ProfileController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView: UITableView = UITableView()
    
    private lazy var headerView: ProfileHeader = {
        return ProfileHeader(frame: .init(x: 0, y: 0,
                                           width: view.frame.width,
                                           height: 380))
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        headerView.dismissDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - Helpers
    
    fileprivate func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.tableHeaderView = headerView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func configureUI() {
        view.backgroundColor = .blue
        configureTableView()
    }
}

extension ProfileController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }


   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

extension ProfileController: DismissControllerProtocol {
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//
//
//
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }


