//
//  ResultListViewController.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/4/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import Hero
import EventKit


enum Identifier:String{
    case resultListCell
}
class ResultListViewController: UIViewController {
    
    var userSearch = String()
    var venues = [Venue](){
        didSet{
            tableView.reloadData()
        }
    }
    var venueImages = [UIImage]()
    // MARK: - Objects
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = .systemPurple
        tableView.register(ResultListTableViewCell.self, forCellReuseIdentifier: Identifier.resultListCell.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "Result List"
        configureTableViewConstraints()
        
        self.hero.isEnabled = true
      
    }
    
    // MARK: - constraints
    
    private func configureTableViewConstraints(){
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor), tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    
}

// MARK: - extensions
extension ResultListViewController: UITableViewDelegate{
    
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailedViewController()
        let info = venues[indexPath.row]
        
        detailedVC.venue = info
        self.navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, completionHandler) in
       
        }
        
        deleteAction.image = UIImage(systemName: "trash.circle.fill")
        
        let addToCalendarAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
    
        }
        
        addToCalendarAction.image = UIImage(systemName: "calendar.badge.plus")
        
        return UISwipeActionsConfiguration(actions: [addToCalendarAction,deleteAction])
    }
    
}
extension ResultListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.resultListCell.rawValue) as? ResultListTableViewCell else {return UITableViewCell()}
        
        let venue = venues[indexPath.row]
        let image = venueImages[indexPath.row]
        
        cell.categoryImage.image = image
       cell.categoryLabel.text = userSearch
        cell.storeLabel.text = venue.name
        return cell
    }
    
    
}
