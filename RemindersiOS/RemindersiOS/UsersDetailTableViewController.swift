//
//  UsersDetailTableViewController.swift
//  RemindersiOS
//
//  Created by Tim Condon on 02/04/2019.
//  Copyright © 2019 Tim Condon. All rights reserved.
//

import UIKit

class UsersDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            updateUserView()
        }
    }
    
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var usernameTextLabel: UILabel!
    @IBOutlet weak var statusTextField: UITextField!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func updateUserView() {
        DispatchQueue.main.async { [weak self] in
            self?.nameTextLabel.text = self?.user?.name
            self?.usernameTextLabel.text = self?.user?.username
            self?.statusTextField.text = self?.user?.status
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func updateUser(_ sender: UIBarButtonItem) {
        guard let userID = user?.id, let name = user?.name, let username = user?.username, let status = statusTextField.text else {
            return
        }
        
        let updatedUser = User(id: userID, name: name, username: username, status: status)

        let userRequest = UserRequest(userID: userID)
        userRequest.update(with: updatedUser) { result in
            switch result {
            case .failure:
                ErrorPresenter.showError(message: "There was an error updating the user", on: self)
            case .success(let newUser):
                self.user = newUser
            }
            
        }
    }
}
