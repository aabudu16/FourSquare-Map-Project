//
//  CollectionsViewController.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/4/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

//MARK: Enum
enum collectionIdentifiers:String{
    case collectionCell
}
class CollectionsViewController: UIViewController, UIGestureRecognizerDelegate {
    //MARK: -- Bar buttons
    
    var add:UIBarButtonItem!
    var done:UIBarButtonItem!
    var clear:UIBarButtonItem!
    
    var topAnchor:NSLayoutConstraint!
    var objectsArray:[UIView]!
    //MARK: UI Objects
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
    
    lazy var addToCollectionLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Zapf Dingbats", size: 25)
        label.text = "Add to collection"
        return label
    }()
    
    lazy var createNewCollectionLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Zapf Dingbats", size: 25)
        label.text = "Create New Collection"
        return label
    }()
    
    lazy var collectionTextField:UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.placeholder = "Enter your collection title ..."
        tf.clearsOnBeginEditing = true
        return tf
    }()
    
    lazy var createButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = button.frame.height / 2
        button.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addObjectsToAnArray()
        configureCollectionViewConstraints()
        configureNavigationBarButton()
        createNewCollectionLabelConstraints()
        configureCreateCollectionTextFieldConstraints()
        configureCreateButtonConstraints()
        configureAddToCollectionLabelConstraints()
        self.setAlphaToZero()
    }
    
    //MARK: @objc function
    @objc func addButtonPressed(){
        self.navigationItem.setRightBarButton( self.done, animated: true)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.collectionView.layoutIfNeeded()
            self.topAnchor.constant = 350
            self.view.backgroundColor = .black
            self.setAlphaToOne()
            
        }, completion: nil)
    }
    
    @objc func doneButtonPressed(){
        self.navigationItem.setRightBarButton( self.add, animated: true)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.collectionView.layoutIfNeeded()
            self.topAnchor.constant = 0
            self.view.backgroundColor = .white
            self.setAlphaToZero()
        }, completion: nil)
    }
    
    @objc func clearButtonPressed(){
        if collectionTextField.hasText{
            collectionTextField.text = ""
        }
    }
    
    @objc func createButtonPressed(){
        print("create button pressed")
    }
    
    //MARK: Private functions
    private func configureNavigationBarButton(){
        add =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        done =  UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearButtonPressed))
            
        navigationItem.rightBarButtonItem = add
        navigationItem.leftBarButtonItem = clear
        clear.tintColor = .clear
        clear.isEnabled = false
        done.tintColor = .red
    }
    
    private func addObjectsToAnArray(){
        objectsArray = [addToCollectionLabel, createNewCollectionLabel, collectionTextField,createButton]
    }
    private func setAlphaToOne(){
        self.objectsArray.forEach({$0.isHidden = false})
        self.objectsArray.forEach({$0.alpha = 1})
        self.collectionTextField.isEnabled = true
        
        clear.tintColor = .blue
        clear.isEnabled = true
    }
    
    private func setAlphaToZero(){
        self.objectsArray.forEach({$0.isHidden = true})
        self.objectsArray.forEach({$0.alpha = 0})
        self.clear.tintColor = .clear
        
        self.clear.isEnabled = false
        self.collectionTextField.isEnabled = false
    }
    
    private func configureCollectionViewConstraints(){
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor = collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0)
        
        NSLayoutConstraint.activate([collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor), collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5), collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),topAnchor])
    }
    
    private func createNewCollectionLabelConstraints(){
        view.addSubview(createNewCollectionLabel)
        
        createNewCollectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([createNewCollectionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10), createNewCollectionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), createNewCollectionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), createNewCollectionLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func configureCreateCollectionTextFieldConstraints(){
        view.addSubview(collectionTextField)
        
        collectionTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([collectionTextField.topAnchor.constraint(equalTo: self.createNewCollectionLabel.bottomAnchor, constant: 20), collectionTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), collectionTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20), collectionTextField.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func configureCreateButtonConstraints(){
        view.addSubview(createButton)
        
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([createButton.topAnchor.constraint(equalTo: self.collectionTextField.bottomAnchor, constant: 20), createButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80), createButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -80), createButton.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func configureAddToCollectionLabelConstraints(){
        view.addSubview(addToCollectionLabel)
        
        addToCollectionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([addToCollectionLabel.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor, constant: -20), addToCollectionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), addToCollectionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), addToCollectionLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
}

//MARK: Extensions
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
        
        let virticalCellCGSize = CGSize(width: 170, height: 170)
        return virticalCellCGSize
    }
}
