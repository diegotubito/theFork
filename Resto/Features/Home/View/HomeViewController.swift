//
//  ViewController.swift
//  Resto
//
//  Created by David Gomez on 09/11/2022.
//

import UIKit

class HomeViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "RESTAURANT_TITLE".localized
        label.font = UIFont.boldSystemFont(ofSize: 33)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.dataSource = self
        tableview.register(RestaurantCell.self, forCellReuseIdentifier: RestaurantCell.identifier)
        tableview.rowHeight = UITableView.automaticDimension
        tableview.separatorStyle = .none
        tableview.accessibilityIdentifier = "TableViewIdentifier"
        tableview.backgroundColor = .black
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawTitle()
        drawTableView()
        setupWire()
        viewModel.fetchRestaurants()
        setupNavigationButton()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
    }
    
    private func setupWire() {
        viewModel.onError = { [weak self] (title, message) in
            guard let self = self else { return }
            self.showErrorMessage(title: title, message: message)
        }
        
        viewModel.onUpdatePhoto = { [weak self] indexPath in
            guard let self = self else { return }
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        viewModel.onUpdateTableViewList = { [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
        }
    }
    
    @objc func sortButtonHandler() {
        presentModal()
    }
}

extension HomeViewController: RestaurantCellDelegate {
    func heartDidTapped(indexPath: IndexPath) {
        viewModel.setFavourite(indexPath: indexPath)
    }
}
