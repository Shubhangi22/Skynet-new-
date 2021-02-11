//
//  SecondViewController.swift
//  Skynet
//
//  Created by Ios development on 09/02/21.
//  Copyright © 2021 Ios development. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    var dataModel = [DataModel]()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //If you set it false, you have to add constraints.
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = UIColor.white
        
        
        return cv
    }()
  
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setView()
        
        
    }
    
    
    func setView(){
        view.addSubview(mainView)
        
        mainView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        mainView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        //  mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 300 ).isActive = true
        mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.mainView.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        // collectionView.heightAnchor.constraint(equalToConstant: 300 ).isActive = true
        // collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        apiCall()
    }
    
    func apiCall(){
        let urlString1 = Constants.Base_Url
        
        guard let url = URL(string:urlString1) else { return }
        print("URL:",url)
        
        ApiFile.shared.callGet(url: url, finish: self.apiResponce)
        
       // apiFile.callGet(url: url, finish: self.apiResponce)
    }
    func apiResponce(message:String, data:Data?) -> Void {
        self.dataModel.removeAll()
        if(data != nil){
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            do {
                
                guard let todo:NSArray = try JSONSerialization.jsonObject(with: data!, options: [])
                    as? NSArray else {
                        print("error trying to convert data to JSON1")
                        return
                }
                
                for ind in 0..<todo.count{
                    var data = todo[ind]
                    dataModel.append(DataModel.init(data as! [String:Any]))
                }
                
                print(dataModel)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }catch  {
                print("error trying to convert data to JSON2")
                return
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.id.text = String(dataModel[indexPath.row].id ?? 0)
        cell.title.text = dataModel[indexPath.row].title
        cell.body.text = dataModel[indexPath.row].body
        
        return cell
        
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 0
    }
    var selectSize = 1
    var selectedIndex = 2
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size = collectionView.frame.size
        
        if selectedIndex % 2 == 0 {
            selectSize = 0
        }else{
            selectSize = 1
        }
        
        if  selectSize == 0{
            
            if indexPath.row % 2 == 0{
               return CGSize(width: size.width, height: size.height)
            }else{
               return CGSize(width: size.width , height: size.height /  2)
            }
     
        }else{
            
            if indexPath.row % 2 == 0{
                return CGSize(width: size.width , height: size.height /  2)
            }else{
                 return CGSize(width: size.width, height: size.height)
                }
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex =  indexPath.row
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    
}
