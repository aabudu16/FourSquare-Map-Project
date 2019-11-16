//
//  DetailedViewController.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import Hero
import CoreLocation
import MapKit

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
        tv.addGestureRecognizer(self.getDirectionsTapGesture)
        return tv
    }()
    
    lazy var getDirectionsTapGesture: UITapGestureRecognizer = {
        let guesture = UITapGestureRecognizer()
        guesture.addTarget(self, action: #selector(getDirections))
        return guesture
    }()
    
    lazy var getDirectionButton:UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.setTitle("Get Directions", for: .normal)
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        return button
    }()
    
     //MARK: -- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBarButton()
        configureImageViewConstraints()
        configureStoreLabelConstraints()
        configureCategoryLabelConstraints()
        configureGetDrectionButtonConstraints()
        configureAddressTextViewConstraints()
        
    }
    
    
    //MARK: -- @objc function
    @objc func addButtonPressed(){
        let addToCollectionVC = AddVenueToCollectionViewController()
        addToCollectionVC.favorite += [venue]
        addToCollectionVC.favoriteVenueImage = [(imageView.image ?? UIImage(named: "imagePlaceholder")!)]
        // print(imageView.image)
        present(UINavigationController(rootViewController: addToCollectionVC), animated: true, completion: nil)
    }
    
    @objc private func getDirections() {
        guard let lat = venue.location?.lat, let long = venue.location?.lng else {return}
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = venue.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
    }
    
    //MARK: -- Private function
    private func configureNavigationBarButton(){
        add = UIBarButtonItem(title: "Add to favorite", style: .plain, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem = add
    }
    
    
     //MARK: -- private constrainst function
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
        
        NSLayoutConstraint.activate([addressTextView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20), addressTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), addressTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), addressTextView.bottomAnchor.constraint(equalTo: getDirectionButton.topAnchor) ])
    }
    
    private func configureGetDrectionButtonConstraints(){
        self.view.addSubview(getDirectionButton)
               getDirectionButton.translatesAutoresizingMaskIntoConstraints = false
               
        NSLayoutConstraint.activate([getDirectionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5), getDirectionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 50), getDirectionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),getDirectionButton.heightAnchor.constraint(equalToConstant: 50)])
    }
}
