//
//  HomeViewController+TableView.swift
//  Resto
//
//  Created by David Gomez on 12/11/2022.
//

import UIKit

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
