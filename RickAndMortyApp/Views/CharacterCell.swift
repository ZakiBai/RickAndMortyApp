//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Zaki on 03.06.2023.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet var characterNameLabel: UILabel!
    
    @IBOutlet var characterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
