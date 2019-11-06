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
        image.image = #imageLiteral(resourceName: "imagePlaceholder")
        return image
    }()
      
    lazy var storeLabel:UILabel = {
    let label = UILabel()
        label.text = "Store name"
        return label
    }()
    
    lazy var categoryLabel:UILabel = {
    let label = UILabel()
        label.text = "Category name"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        configureImageViewConstraints()
        configureStoreLabelConstraints()
        configureCategoryLabelConstraints()
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
    storeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([storeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),storeLabel.leadingAnchor.constraint(equalTo: self.categoryImage.trailingAnchor, constant: 10), storeLabel.heightAnchor.constraint(equalToConstant: 30), storeLabel.widthAnchor.constraint(equalToConstant: 200)])
    }

    private func configureCategoryLabelConstraints(){
       self.addSubview(categoryLabel)
       categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([categoryLabel.topAnchor.constraint(equalTo: storeLabel.bottomAnchor, constant: 10), categoryLabel.leadingAnchor.constraint(equalTo: self.categoryImage.trailingAnchor, constant: 10), categoryLabel.heightAnchor.constraint(equalTo: self.storeLabel.heightAnchor), categoryLabel.widthAnchor.constraint(equalTo: self.storeLabel.widthAnchor)])
       }
}
