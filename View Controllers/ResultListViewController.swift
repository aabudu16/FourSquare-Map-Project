//
//  ResultListViewController.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/4/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
enum Identifier:String{
    case resultListCell
}
class ResultListViewController: UIViewController {
    // MARK: - Objects
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = .white
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
}
extension ResultListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.resultListCell.rawValue) as? ResultListTableViewCell else {return UITableViewCell()}
        
        return cell
    }
    
    
}
