//
//  FirstViewController.swift
//  RemindersiOS
//
//  Created by Tim Condon on 02/04/2019.
//  Copyright © 2019 Tim Condon. All rights reserved.
//

import UIKit
import RemindersCore

class RemindersTableViewController: UITableViewController {

    // MARK: - Properties
    var reminders: [Reminder] = []
    let remindersRequest = ResourceRequest<Reminder>(resourcePath: "reminders")
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh(nil)
    }
    
    // MARK: - IBActions
    @IBAction func refresh(_ sender: UIRefreshControl?) {
        remindersRequest.getAll { [weak self] result in
            DispatchQueue.main.async {
                sender?.endRefreshing()
            }
            switch result {
            case .failure:
                ErrorPresenter.showError(message: "There was an error getting the reminders", on: self)
            case .success(let reminders):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.reminders = reminders
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension RemindersTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminder = reminders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        cell.textLabel?.text = reminder.title
        return cell
    }
}
