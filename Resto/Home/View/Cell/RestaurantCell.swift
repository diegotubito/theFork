//
//  RestoTableViewCell.swift
//  Resto
//
//  Created by David Gomez on 09/11/2022.
//

import UIKit

protocol RestaurantCellDelegate: AnyObject {
    func heartDidTapped(indexPath: IndexPath)
}

class RestaurantCell: UITableViewCell {
    
    weak var delegate: RestaurantCellDelegate?
    var indexPath: IndexPath?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var mainImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 1
        imgView.layer.cornerRadius = 10
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        heartButton.frame = CGRect(x: frame.width - 40, y: 0, width: 40, height: 40)
        addSubview(heartButton)
        heartButton.addTarget(self, action: #selector(handler), for: .touchUpInside)
    }
    
    @objc func handler() {
        guard let indexPath = indexPath else { return }
        delegate?.heartDidTapped(indexPath: indexPath)
    }
    
    private func setupView() {
        drawViews()
    }
    
    private func drawViews() {
        addMainContainer()
        addMainStackView()
        addImageView()
        addNameLabel()
        addRatingLabel()
        addAddressLabel()
        addSeparator()
    }
    
    func setupCell(restaurant: RestaurantModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        mainImageView.image = nil
        if let imageData = restaurant.imageData {
            mainImageView.image = UIImage(data: imageData)
        }
        nameLabel.text = restaurant.name
        ratingLabel.text = "RATE".localized + " ✭ " + String(restaurant.aggregateRatings.thefork.ratingValue)
        let isFavourite = restaurant.isFavourite ?? false
        heartButton.setImage(UIImage(named: isFavourite ? "filled-heart" : "empty-heart"), for: .normal)
        adressLabel.text = restaurant.address.street
    }
    
}

