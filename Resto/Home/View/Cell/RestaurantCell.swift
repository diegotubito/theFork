//
//  RestoTableViewCell.swift
//  Resto
//
//  Created by David Gomez on 09/11/2022.
//

import UIKit

class RestaurantCell: UITableViewCell {
    var buttonTapCallback: () -> () = { }
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "filled-heart"), for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(heartButtonHandler(_:)))
        button.addGestureRecognizer(tap)
        button.layer.zPosition = 100
        return button
    }()
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
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
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
    
    func setupCell(restaurant: RestaurantModel) {
        mainImageView.image = nil
        if let imageData = restaurant.imageData {
            mainImageView.image = UIImage(data: imageData)
        }
        nameLabel.text = restaurant.name + " ✭" + String(restaurant.aggregateRatings.thefork.ratingValue)
        adressLabel.text = restaurant.address.street
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @objc func heartButtonHandler(_ sender: UIButton) {
        print("button tapped")
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
        
        secondaryStackView.addArrangedSubview(heartButton)
        
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: secondaryStackView.topAnchor, constant: 0),
            heartButton.bottomAnchor.constraint(equalTo: secondaryStackView.bottomAnchor, constant: 0),
            heartButton.widthAnchor.constraint(equalToConstant: 50)
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
