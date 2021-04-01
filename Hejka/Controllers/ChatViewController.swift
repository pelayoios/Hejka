//
//  ChatViewController.swift
//  Hejka
//
//  Created by Miguel Pelayo Mercado Caram on 3/29/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Messages] = [
        Messages(sender: "123@hmail.com", body: "Hej, estamos aqui"),
        Messages(sender: "123@hmail.com", body: "Hej, estamos aqui"),
        Messages(sender: "123@hmail.com", body: "Hej, estamos aqui")
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTableView.dataSource = self
        navigationItem.hidesBackButton = true
        loadMessages()
        messageTableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        
    }
    
    func loadMessages() {
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { (querySnaphot, error) in
                
            self.messages = []
                
            if let err = error {
                print("There was an issue retrieving data from Firestore, \(err)")
            } else {
                if let snaphotDocuments = querySnaphot?.documents {
                    for doc in snaphotDocuments {
                        let data = doc.data()
                        if let messageSender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String {
                            let newMessage = Messages(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.messageTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.messageTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
  

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch let signError as NSError {
            print("Error: ", signError)
        }
        
        
    }
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        
        if let messageBody = textField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: messageSender,
                                                                              Constants.FStore.bodyField: messageBody,
                                                                              Constants.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let err = error {
                    print("There was an issue saving data to firestore, \(err)")
                } else {
                    print("Successfully saved data!")
                    self.textField.text = ""
                }
            }
        }
        
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ChatTableViewCell
        
        cell.messageLabel.text = messages[indexPath.row].body
        
        //Message from the current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: Constants.BrandColors.senderMessage)
        }
        //Message from another user
        else {
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.messageView.backgroundColor = UIColor(named: Constants.BrandColors.receiverMessage)
        }
        
        return cell
    }
    
    
}
