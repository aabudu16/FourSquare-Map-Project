//
//  ViewController.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/4/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    lazy var locationSearchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search location"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.layer.borderColor = UIColor.clear.cgColor
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var stateSearchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search state"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.layer.borderColor = UIColor.clear.cgColor
        searchBar.delegate = self
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        configureLocationSearchBar()
        configureStateSearchBar()
        configureMapViewConstriants()
        
    }
    
    private func configureMapViewConstriants(){
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([mapView.topAnchor.constraint(equalTo: self.stateSearchBar.bottomAnchor), mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
    
    private func configureLocationSearchBar(){
        self.view.addSubview(locationSearchBar)
        
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([locationSearchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),locationSearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), locationSearchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), locationSearchBar.heightAnchor.constraint(equalToConstant: 45)])
    }
    
    private func configureStateSearchBar(){
        self.view.addSubview(stateSearchBar)
        
        stateSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stateSearchBar.topAnchor.constraint(equalTo: self.locationSearchBar.bottomAnchor, constant:  5),stateSearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), stateSearchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), stateSearchBar.heightAnchor.constraint(equalTo: locationSearchBar.heightAnchor)])
    }
    
}

extension MapViewController: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
