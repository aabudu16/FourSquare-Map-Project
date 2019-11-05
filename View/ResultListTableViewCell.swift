//
//  ResultListTableViewCell.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class ResultListTableViewCell: UITableViewCell {
    
    lazy var categoryImage:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        return image
    }()
      
    lazy var storeLabel:UILabel = {
    let label = UILabel()
        return label
    }()
    
    lazy var categoryLabel:UILabel = {
    let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        configureImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    private func configureImageViewConstraints(){
        self.addSubview(categoryImage)
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([categoryImage.topAnchor.constraint(equalTo: self.topAnchor, constant:  5), categoryImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  5), categoryImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5), categoryImage.widthAnchor.constraint(equalTo: self.categoryImage.heightAnchor)])
    }
    
    private func configureStoreLabelConstraints(){
    self.addSubview(storeLabel)
    categoryImage.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureCategoryLabelConstraints(){
       self.addSubview(categoryLabel)
       categoryLabel.translatesAutoresizingMaskIntoConstraints = false
       }
}
