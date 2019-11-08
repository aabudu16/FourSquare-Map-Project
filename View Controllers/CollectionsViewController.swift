//
//  CollectionsViewController.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/4/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

enum collectionIdentifiers:String{
    case collectionCell
}
class CollectionsViewController: UIViewController {
    
    
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: collectionIdentifiers.collectionCell.rawValue)
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionViewConstraints()
    }
    
    private func configureCollectionViewConstraints(){
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor), collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5), collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5), collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)])
    }
}
extension CollectionsViewController: UICollectionViewDelegate{
    
}

extension CollectionsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionIdentifiers.collectionCell.rawValue, for: indexPath) as? MapCollectionViewCell else {return UICollectionViewCell()}
        
        cell.imageView.image = UIImage(named: "imagePlaceholder")
        
        return cell
    }
}

extension CollectionsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let virticalCellCGSize = CGSize(width: 180, height: 180)
        return virticalCellCGSize
    }
}
