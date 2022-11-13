//
//  HomeViewController+Views.swift
//  Resto
//
//  Created by David Gomez on 12/11/2022.
//

import UIKit

extension HomeViewController {
    func setupNavigationButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "SORT_IMAGE_NAME".localized),
                                                            landscapeImagePhone: nil,
                                                            style: .plain, target: self,
                                                            action: #selector(sortButtonHandler))
    }
    
    func drawTitle() {
        view.addSubview(titleLabel)
        
        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
        ])
    }

    func drawTableView() {
        view.addSubview(tableView)
        
        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
        ])
    }
    
    
    func showErrorMessage(title: String, message: String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK_OPTION".localized, style: .default, handler: { (action) -> Void in
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func presentModal() {
        let alert = UIAlertController(title: "SORT_OPTION_TITLE".localized, message: "SORT_OPTION_SUBTITLE".localized, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "SORT_OPTION_NAME".localized, style: .default , handler:{ (UIAlertAction)in
            self.viewModel.sortByName()
        }))
        
        alert.addAction(UIAlertAction(title: "SORT_OPTION_RATE".localized, style: .default , handler:{ (UIAlertAction)in
            self.viewModel.sortByRating()
        }))
        
        alert.addAction(UIAlertAction(title: "DISMISS_OPTION".localized, style: .cancel))
        
        self.present(alert, animated: true)
    }
}
