//
//  ViewController.swift
//  MVVM-JSON
//
//  Created by Puneet Personal on 15.04.20.
//  Copyright © 2020 Puneet Personal. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class ViewController: UIViewController {
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userTableView: UITableView!
    var viewModelUser = UserViewModel()
    var viewM: UserViewModel?
    var refresh = UIRefreshControl()
    var disposeBag = DisposeBag()
    var name = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelUser.getAllUsersDataWithAF()
        viewModelUser.vc = self
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.register(UINib(nibName: "UserCell",bundle:nil), forCellReuseIdentifier: "UserCell")
       
        refresh.addTarget(self, action: #selector(refreshed), for: UIControl.Event.valueChanged)
        userTableView.addSubview(refresh)
        searchBar.placeholder = "Search here"
        search()
    }
    
    @objc func refreshed(send: UIRefreshControl) {
        self.userTableView.reloadData()
        self.refresh.endRefreshing()
    }
    
    func search() {
        
        searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(Int(0.5)), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            
        
      
        
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelUser.usersArray.count
        //return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell
        let modelUser = viewModelUser.usersArray[indexPath.row]
        //cell?.modelUser = modelUser
        
        cell?.lblID.text = String(viewModelUser.usersArray[indexPath.row].id!)
        cell?.lblTitle.text = viewModelUser.usersArray[indexPath.row].title
        cell?.lblStatus.text = String(viewModelUser.usersArray[indexPath.row].completed!)
       // cell?.lblTitle.text = name[indexPath.row]
        return cell!
        
    }
    
    
}












// let modelUser = viewModelUser.usersArray[indexPath.row]
//cell?.modelUser = modelUser
