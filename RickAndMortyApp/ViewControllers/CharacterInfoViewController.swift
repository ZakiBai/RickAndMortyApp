//
//  CharacterInfoViewController.swift
//  RickAndMortyApp
//
//  Created by Zaki on 03.06.2023.
//

import UIKit

final class CharacterInfoViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet var characterImage: UIImageView! {
        didSet {
            characterImage.layer.cornerRadius = characterImage.frame.height / 2
        }
    }
    
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Public properties
    var character: Character!
    
    // MARK: - Private properties
    private let networkManager = NetworkManager.shared
    private var spinnerView = UIActivityIndicatorView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        title = character.name
        descriptionLabel.text = character.description
        showSpinner(in: characterImage)
        fetchImage()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController else { return }
        guard let episodeVC = navVC.topViewController as? EpisodesTableViewController else { return }
        episodeVC.character = character
    }

    // MARK: - Private methods
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .white
        spinnerView.startAnimating()
        spinnerView.center = characterImage.center
        spinnerView.hidesWhenStopped = true
        view.addSubview(spinnerView)
    }
    
    private func fetchImage() {
        networkManager.fetchImage(from: character.image) { result in
            switch result {
            case .success(let imageData):
                self.characterImage.image = UIImage(data: imageData)
                self.spinnerView.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    

}

