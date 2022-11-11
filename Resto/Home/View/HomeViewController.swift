//
//  ViewController.swift
//  Resto
//
//  Created by David Gomez on 09/11/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: HomeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        setupTableView()
        setupWire()
        viewModel?.fetchRestaurants()
    }
    
    private func setupWire() {
        viewModel?.onSuccess = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }

        viewModel?.onError = { [weak self] (title, message) in
            guard let self = self else { return }
            self.showErrorMessage(title: title, message: message)
        }
        
        viewModel?.onUpdatePhoto = { [weak self] indexPath in
            guard let self = self else { return }
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
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
        
        cell.setupCell(restaurant: restaurant)
        
        viewModel.loadImage(indexPath: indexPath)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func startDownload(for photoRecord: RestaurantModel, at indexPath: IndexPath) {
       
    }
}

