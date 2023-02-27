//
//  ViewController.swift
//  firebase 2
//
//  Created by Scott Laudick on 2/25/23.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    var ref: DatabaseReference!
    var text = [String]()
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        ref = Database.database().reference()
        
        ref.child("Random text").observe(.childAdded, with: { (snapshot) in
                    let n = snapshot.value as! String
                    if !self.text.contains(n){
                        self.text.append(n)
                    }
                })
        
        
        ref.child("Random text").observeSingleEvent(of: .value, with: { snapshot in
                    print(self.text)
                    })
        

        print(text)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ref.child("Random text").observeSingleEvent(of: .value, with: { snapshot in})

        return 3//text.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = "123321123321"//text[indexPath.row]
               return cell
    }

    @IBAction func buttonButton(_ sender: Any) {
        
        let randomText = textFieldOutlet.text!
        ref.child("Random text").childByAutoId().setValue(randomText)
        
    }
    
}

