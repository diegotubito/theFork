//
//  RestaurantCell+Views.swift
//  Resto
//
//  Created by David Gomez on 12/11/2022.
//

import UIKit

extension RestaurantCell {
    func addMainContainer() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
    
    func addMainStackView() {
        containerView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
        ])
    }
    
    func addImageView() {
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
    
    func addNameLabel() {
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
    
    func addAddressLabel() {
        stackView.addArrangedSubview(adressLabel)
        NSLayoutConstraint.activate([
            adressLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            adressLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0)
        ])
    }
    
    func addRatingLabel() {
        stackView.addArrangedSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            ratingLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0)
        ])
    }
    
    func addSeparator() {
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
