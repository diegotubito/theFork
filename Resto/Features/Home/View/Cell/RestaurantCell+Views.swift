//
//  RestaurantCell+Views.swift
//  Resto
//
//  Created by David Gomez on 12/11/2022.
//

import UIKit

extension RestaurantCell {
    struct Constants {
        static let topMargins: CGFloat = 16
        static let bottomMargins: CGFloat = 16
        static let separatorHeight: CGFloat = 1
        static let stackSpacing: CGFloat = 4
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
        static let frameSide: CGFloat = 40
        static let maximumNumberOfLines: Int = 2
        static let titleSize: CGFloat = 15
        static let subTitleSize: CGFloat = 12
        static let aspectRatio: CGFloat = 0.5
    }
    
    func addMainContainer() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func addMainStackView() {
        containerView.addSubview(separatorView)
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            separatorView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            separatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.bottomMargins),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorHeight),
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.topMargins),
            stackView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -Constants.bottomMargins),
        ])
    }
    
    func addImageView() {
        let aspectRatio: CGFloat = Constants.aspectRatio
        let imageWidth: CGFloat = UIScreen.main.bounds.size.width
        let imageHeight: CGFloat = imageWidth * aspectRatio
        stackView.addArrangedSubview(mainImageView)
        
        let defaultHeight = mainImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        portraitHeightConstraint = mainImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        landscapeHeightConstraint = mainImageView.heightAnchor.constraint(equalToConstant: imageWidth)
        landscapeHeightConstraint?.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            portraitHeightConstraint ?? defaultHeight,
            landscapeHeightConstraint ?? defaultHeight,
            mainImageView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            mainImageView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
        ])
    }
    
    func addNameLabel() {
        let secondaryStackView = UIStackView()
        secondaryStackView.distribution = .fill
        secondaryStackView.axis = .horizontal
        secondaryStackView.spacing = Constants.stackSpacing
        
        stackView.addArrangedSubview(secondaryStackView)
        NSLayoutConstraint.activate([
            secondaryStackView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            secondaryStackView.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
        
        secondaryStackView.addArrangedSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: secondaryStackView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: secondaryStackView.bottomAnchor)
        ])
    }
    
    func addAddressLabel() {
        stackView.addArrangedSubview(adressLabel)
        NSLayoutConstraint.activate([
            adressLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            adressLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
    }
    
    func addRatingLabel() {
        stackView.addArrangedSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            ratingLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
    }
}
