//
//  MapCollectionViewCell.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/4/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class MapCollectionViewCell: UICollectionViewCell {
    lazy var imageView:UIImageView = {
    let image = UIImageView()
       // image.image = #imageLiteral(resourceName: "imagePlaceholder")
        return image
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           configureImageViewConstraints()
          
       }
    
    private func configureImageViewConstraints(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: self.topAnchor), imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor), imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor), imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

