//
//  ChatTableViewCell.swift
//  Hejka
//
//  Created by Miguel Pelayo Mercado Caram on 4/1/21.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var leftImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.layer.cornerRadius = messageView.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
