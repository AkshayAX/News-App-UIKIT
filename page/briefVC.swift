//
//  briefVC.swift
//  page
//
//  Created by Akshaya Kumar N on 1/16/20.
//  Copyright © 2020 Akshaya Kumar N. All rights reserved.
//

import UIKit
import Firebase
import WebKit

class briefVC: UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var display: WKWebView!
    
    @IBOutlet weak var likeBar: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    var news = [String]()
    var index:Int?
    var status:Bool?
    var id = [String]()
    
    
    @IBOutlet weak var txt: UITextView!
    
    @IBOutlet weak var scroll: UIScrollView!
    var commentaca = [String]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UISwipeGestureRecognizer(target:self, action: #selector(rightSwipe(sender:)))
              gesture.direction = .right
              view.addGestureRecognizer(gesture)
              
        likeControl()
        let url = URL(string: news[index!])
        display.load(URLRequest(url: url!))
        likesCount()
       // commentsCount()
        commentCounts()

        comments.title = String(commentCount) + " Comments"
       
    }

 
    
    
    @IBOutlet weak var comments: UIBarButtonItem!
    
    @IBOutlet weak var likes: UIBarButtonItem!
        
     
    @IBAction func liked(_ sender: Any) {

      post()
        
        
        status = !status!

        if status == true
        {
             likeBar.image = UIImage(systemName: "heart.fill")
        }
        else
        {
            likeBar.image = UIImage(systemName: "heart")

        }
        
        post()
        likeControl()
     }
    
    
    
    
    @IBAction func comment(_ sender: Any)
        
    {
        
pass()
        
    }
   
func post()
          {
            
            var name = "Anonymous"
              
              if   let messageSender = Auth.auth().currentUser?.email
              {
                if status == nil
                {
status = false
                    
                }
               if Auth.auth().currentUser?.displayName != nil
                                  {
                                  
                name = (Auth.auth().currentUser?.displayName)!
                                  }
               
                db.collection(id[self.index!]).document(
                    messageSender).setData(["like":status!,"user":messageSender,"name":name], merge: true) { (error) in
                      if let e = error {
                        alert(description: e.localizedDescription, vc: self)
                      } else {
                        
                        self.likesCount()
                        
                        
                      }
                    }
              }
          }
      
         
    func likesCount()
    {
      
        db.collection(id[self.index!]).whereField("like", isEqualTo: true).getDocuments { (querySnapshot, err) in
                 if let err = err {
                    alert(description: err.localizedDescription, vc: self)
                    
                 }
                 else {
                    self.likes.title =  String(querySnapshot!.count) + " Likes"

                       }
               
        }
    }
    
    
    func commentCounts()
    {
    
        _ = db.collection(id[self.index!]).addSnapshotListener { (snap, error) in
            
            
             if let err = error
                      {
                                                   
                      alert(description: err.localizedDescription, vc: self)
                          
                      }
                              
                                if let doc = snap?.documents
                                    
                                {
                                    
                                    self.commentaca = []

                                    for din in doc
                                    {
                                        let daata = din.data()
                                        if let  inte = daata["comment"]
                                        {
                                        
                                        self.commentaca.append(inte as! String)
                                        }
                                        else
                                        {return}
                                        
                                        
                                    }
            
                                    commentCount = self.commentaca.count
   self.comments.title =  String(commentCount) + " Comments"
        }
        
        
       

    }
    }
        

    
    
    
    
    
    
 func likeControl()
 {
    if   let messageSender = Auth.auth().currentUser?.email
            {

                let docRef = db.collection(id[self.index!]).document(messageSender)
               

                docRef.addSnapshotListener { (snap, error) in
                    if let document = snap {
    
                         if let err = error
                         {
                         
                         alert(description: err.localizedDescription, vc: self)
                            
                        }
                        let property = document.get("like")
                        if property == nil
                        {
                            return
                        }
                        else
                        {
                        if property as? Bool == true
                        {
                            self.status =  property as? Bool

                            self.likeBar.image = UIImage(systemName: "heart.fill")

                            
                        }
else                        {
                            self.status =  property as? Bool


                            self.likeBar.image = UIImage(systemName: "heart")

                        }
                        }
                    
                    }
                        
                    
                }
            }
   
    }
    
    
    
  
               
  
    func pass()
    {
        let controller = storyboard?.instantiateViewController(withIdentifier: "comnt") as! commentVC
        controller.id = id
        controller.index = index
        self.present(controller, animated: true, completion: nil)
    }
    
    
    
    @objc func rightSwipe(sender:UISwipeGestureRecognizer)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        
        
            let firebaseAuth = Auth.auth()
        do {
            print("yepp")
          try firebaseAuth.signOut()
            let next = self.storyboard?.instantiateViewController(withIdentifier: "id") as! authVC
            self.present(next, animated: true, completion: nil)


        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
          
    }
}

    

