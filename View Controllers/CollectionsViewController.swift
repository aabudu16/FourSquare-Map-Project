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
class CollectionsViewController: UIViewController {
    //MARK: -- Bar buttons
    
    var collections = [CollectionModel](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var collectionTitle:String!
    var currentIndex: Int?
    
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
    
    lazy var genericCollectionImage:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "My Collection")
        return image
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
        tf.addTarget(self, action: #selector(checkTextFieldInput), for: .allEvents)
        return tf
    }()
    
    lazy var createButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.black, for: .normal)
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
        self.setAlphaToZeroAndDisableCreateButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPersistedData()
    }
    
    
    
    //MARK: @objc function
    @objc func addButtonPressed(){
        self.navigationItem.setRightBarButton( self.done, animated: true)
        
        UIView.transition(with: collectionView, duration: 1.3, options: .curveEaseOut, animations: {
            self.collectionView.layoutIfNeeded()
            self.collectionView.center.y = self.view.center.y + 350
        }, completion: { (true) in
            self.topAnchor.constant = 350
        })
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = .black
            self.setAlphaToOneAndDisableCreateButton()
            
        }, completion: nil)
    }
    
    @objc func doneButtonPressed(){
        self.navigationItem.setRightBarButton( self.add, animated: true)
        
        UIView.transition(with: collectionView, duration: 0.8, options: .curveEaseInOut, animations: {
            self.collectionView.layoutIfNeeded()
            self.collectionView.center.y = self.view.center.y
        }, completion: { (true) in
            self.topAnchor.constant = 0
        })
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.topAnchor.constant = 0
            self.view.backgroundColor = .white
            self.setAlphaToZeroAndDisableCreateButton()
        }, completion: nil)
    }
    
    @objc func clearButtonPressed(){
        if collectionTextField.hasText{
            collectionTextField.text = ""
            clear.isEnabled = false
        }
    }
    
    @objc func createButtonPressed(){
        self.saveUserInput()
    }
    
    @objc func checkTextFieldInput(){
        if  collectionTextField.hasText == true {
            clear.isEnabled = true
            createButton.isEnabled = true
        }else{
            clear.isEnabled = false
            createButton.isEnabled = false
        }
    }
    
    //MARK: Private functions
    
    private func loadPersistedData(){
        guard let loadCollection = try? CollectionPersistenceHelper.manager.getEntries()  else {return}
        if loadCollection.count > 0 {
            collections = loadCollection
        }
    }
    
    private func currentDate()->String{
        let formattedDate = "MMM/dd/yyyy HH:mm:ss"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = formattedDate
        return formatter.string(from: date)
    }
    
    // save persisted data
    private func saveUserInput(){
        guard let imageData = genericCollectionImage.image?.jpegData(compressionQuality: 0.7) else {return}
        guard let collectionName = collectionTextField.text else {return}
        
        let newCollection = CollectionModel(collectionName: collectionName, date: self.currentDate(), venueImage: imageData, savedVenue:[])
        try? CollectionPersistenceHelper.manager.save(entry: newCollection)
        
        showAlertToLoadCollection(with: "Success", and: "Created a new collection ")
    }
  
    private func loadUserInput(){
        do{
            collections = try CollectionPersistenceHelper.manager.getEntries()
        }catch{
            print(error)
        }
    }
    
    private func showAlertToLoadCollection(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .cancel) { (loadCollection) in
            self.loadUserInput()
        }
        alertVC.addAction(ok)
        present(alertVC, animated: true, completion: nil)
    }
    
    private func configureNavigationBarButton(){
        add =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        done =  UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearButtonPressed))
        
        navigationItem.rightBarButtonItem = add
        navigationItem.leftBarButtonItem = clear
        clear.tintColor = .clear
        clear.isEnabled = false
        done.tintColor = .blue
    }
    
    private func addObjectsToAnArray(){
        objectsArray = [addToCollectionLabel, createNewCollectionLabel, collectionTextField,createButton]
    }
    // set all objects alpha to one from the array
    private func setAlphaToOneAndDisableCreateButton(){
        self.objectsArray.forEach({$0.isHidden = false})
        self.objectsArray.forEach({$0.alpha = 1})
        self.collectionTextField.isEnabled = true
        
        clear.tintColor = .red
    }
    
    // set all objects alpha to zero from the array
    private func setAlphaToZeroAndDisableCreateButton(){
        self.objectsArray.forEach({$0.isHidden = true})
        self.objectsArray.forEach({$0.alpha = 0})
        self.clear.tintColor = .clear
        
        self.clear.isEnabled = false
        self.collectionTextField.isEnabled = false
        self.createButton.isEnabled = false
    }
    
    //MARK: Private Constraints function
    
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
        
        NSLayoutConstraint.activate([addToCollectionLabel.topAnchor.constraint(equalTo: self.createButton.bottomAnchor, constant: 100), addToCollectionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), addToCollectionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), addToCollectionLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
}

//MARK: Extensions
extension CollectionsViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let venueCollectionVC = VenueCollectionViewController()
        let info = collections[indexPath.item]
        
        
        venueCollectionVC.venues = info.savedVenue
        self.navigationController?.pushViewController(venueCollectionVC, animated: true)
        
    }
}

extension CollectionsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionIdentifiers.collectionCell.rawValue, for: indexPath) as? MapCollectionViewCell else {return UICollectionViewCell()}
        let info = collections[indexPath.item]
        
    
        
        cell.imageView.image = UIImage(data: info.venueImage)
        cell.dateLabel.text = info.date
        cell.venueLabel.text = info.collectionName
        return cell
    }
}

extension CollectionsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let virticalCellCGSize = CGSize(width: 170, height: 170)
        return virticalCellCGSize
    }
}
