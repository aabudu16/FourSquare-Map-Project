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
import Hero

//MARK: Enum
enum Identifiers:String{
    case mapCell
}

class MapViewController: UIViewController {
    //MARK: Properties
    private let locationManger = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    let searchRadius: CLLocationDistance = 2000
    
    var venueImageArray = [UIImage](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var items = [Item](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var venues = [Venue]() {
        didSet {
            
            let annotations = self.mapView.annotations
            self.mapView.removeAnnotations(annotations)
            for i in venues {
                let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: i.location?.lat ?? 40.6782, longitude: i.location?.lng ?? -73.9442)
                newAnnotation.title = i.name
                self.mapView.addAnnotation(newAnnotation)
            }
            self.collectionView.reloadData()
        }
    }
    
    
    //MARK: UI Objects
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.userTrackingMode = .followWithHeading
        return map
    }()
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.mapCell.rawValue)
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    lazy var querySearchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search venue "
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
    
    lazy var listButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .systemPurple
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        button.layer.shadowRadius = 20.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.hero.id = "skyWalker"
        button.addTarget(self, action: #selector(handleListButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = "Search"
        configureLocationSearchBar()
        configureStateSearchBar()
        configureMapViewConstriants()
        configureListButtonConstraints()
        configureCollectionViewConstraints()
        configureLocationService()
        
    }
    //MARK: @objc function
    @objc func handleListButtonPressed(){
        
        let resultVC = ResultListViewController()
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    //MARK: private functions
    
    private func getMapData(lat:Double, long:Double, query:String){
        FourSquareAPIClient.shared.getData(lat: lat, long: long, query: query) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let venue):
                DispatchQueue.main.async {
                    self.venues = venue
                }
            }
        }
    }
    
    private func configureLocationService(){
        locationManger.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManger.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse, .authorizedAlways:
            beginLocationUpdates(locationManager: locationManger)
        case .denied:
            break
        default:
            break
        }
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager){
        mapView.showsUserLocation = true
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.startUpdatingLocation()
    }
    
    private func zoomToLatestLocation(with coordinate:CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    
    //MARK: Constraints function
    private func configureMapViewConstriants(){
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([mapView.topAnchor.constraint(equalTo: self.stateSearchBar.bottomAnchor), mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
    
    private func configureLocationSearchBar(){
        self.view.addSubview(querySearchBar)
        
        querySearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([querySearchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),querySearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), querySearchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), querySearchBar.heightAnchor.constraint(equalToConstant: 45)])
    }
    
    private func configureStateSearchBar(){
        self.view.addSubview(stateSearchBar)
        
        stateSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stateSearchBar.topAnchor.constraint(equalTo: self.querySearchBar.bottomAnchor, constant:  5),stateSearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), stateSearchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), stateSearchBar.heightAnchor.constraint(equalTo: querySearchBar.heightAnchor)])
    }
    
    private func configureListButtonConstraints(){
        self.view.addSubview(listButton)
        
        listButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([listButton.topAnchor.constraint(equalTo: stateSearchBar.bottomAnchor, constant:  10), listButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -10), listButton.heightAnchor.constraint(equalToConstant: 40), listButton.widthAnchor.constraint(equalToConstant: 40)])
    }
    
    private func configureCollectionViewConstraints(){
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 15), collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5), collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), collectionView.heightAnchor.constraint(equalToConstant: 200)])
    }
    
}

//MARK: Extensions
extension MapViewController:UICollectionViewDelegate{}
extension MapViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.mapCell.rawValue, for: indexPath) as? MapCollectionViewCell else {return UICollectionViewCell()}
         let venue = venues[indexPath.item]
        
        FourSquareAPIClient.shared.getVenueImages(venueID: venue.id!) { (result) in
            switch result{
            case .failure:
                self.venueImageArray.append(UIImage(named: "imagePlaceholder")!)
            case .success(let items):
                for item in items{
                let url = URL(string: item.getUserImage())
                    
                    ImageHelper.shared.getImage(url: url!) { (result) in
                        switch result{
                        case .failure:
                            self.venueImageArray.append(UIImage(named: "imagePlaceholder")!)
                        case .success(let venueImage):
                            self.venueImageArray.append(venueImage)
                        }
                    }
                }
            }
        }
        venueImageArray.forEach({cell.imageView.image = $0})
        CustomLayer.shared.createCustomlayer(layer: cell.layer)
        return cell
    }
}


extension MapViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let virticalCellCGSize = CGSize(width: 120, height: 120)
        return virticalCellCGSize
    }
}
extension MapViewController: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        querySearchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        querySearchBar.showsCancelButton = false
        querySearchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        //Activity indicator
        let activityIndcator = UIActivityIndicatorView()
        activityIndcator.style = .large
        activityIndcator.center = self.view.center
        activityIndcator.hidesWhenStopped = true
        activityIndcator.startAnimating()
        
        self.view.addSubview(activityIndcator)
        
        // dismiss search bar
        searchBar.resignFirstResponder()
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = stateSearchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            if response == nil {
                print(error!)
            }else {
                
                // dismiss activity indicator
                activityIndcator.stopAnimating()
                
                // remove current anotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //get latitude and longitude
                let lat = response?.boundingRegion.center.latitude
                let long = response?.boundingRegion.center.longitude
                //create new location Anntoation
                let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                
                //zoom in on the locations
                
                let coordinateRegion = MKCoordinateRegion.init(center: newAnnotation.coordinate, latitudinalMeters: self.searchRadius * 2.0, longitudinalMeters: self.searchRadius * 2.0)
                self.mapView.setRegion(coordinateRegion, animated: true)
                self.getMapData(lat: lat!, long: long!, query: self.querySearchBar.text!)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {return}
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
        }
        currentCoordinate = latestLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            beginLocationUpdates(locationManager: locationManger)
        }
    }
}
