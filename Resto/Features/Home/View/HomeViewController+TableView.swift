//
//  HomeViewController+TableView.swift
//  Resto
//
//  Created by David Gomez on 12/11/2022.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.identifier, for: indexPath) as? RestaurantCell else {
            return UITableViewCell()
        }
        let restaurant = viewModel.model.restaurants[indexPath.row]
        cell.setupCell(restaurant: restaurant, indexPath: indexPath)
        cell.delegate = self
        viewModel.loadImage(indexPath: indexPath)
        
        return cell
    }
}
