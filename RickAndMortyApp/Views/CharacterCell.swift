//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Zaki on 03.06.2023.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    // MARK: -IB Outlets
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView! {
        didSet {
            characterImage.contentMode = .scaleAspectFit
            characterImage.clipsToBounds = true
            characterImage.layer.cornerRadius = characterImage.frame.height / 2
            characterImage.backgroundColor = .white
        }
    }
   
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public methods
    func configure(with character: Character?) {
        guard let character else { return }
        characterNameLabel.text = character.name
        networkManager.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }

}
