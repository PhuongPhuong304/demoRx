//
//  UserViewModel.swift
//  MVVM-JSON
//


import UIKit
import Alamofire
import RxSwift
import RxCocoa


class UserViewModel {
    
    var usersArray = [UserModel]()
    var vc : ViewController?
    //let request = NSMutableURLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos/")!)
    let mainURL = "https://jsonplaceholder.typicode.com/todos"
    
    var searchInput =  BehaviorRelay<String>(value: "")
    var searchesul = BehaviorRelay<[UserModel]>(value: [])
    
    // Using Alamofire
    func getAllUsersDataWithAF() {
        AF.request(mainURL).response { response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
                if let data = response.data {
                    do {
                        let userResponse = try JSONDecoder().decode([UserModel].self, from: data)
                        self!.usersArray.append(contentsOf: userResponse)
                        DispatchQueue.main.async {
                            self?.vc?.userTableView.reloadData()
                            print("ok")
                        }
                    } catch let err {
                        print(err.localizedDescription)
                        print("err")
                        self!.vc?.userTableView.isHidden = true
                        self!.showAlert()
                    }

                }
            })
        }
    }
    
    
    func showAlert() {
        let message = UIAlertController(title: "", message: "Try it!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.getAllUsersDataWithAF()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            print("cancel")
        })
        
        message.addAction(ok)
        message.addAction(cancel)
        self.vc?.present(message, animated: true, completion: nil)
        
    }
    

}


protocol MovieViewModelable {
    var userId: Int { get }
    var id : Int { get }
    var title : String { get }
    var completed : Bool { get }
}
