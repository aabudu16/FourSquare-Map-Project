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
    lazy var imageView:UIImageView = {
       let image = UIImageView()
        return image
    }()
    
    lazy var storeLabel:UILabel = {
       let label = UILabel()
           label.text = "Store name"
           return label
       }()
    
    lazy var discriptionLabel:UILabel = {
       let label = UILabel()
           label.text = "Store name"
           return label
       }()
    override func viewDidLoad() {
        super.viewDidLoad()

       configureImageViewConstraints()
       configureStoreLabelConstraints()
       configureDiscriptionLabelConstraints()
    }
    
    private func configureImageViewConstraints(){
    self.view.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
 
    private func configureStoreLabelConstraints(){
       self.view.addSubview(storeLabel)
       storeLabel.translatesAutoresizingMaskIntoConstraints = false
           
           
       }

    private func configureDiscriptionLabelConstraints(){
       self.view.addSubview(discriptionLabel)
       discriptionLabel.translatesAutoresizingMaskIntoConstraints = false
           
           
       }
}
