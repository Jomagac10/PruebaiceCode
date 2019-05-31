//
//  LoginViewController.swift
//  testIceCode
//
//  Created by Jose Manuel García Chávez on 5/30/19.
//  Copyright © 2019 Unam. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    
    //Properties
    let persistentContainer = NSPersistentContainer(name: "Login")
    lazy var context: NSManagedObjectContext = self.persistentContainer.viewContext
    
    let formContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 151/255, green: 252/255, blue: 223/255, alpha: 1)
        //        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor(red: 252/255, green: 215/255, blue: 173/255, alpha: 1)
        tf.placeholder = "Contraseña"
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let emailField : UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor(red: 252/255, green: 215/255, blue: 173/255, alpha: 1)
        tf.textAlignment = .center
        //        tf.attributedPlaceholder = NSAttributedString(string: "Número de cuenta", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.placeholder = "Correo Electrónico"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let registerButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(red: 37/255, green: 161/255, blue: 142/255, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        let colortitle = UIColor(red: 151/255, green: 252/255, blue: 223/255, alpha: 1)
        btn.setTitleColor(colortitle , for: .normal)
        btn.setTitle("Ingresar", for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("\(error)")
            }
        }
        let _ = Login(context: context) // Create an object in the Persistent container with the default values
        do {
            try context.save()
        } catch  {
            print("Error saving the context")
        }
    }
    
    
    
    
    //SETUP LAYOUT
    func setupLayout(){
        view.backgroundColor = UIColor(red: 127/255, green: 216/255, blue: 190/255, alpha: 1)
        view.addSubview(formContainerView)
        formContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        formContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        formContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        formContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        //Email textfield and password
        formContainerView.addSubview(emailField)
        formContainerView.addSubview(passwordTextField)
        
        emailField.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor).isActive = true
        emailField.topAnchor.constraint(equalTo: formContainerView.topAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        passwordTextField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor ).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(registerButton)
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: formContainerView.bottomAnchor, constant: 20).isActive = true
        registerButton.widthAnchor.constraint(equalTo:formContainerView.widthAnchor, multiplier: 0.5).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    //LOGIN FUNCTION
    @objc func loginUser(){
        if let email = emailField.text, let password = passwordTextField.text{
            let fetchRequest: NSFetchRequest<Login> = Login.fetchRequest()
            let predicate = NSPredicate(format: "email == %@ && password == %@", email.lowercased(), password.lowercased())
            fetchRequest.predicate = predicate
            do {
                let result = try self.context.fetch(fetchRequest)
                if result.count > 0 {
                    // LOGIN SUCCESSFUL!! :D
                    // Now delete the object from the persistent cointainer
                    context.delete(result.first!)
                    // Go to the next view
                    let root = MyTableViewController()
                    let table = UINavigationController(rootViewController: root)
                    self.present(table, animated: true, completion: nil)
                    
                } else {
                    // INVALID CREDENTIALS
                    let alertController = UIAlertController(title: "Invalid credentials", message: "Credenciales inválidas", preferredStyle: .alert)
                    let actionOk = UIAlertAction(title: "OK",
                                                 style: .default,
                                                 handler: nil) //You can use a block here to handle a press on this button
                    alertController.addAction(actionOk)
                    present(alertController, animated: true)
                }
            } catch  {
                print("There was an error")
            }
        }
    }
    
}

