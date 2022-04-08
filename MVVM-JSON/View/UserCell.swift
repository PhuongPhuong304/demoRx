//
//  UserCell.swift
//  MVVM-JSON
//
//  Created by Puneet Personal on 15.04.20.
//  Copyright © 2020 Puneet Personal. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    var modelUser: UserModel? {
        didSet {
            self.status()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func userConfiguration() {
        
                if let id = modelUser?.id {
                    lblID.text = "\(id)"
                } else {
                    lblID.text = "No ID"
                }
//        let status = modelUser?.getStatus()
//        lblStatus.text = status
//        lblTitle.text = modelUser?.title
    }
    
    func status()  {
        let status = modelUser?.getStatus()
        lblStatus.text = status
        //lblTitle.text = modelUser?.title
    }
    
    
    
}






//        if let id = modelUser?.id {
//            lblID.text = "\(id)"
//        } else {
//            lblID.text = "No ID"
//        }


//backgroundColor = status?.1
