//
//  AddVenueCollectionViewCell.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/14/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class AddVenueCollectionViewCell: UICollectionViewCell {
    lazy var imageView:UIImageView = {
           let image = UIImageView()
           return image
       }()
       
       lazy var venueLabel:UILabel = {
           let label = UILabel()
           label.font = UIFont(name: "Avenir-Light", size: 20)
           label.textColor = .gray
           label.text = "text"
           return label
       }()
       
       lazy var dateLabel:UILabel = {
           let label = UILabel()
           label.font = UIFont(name: "Avenir-Light", size: 12)
           label.textColor = .gray
           label.text = "Date"
           return label
       }()
       
    
    lazy var addToCollectionButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "saveToFolder"), for: .normal)
        return button
    }()
    
       override init(frame: CGRect) {
           super.init(frame: frame)
           configureImageViewConstraints()
           configureDateLabelConstraints()
           configureVenueLabelConstraints()
        configureAddToCollectionButtonConstraints()
           
       }
       
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
    
    private func configureAddToCollectionButtonConstraints(){
        addSubview(addToCollectionButton)
        addToCollectionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([addToCollectionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor), addToCollectionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor), addToCollectionButton.widthAnchor.constraint(equalToConstant: 50), addToCollectionButton.heightAnchor.constraint(equalToConstant: 50)])
    }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
