//
//  SettigViewController.swift
//  JampingGame
//
//  Created by Juri Ohto on 2021/06/23.
//

import UIKit
import  AVFoundation

class SettigViewController: UIViewController {
    
    private let cellId = "cellId"
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
}

extension SettigViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = userListTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserListTableViewCell
//        cell.user = users[indexPath.row]
//
//        return cell
//    }
    
    
    
    
    
}
