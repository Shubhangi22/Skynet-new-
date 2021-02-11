//
//  ViewController.swift
//  Skynet
//
//  Created by Ios development on 08/02/21.
//  Copyright © 2021 Ios development. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var centerX: NSLayoutConstraint!
    @IBOutlet weak var centerY: NSLayoutConstraint!
    @IBOutlet weak var mainview: UIView!
    
var apiFile  = ApiFile()
    @IBOutlet weak var collection: UICollectionView!
    var dataModel = [DataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mainview.translatesAutoresizingMaskIntoConstraints = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        
//        self.mainview.frame.size.width = view.frame.size.width - 50
//         self.mainview.frame.size.height = view.frame.size.height - 50
        
        mainview.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
       
        collection.delegate = self
        collection.dataSource = self
      //  self.collection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
           apiCall()
       }
    func apiCall(){
           let urlString1 = Constants.Base_Url
           
           guard let url = URL(string:urlString1) else { return }
           print("URL:",url)
           
           apiFile.callGet(url: url, finish: self.apiResponce)
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
                    self.collection.reloadData()
                }
                 
               }catch  {
                   print("error trying to convert data to JSON2")
                   return
               }
               
           }
       }
    

//    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
////        let size = collection.frame.size
////        return CGSize(width: size.width, height: size.height)
//
//        return CGSize(width: 0, height: 0)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
         let size = collection.frame.size
        
        if  indexPath.row % 2 == 0{
           
            return CGSize(width: size.width, height: size.height)
                 
        }

        return CGSize(width: size.width , height: size.height /  2)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell
        
        cell?.id.text = String(dataModel[indexPath.row].id ?? 0)
        cell?.title.text = dataModel[indexPath.row].title
        cell?.text.text = dataModel[indexPath.row].body
        
        return cell ?? UICollectionViewCell()
       }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let cellWidth : CGFloat = 165.0
//
//        let numberOfCells = floor(collectionView.frame.size.width / cellWidth)
//        let edgeInsets = (collectionView.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
//
//        return UIEdgeInsets(top: 15, left: edgeInsets, bottom: 0, right: edgeInsets)
//    }

}

