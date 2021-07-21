//
//  ViewController.swift
//  page
//
//  Created by Akshaya Kumar N on 12/27/19.
//  Copyright © 2019 Akshaya Kumar N. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class ViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource{
    
    var timer:Timer?
    
    let imageCache = NSCache<NSString, UIImage>()
    let db = Firestore.firestore()
    
    var imArray = [String]()
    var headArray = [String]()
    var providerArray = [String]()
    var detail = [String]()
    var id = [String]()
    

    
    @IBOutlet weak var collect: UICollectionView!
    
    
    
    @IBAction func click(_ sender: Any)
    {
    tabb.isHidden = false
    }
    
    
    @IBOutlet weak var table: UITableView!
    
    //let imgArray = ["a","b","c"]
   // let headsArray = ["Ronaldos marvelous kick saved portugal","Messi again going to no 1 says fifa rankings 2019","Suarez's fight lead urugauy in sufferings"]
        
    @IBOutlet weak var img: UIImageView!
    

    @IBOutlet weak var tabb: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collect.dataSource = self
        collect.delegate = self
        table.delegate = self
        table.dataSource = self
        
       timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slide), userInfo: nil, repeats: true)
        
      parse()
    
    }
 
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemscount = Int()
     
        itemscount = imArray.count
  
        return itemscount
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! cell
        
        cell.lbl.text = self.headArray[indexPath.row]
        cell.provider.text = self.providerArray[indexPath.row]

        
      
        
        let url = self.imArray[indexPath.row]

             loadImageUsingCache(withUrl: url, pimgview: cell.img)
             
             URLSession.shared.dataTask(with: NSURL(string: self.imArray[indexPath.row])! as URL, completionHandler: { (data, response, error) -> Void in

                    
         if let err = error
         {
                                       
         alert(description: err.localizedDescription, vc: self)                      }
                  DispatchQueue.global(qos: .background).async {
                         print(self.imArray[indexPath.row])

                        let image: UIImage = UIImage(data: data!)!
                         
                         
                        DispatchQueue.main.async {
                        
                         self.imageCache.setObject(image, forKey: self.imArray[indexPath.row] as NSString)

                             cell.img.image = image

                        }

                         }

              }).resume()
             
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradient.locations = [0.1,1.3]
        gradient.frame = cell.bounds
       cell.img.layer.insertSublayer(gradient, at: 0)

     
        return cell
    }
    
    

  @objc func slide() {
    
    
    let  lastItem = self.collect.indexPathsForVisibleItems.last
    
      
     
      //fetch indexPath of lastItem
    let currentIItem = IndexPath(item: lastItem!.item, section: 0)
      //scroll to the indexPath through right direction
      self.collect.scrollToItem(at: currentIItem, at: .right, animated: false)
    
    
           // 2.next position
    
      // var nextItem = currentIndexPath.item + 1
    var nextItem = currentIItem.item + 1
    
    if nextItem == self.imArray.count {
           nextItem = 0
       }
      let nextIndexPath = IndexPath(item: nextItem, section: 0)
       // 3.scroll to next position
    self.collect.scrollToItem(at: nextIndexPath, at: .right, animated: false)
   }
  

 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collect.frame.width, height:self.collect.frame.height)
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return imArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell1 = table.dequeueReusableCell(withIdentifier: "id1", for: indexPath) as! tCell
        
        let url = self.imArray[indexPath.row]

        loadImageUsingCache(withUrl: url, pimgview: cell1.img)
        
        URLSession.shared.dataTask(with: NSURL(string: self.imArray[indexPath.row])! as URL, completionHandler: { (data, response, error) -> Void in

               
    if let err = error
    {
                                  
    alert(description: err.localizedDescription, vc: self)                      }
             DispatchQueue.global(qos: .background).async {
                    print(self.imArray[indexPath.row])

                   let image: UIImage = UIImage(data: data!)!
                    
                    
                   DispatchQueue.main.async {
                   
                    self.imageCache.setObject(image, forKey: self.imArray[indexPath.row] as NSString)

                        cell1.img.image = image

                   }

                    }

         }).resume()
        
      
  
    
        cell1.head.text = self.headArray[indexPath.row]

        cell1.provider.text = providerArray[indexPath.row]
        return cell1
    }
    
    
    func parse()
    {
        
        
         AF.request("http://localhost:3000/feeds").response { response in
            
            
            if   let err = response.error

            {
                
                alert(description: err.localizedDescription, vc: self)
                return
                    }
    
           
               
      let result = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? NSArray
           
            
            print(result)
            
            for arrayData in result!
        {
            let FinalRes = arrayData as! [String:String]
            print(FinalRes)
            let image = FinalRes["image"]
            self.imArray.append(image!)

            let head = FinalRes["head"]
            self.headArray.append(head!)
            
            let provide = FinalRes["provider"]
                       self.providerArray.append(provide!)
            
            let brief = FinalRes["news"]
            self.detail.append(brief!)
            
            let id = FinalRes["_id"]
            self.id.append(id!)

            
           
                }
          }
    }
   
   override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
       collect.reloadData()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 177
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

           self.performSegue(withIdentifier: "sid2", sender: indexPath)

}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sid2", let indexPath = sender as? IndexPath {
            let vc = segue.destination as? briefVC
                vc?.id = id
                vc?.news = detail
                vc?.index = indexPath.row
            
        }
    }
    
   
    func loadImageUsingCache(withUrl urlString : String,pimgview:UIImageView) {
    
        pimgview.image = nil

 let url = URL(string: urlString)
 guard  url != nil
else {return}

 if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
    pimgview.image = cachedImage
     return
 }
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                   self.performSegue(withIdentifier: "sid2", sender: indexPath)

    }
    
    
    
}
