//
//  detailVC.swift
//  page
//
//  Created by Akshaya Kumar N on 4/5/20.
//  Copyright © 2020 Akshaya Kumar N. All rights reserved.
//
import Firebase
import UIKit

class detailVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,UITextFieldDelegate{
    
    
  //  let cache2 = NSCache<NSString,UIImage>()

    
    let userid = (Auth.auth().currentUser?.email)!

 
    @IBOutlet weak var pimg: UIButton!
    @IBOutlet weak var usrnm: UITextField!
    
    //var img:UIImage?

    var imagePicker = UIImagePickerController()
  //  var imageee = UIImage()


    
    let storageRef = Storage.storage().reference()


        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.displayName != nil
        {
        usrnm.text = Auth.auth().currentUser?.displayName
        }
        else
        {
            return
        }
        
        
         let purl =  "gs://dupc1-eaa32.appspot.com/" + userid + "/" + userid + "photo"
        
      //  img = cache2.object(forKey: "selectedImage")
        
 
       downloadImageUserFromFirebase(urls: purl, imgvw: pimg)
        
         //  pimg.setBackgroundImage(imageee, for: .normal)
        

        usrnm.delegate = self
        imagePicker.delegate = self
        
        roundbutt(imageButton: pimg)
        

    }
    
    
   
    @IBAction func pAction(_ sender: Any)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){

                 imagePicker.sourceType = .savedPhotosAlbum
                 imagePicker.allowsEditing = false

                 present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func submit(_ sender: Any)
    {
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = usrnm.text
                     changeRequest?.commitChanges { (error) in
                        
                           
    if let err = error
    {
                                             
    alert(description: err.localizedDescription, vc: self)                      }
        }

        self.dismiss(animated: true, completion: nil)
        
    }
    
    
   
      
    
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage
            ] as? UIImage
        {
           
            
            guard let compImg = image.resized(toWidth: 400)
                  else {return}
            let purl =  "gs://dupc1-eaa32.appspot.com/" + userid + "/" + userid + "photo"

//cache2.removeAllObjects()
            cahhe.setObject(compImg, forKey:purl as NSString )
         pimg.setBackgroundImage(compImg, for: .normal)

             roundbutt(imageButton: pimg)

            let pname =  userid + "photo"

            uploadMedia(img: compImg, pathName: pname, userId: userid)
           // downloadImageUserFromFirebase(urls: purl, imgvw: pimg)

     print("great")
       dismiss(animated: true, completion: nil)

        }
        
    }
    
    


    
    func uploadMedia(img:UIImage , pathName:String ,userId:String) {
        
        
        let imageeee = img.pngData()

     

        let riversRef = storageRef.child(userId).child(pathName)
        
        _ = riversRef.putData(imageeee!, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
            return
          }
          riversRef.downloadURL { (url, error) in
            
        if let err = error
        {
                                 
        alert(description: err.localizedDescription, vc: self)                      }
          let downloadURL = url
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.photoURL = downloadURL
            changeRequest?.commitChanges { (error) in
                
                   
        if let err = error
            {
                                     
        alert(description: err.localizedDescription, vc: self)                     }
                
            }
          }
        }
    }
   /* override func viewDidAppear(_ animated: Bool) {
        let purl =  "gs://dupc1-eaa32.appspot.com/" + userid + "/" + userid + "photo"

        
        
        downloadImageUserFromFirebase(urls: purl, imgvw: pimg)
    }*/
 
    

}
