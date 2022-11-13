//
//  HomeViewController+Views.swift
//  Resto
//
//  Created by David Gomez on 12/11/2022.
//

import UIKit

extension HomeViewController {
    func setupNavigationButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(sortButtonHandler))
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
        ])
    }
    
    func showErrorMessage(title: String, message: String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func presentModal() {
        let alert = UIAlertController(title: "Sort List", message: "Please Select a Sorting Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "By Name", style: .default , handler:{ (UIAlertAction)in
            self.viewModel.sortByName()
        }))
        
        alert.addAction(UIAlertAction(title: "By Rating", style: .default , handler:{ (UIAlertAction)in
            self.viewModel.sortByRating()
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        
        self.present(alert, animated: true)
    }
}
