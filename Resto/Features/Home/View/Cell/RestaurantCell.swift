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
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var portraitHeightConstraint: NSLayoutConstraint?
    var landscapeHeightConstraint: NSLayoutConstraint?

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Constants.stackSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = Constants.maximumNumberOfLines
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Constants.subTitleSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Constants.subTitleSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var mainImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = Constants.borderWidth
        imgView.layer.cornerRadius = Constants.cornerRadius
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = Constants.cornerRadius
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
        heartButton.frame = CGRect(x: frame.width - Constants.frameSide,
                                   y: 0,
                                   width: Constants.frameSide,
                                   height: Constants.frameSide)
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
    }
    
    func setupCell(restaurant: RestaurantModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        mainImageView.image = UIImage(data: restaurant.imageData ?? Data())
        nameLabel.text = restaurant.name
        ratingLabel.text = "RATE".localized + " ✭ " + String(restaurant.aggregateRatings.thefork.ratingValue)
        let isFavourite = restaurant.isFavourite ?? false
        heartButton.setImage(UIImage(named: isFavourite ? "FILLED_HEART_IMAGE_NAME".localized : "EMPTY_HEART_IMAGE_NAME".localized), for: .normal)
        adressLabel.text = restaurant.address.street
        updateHeightConstraints()
    }
    
    private func updateHeightConstraints() {
        portraitHeightConstraint?.isActive = UIDevice.current.orientation.isPortrait
        landscapeHeightConstraint?.isActive = !UIDevice.current.orientation.isPortrait
    }
}

