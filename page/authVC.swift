//
//  authVC.swift
//  page
//
//  Created by Akshaya Kumar N on 1/21/20.
//  Copyright © 2020 Akshaya Kumar N. All rights reserved.
//

import UIKit
import  Firebase

class authVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var eye: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    var timer:Timer?
    
    let imgArray = ["a","b","c"]
    var count = 0
    @IBOutlet weak var butt: UIButton!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var bgVw: UIView!
    
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(imgTrig), userInfo: nil, repeats: true)
        butt.layer.cornerRadius = 20
         
        email.tag = 0
        password.tag = 1
        email.delegate = self
        password.delegate = self
        img.backgroundColor = .clear
        img.isOpaque = false
      
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
               view.addGestureRecognizer(gesture)
    
     
    }
    
   @objc func imgTrig()
    {
       
        img.image = UIImage(named: imgArray[count])
        count = count + 1
        if count == imgArray.count
               {
                  count = 0
               }
    }
    
    
    

  

    @IBAction func login(_ sender: Any) {
        
       

      log()
        
    }
    
    
    func log()
    {
       
        
        if email.text != "" && password.text != ""
                                  {
                                   
                                   if butt.titleLabel?.text == "Login"
                                   {
                                      
                                      login()
                                      }
                                      if butt.titleLabel?.text == "Sign Up"

                                      {
                                 signup()
                                          
                                      }
                                      
                                      }
              
              
                         else
                           {
                               alert(description: "Empty fields", vc: self)
                           }
              
        
        
        
    }
    
    
    func signup()
    {
        
      
              Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
                if let err = error
                                {
                                    alert(description: err.localizedDescription, vc: self)
                                   }
                    
                                   
                                 else
                                {
                                  
                                  
                                   self.performSegue(withIdentifier: "sid1", sender: self)
                                   }}
                    }
        
    
    
    
    
    func login()
    {
      
                      print("hi")
                     Auth.auth().signIn(withEmail: email.text!, password: password.text!)
                      {  authResult, error in
                       if let err = error
                       {
                          
                          alert(description: err.localizedDescription, vc: self)
                          }
                          else
                       {
                      
                          self.performSegue(withIdentifier: "sid1", sender: self)
                          }
                          }
                      
                         }
    
    
    
    
    
    var changeLabel = false

    @IBAction func signUp(_ sender: Any) {
        changeLabel = !changeLabel
        if changeLabel == true
        {
        
        butt.setTitle("Sign Up",for: .normal)
        signUp.setTitle("Sign into an account",for: .normal)

        
        }
        if changeLabel == false
        {
            butt.setTitle("Login",for: .normal)
           signUp.setTitle("Create an account",for: .normal)


            
        }

  
        
    
       
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0
        {
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        }
        if textField.tag == 1
        {
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            view1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
  
    
    var eyeOpened = false
    
    @IBAction func eye(_ sender: Any) {
        eyeOpened = !eyeOpened
        if eyeOpened == true
        {
            eye.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            password.isSecureTextEntry = false
        }
        
        else
        {
            eye.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            password.isSecureTextEntry = true
}}

    
    
    


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField
       {
        
        
          nextField.becomeFirstResponder()
        
       }
       
       
          textField.resignFirstResponder()
       
      
            log()

        return true
    }

    @objc  func tapped(sender:UITapGestureRecognizer)
       {
           view.endEditing(true)
           
       }
     

}
