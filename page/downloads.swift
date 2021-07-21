//
//  downloads.swift
//  page
//
//  Created by Akshaya Kumar N on 4/14/20.
//  Copyright © 2020 Akshaya Kumar N. All rights reserved.
//

import Foundation
import UIKit
import Firebase




let cahhe = NSCache<NSString,UIImage>()
var commentCount = 0


    

func loadImageUsingCache(withUrl urlString : String,pimagview:UIButton) {
    
 let url = URL(string: urlString)
 guard  url != nil
 else {return}
    
    //pimagview.setBackgroundImage(nil, for: .normal)

 if let cachedImage = cahhe.object(forKey: urlString as NSString)
 {
    pimagview.setBackgroundImage(cachedImage, for: .normal)
     //return
 }
}
   





func downloadImageUserFromFirebase(urls:String, imgvw:UIButton) {
       let storage = Storage.storage()
       var reference: StorageReference!
       
       reference = storage.reference(forURL: urls )
    
       
      loadImageUsingCache(withUrl: urls, pimagview: imgvw)
     reference.downloadURL { (url, error) in
        
      guard url != nil
      else {return}
       
        DispatchQueue.global(qos: .background).async {
       
       let data = NSData(contentsOf: url!)
       let image = UIImage(data: data! as Data)
           
             DispatchQueue.main.async
                {
             cahhe.setObject(image!, forKey: urls as NSString)
               imgvw.setBackgroundImage(image, for: .normal)
           }
       }
       
       }
   }



func loadImageUsingCaches(withUrl urlString : String,pimagview:UIImageView) {
    
 let url = URL(string: urlString)
 guard  url != nil
 else {return}
    

 if let cachedImage = cahhe.object(forKey: urlString as NSString)
 {
    pimagview.image = cachedImage
     return
 }
}


   

func downloadImageUserFromFirebases(urls:String, imgvw:UIImageView) {
    print("xx")

    let storage = Storage.storage()
    print("xxx")

    var reference: StorageReference!
    print("xxxx")

    
         let purl =  "gs://dupc1-eaa32.appspot.com/" + urls + "/" + urls + "photo"
    
    reference = storage.reference(forURL: purl )
    print("yy")

 
    
   loadImageUsingCaches(withUrl: urls, pimagview: imgvw)
    print("x")

  reference.downloadURL { (purl, error) in
     
 
    
    DispatchQueue.global(qos: .background).async {
        print("xy")

    guard purl != nil
     else {return}
        print("xyz")

    let data = NSData(contentsOf: purl!)
        print("xyzz")

    let image = UIImage(data: data! as Data)
        print("xyzzz")

        
          DispatchQueue.main.async
             {
            cahhe.setObject(image!, forKey: urls as NSString)
                print("z")

            imgvw.image = image
        }
    }
    
    }
}
