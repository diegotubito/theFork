//
//  ViewController.swift
//  Resto
//
//  Created by David Gomez on 09/11/2022.
//

import UIKit

class HomeViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(RestaurantCell.self, forCellReuseIdentifier: "cell")
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100
        tableview.separatorStyle = .none
      
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
        setupTableView()
        setupWire()
        viewModel.fetchRestaurants()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(sortButtonHandler))
    }
    
    @objc func sortButtonHandler() {
        presentModal()
    }
    
    private func presentModal() {
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

    private func setupTableView() {
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
    
    private func showErrorMessage(title: String, message: String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RestaurantCell else {
            return UITableViewCell()
        }
        let restaurant = viewModel.model.restaurants[indexPath.row]
        cell.setupCell(restaurant: restaurant, indexPath: indexPath)
        cell.delegate = self
        viewModel.loadImage(indexPath: indexPath)
       
        return cell
    }
    
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func startDownload(for photoRecord: RestaurantModel, at indexPath: IndexPath) {
       
    }
}

extension HomeViewController: RestaurantCellDelegate {
    func heartDidTapped(indexPath: IndexPath) {
        viewModel.setFavourite(indexPath: indexPath)
    }
}
