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
        addAddressLabel()
        addSeparator()
    }
    
    func setupCell(restaurant: RestaurantModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        mainImageView.image = nil
        if let imageData = restaurant.imageData {
            mainImageView.image = UIImage(data: imageData)
        }
        nameLabel.text = restaurant.name + " ✭" + String(restaurant.aggregateRatings.thefork.ratingValue)
        let isFavourite = restaurant.isFavourite ?? false
        heartButton.setImage(UIImage(named: isFavourite ? "filled-heart" : "empty-heart"), for: .normal)
        adressLabel.text = restaurant.address.street
    }
    
}

// DRAW VIEW
extension RestaurantCell {
    private func addMainContainer() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
          //  containerView.heightAnchor.constraint(equalToConstant: 250)
            
        ])
    }
    
    private func addMainStackView() {
        containerView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
        ])
    }
    
    private func addImageView() {
        let widthProportional: CGFloat = 0.8
        let aspectRatio: CGFloat = 0.56
        let imageWidth: CGFloat = (UIScreen.main.bounds.size.width * widthProportional)
        let imageHeight: CGFloat = imageWidth * aspectRatio
        stackView.addArrangedSubview(mainImageView)
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            mainImageView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            mainImageView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
        ])
    }
    
    private func addNameLabel() {
        let secondaryStackView = UIStackView()
        secondaryStackView.distribution = .fill
        secondaryStackView.axis = .horizontal
        secondaryStackView.spacing = 8
        
        
        stackView.addArrangedSubview(secondaryStackView)
        NSLayoutConstraint.activate([
            secondaryStackView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            secondaryStackView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0)
        ])
        
        
        secondaryStackView.addArrangedSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: secondaryStackView.topAnchor, constant: 0),
            nameLabel.bottomAnchor.constraint(equalTo: secondaryStackView.bottomAnchor, constant: 0)
        ])
       
        
    }
    
    private func addAddressLabel() {
        stackView.addArrangedSubview(adressLabel)
        NSLayoutConstraint.activate([
            adressLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            adressLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0)
        ])
    }
    
    private func addSeparator() {
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
