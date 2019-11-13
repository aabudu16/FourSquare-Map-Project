//
//  DetailedViewController.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import Hero

class DetailedViewController: UIViewController {
    
    var venue:Venue!{
        didSet{
            storeLabel.text = venue.name
            categoryLabel.text = venue.returnCategory()
            addressTextView.text = venue.returnFullAddress()
        }
    }
    var add:UIBarButtonItem!
    
    lazy var imageView:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "imagePlaceholder")
        return image
    }()
    
    lazy var storeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Light", size: 20)
        return label
    }()
    
    lazy var categoryLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Light", size: 20)
        return label
    }()
    
    lazy var addressTextView:UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.font = UIFont(name: "Avenir-Light", size: 20)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBarButton()
        configureImageViewConstraints()
        configureStoreLabelConstraints()
        configureCategoryLabelConstraints()
        configureAddressTextViewConstraints()
    }
    
    @objc func addButtonPressed(){
        print("add button pressed")
    }
    
    private func configureNavigationBarButton(){
        add =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem = add
    }
    
    private func configureImageViewConstraints(){
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor), imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -20), imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, constant:  -20)])
        
        
    }
    
    private func configureStoreLabelConstraints(){
        self.view.addSubview(storeLabel)
        storeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([storeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant:  10), storeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10), storeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), storeLabel.heightAnchor.constraint(equalToConstant: 50)])
        
    }
    
    private func configureCategoryLabelConstraints(){
        self.view.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([categoryLabel.topAnchor.constraint(equalTo: storeLabel.bottomAnchor, constant:  10), categoryLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10), categoryLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), categoryLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureAddressTextViewConstraints(){
        self.view.addSubview(addressTextView)
        addressTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([addressTextView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20), addressTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), addressTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), addressTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
}
