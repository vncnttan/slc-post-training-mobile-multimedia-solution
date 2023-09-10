//
//  BookingTableViewCell.swift
//  IOS_POSTTRAINING
//
//  Created by prk on 18/08/23.
//

import UIKit

class BookingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var updatehandler = {
        
    }
    
    var deletehandler = {
        
    }
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var roomTxt: UITextField!
    
    
    @IBAction func updateBtnOnClick(_ sender: Any) {
        updatehandler()
    }
    
    @IBAction func deleteBtnOnClick(_ sender: Any) {
        deletehandler()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
