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

//MARK: Enum
enum Identifiers:String{
    case mapCell
}

class MapViewController: UIViewController {
    //MARK: Properties
    private let locationManger = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
    let initialLocation = CLLocation(latitude: 40.742054, longitude: -73.769417)
    let searchRadius: CLLocationDistance = 2000
    
    
    var venues = [Venue](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    //MARK: UI Objects
    lazy var mapView:MKMapView = {
        let map = MKMapView()
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
        button.addTarget(self, action: #selector(handleListButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = "Search"
        //navigationController?.isNavigationBarHidden = true
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
            
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.startUpdatingLocation()
        case .denied:
            break
        default:
            break
        }
    }
    
    
    //MARK: Constraints function
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.mapCell.rawValue, for: indexPath) as? MapCollectionViewCell else {return UICollectionViewCell()}
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
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}
