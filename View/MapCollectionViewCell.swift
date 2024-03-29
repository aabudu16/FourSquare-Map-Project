//
//  MapCollectionViewCell.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/4/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit


protocol CollectionViewCellDelegate: AnyObject {
    func actionSheet(tag: Int)
}
class MapCollectionViewCell: UICollectionViewCell {
    //MARK: Properties
    weak var delegate: CollectionViewCellDelegate?
    
    lazy var imageView:UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var venueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 20)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var dateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var moreButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "delete.right.fill"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageViewConstraints()
        configureDateLabelConstraints()
        configureVenueLabelConstraints()
        configureMoreButtonConstraints()
        
    }
    
    //MARK: @objc function
    @objc func moreButtonPressed(_ sender: UIButton){
        delegate?.actionSheet(tag: sender.tag)
    }
    
    //MARK: Private constraints function
    private func configureImageViewConstraints(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: self.topAnchor), imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor), imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor), imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    private func configureDateLabelConstraints(){
        addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([dateLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor), dateLabel.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor), dateLabel.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor), dateLabel.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    private func configureVenueLabelConstraints(){
        addSubview(venueLabel)
        
        venueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([venueLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor), venueLabel.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor), venueLabel.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor,constant: 5), venueLabel.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    private func configureMoreButtonConstraints(){
        addSubview(moreButton)
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([moreButton.topAnchor.constraint(equalTo: self.topAnchor), moreButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 140), moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),moreButton.heightAnchor.constraint(equalToConstant: 40)])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

