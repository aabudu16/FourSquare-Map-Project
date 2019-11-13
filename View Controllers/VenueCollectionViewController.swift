//
//  VenueCollectionViewController.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/9/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

enum VenueIdentifier:String{
    case venueListCell
}
class VenueCollectionViewController: UIViewController {
    
    var venueImages = [UIImage]()
    
    var venues = [CollectionModel](){
        didSet{
            self.venueTableView.reloadData()
        }
    }
    
    lazy var venueTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.register(ResultListTableViewCell.self, forCellReuseIdentifier: VenueIdentifier.venueListCell.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVenueTableViewConstraints()
    }
    
    
    
    // MARK: - Constraints Funnctions
    private func configureVenueTableViewConstraints(){
        self.view.addSubview(venueTableView)
        venueTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([venueTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor), venueTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), venueTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), venueTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
}
// MARK: - extensions

extension VenueCollectionViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 5
        let horizontalPadding: CGFloat = 10
        
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 20    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x , y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: horizontalPadding, dy: verticalPadding)
        cell.layer.mask = maskLayer
        
    }
}

extension VenueCollectionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VenueIdentifier.venueListCell.rawValue) as? ResultListTableViewCell else {return UITableViewCell()}
        
        let venue = venues[indexPath.row]
        let image = venueImages[indexPath.row]
        
        cell.categoryImage.image = image
        cell.categoryLabel.text = venue.venue?.first?.categories?.first?.name
        cell.storeLabel.text = venue.venue?.first?.name
        return cell
    }
    
}
