//
//  commentVC.swift
//  page
//
//  Created by Akshaya Kumar N on 2/15/20.
//  Copyright © 2020 Akshaya Kumar N. All rights reserved.
//

import UIKit
import Firebase



class commentVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var comments = [String]()
    var id = [String]()
    var index:Int?
    var users = [String]()
    var usernames = [String]()

    
    let db = Firestore.firestore()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  cTable.dequeueReusableCell(withIdentifier: "cid", for: indexPath) as! commentCell
        cell.comment.text = comments[indexPath.row]
        cell.name.text = self.usernames[indexPath.row]
        downloadImageUserFromFirebases(urls: self.users[indexPath.row], imgvw: cell.img)

        corner(img: cell.img)
        
        
        return cell
    }
    
    @IBOutlet weak var cTable: UITableView!
    @IBOutlet weak var comLet: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("a")

        let gesture = UISwipeGestureRecognizer(target:self, action: #selector(rightSwipe(sender:)))
        gesture.direction = .right
        view.addGestureRecognizer(gesture)
        
        print("ab")

        downloadImageUserFromFirebases(urls: (Auth.auth().currentUser?.email)!, imgvw: img)
        
        
        print("abc")

        cTable.delegate =  self
        cTable.dataSource = self
        
        corner(img: img)
        corners(img: comLet)
        commentss()
        print("d")

    }
    
    
    @IBOutlet weak var comment: UITextField!
    
    
    @IBAction func commentAct(_ sender: Any)
    {

        post()
        view.endEditing(true)
        comment.text = ""

    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
     

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
           control()
             commentss()
             cTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 126
    }
    
    

      func post()
              {
var name = "Anonymous"
                  
                  if   let messageSender = Auth.auth().currentUser?.email

                  {
                    if Auth.auth().currentUser?.displayName != nil
                    {
                    
                        name = (Auth.auth().currentUser?.displayName)!
                    }
                   
                    db.collection(id[self.index!]).document(
                        messageSender).setData(["comment":comment.text!,"user":messageSender,"name":name], merge: true) { (error) in
                          if let e = error {
                            alert(description: e.localizedDescription, vc: self)
                          } }
                  }}
    
    
    
    
    
    
      func commentss()
      {


        _ = db.collection(id[self.index!]).addSnapshotListener { (snap, error) in
                    
                    
            if let err = error
            {
                                         
            alert(description: err.localizedDescription, vc: self)
                
            }
                    
                      if let doc = snap?.documents
                      {
  self.comments = []
  self.usernames = []
  self.users = []


                          for din in doc
                          {
                          
                            let data1 =    din.data()
                            
                              let data2 = data1["comment"]
                            if data2 == nil
                            {
                                return
                            }
                            self.comments.append(data2 as! String)
                            let data3 = data1["user"]

                            if data3 == nil
                            {
                                return
                            }
                            self.users.append(data3 as! String)


                            let data4 = data1["name"]

                            if data4 == nil
                            {
                                return
                            }
                            self.usernames.append(data4 as! String)
}
                        
                        
                        DispatchQueue.main.async {
                            self.cTable.reloadData()
                        }
                        
                      }
            commentCount = self.comments.count
                     }
          }
    
    
    @IBAction func like(_ sender: Any)
    {
    }
    
    @IBAction func commentpeep(_ sender: Any) {
        
    }

    
    

    func control()
    {
        
           if   let messageSender = Auth.auth().currentUser?.email
                   {

                       let docRef = db.collection(id[self.index!]).document(messageSender)
                      

                       docRef.addSnapshotListener { (snap, error) in
                           if let document = snap {
                               let property = document.get("comment")
                               let property1 = document.get("user")
                               let property2 = document.get("name")


                            if (((property != nil) || (property1 != nil) || (property2 != nil)) )
                               {
                                   return
                               }
                            }}}
    }
    
    
    @objc func rightSwipe(sender:UISwipeGestureRecognizer)
    {
        
        performSegue(withIdentifier: "sid2", sender: self)
  }
    
    
}


