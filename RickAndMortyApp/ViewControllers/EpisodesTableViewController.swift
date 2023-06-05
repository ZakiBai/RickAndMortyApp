//
//  EpisodesTableViewController.swift
//  RickAndMortyApp
//
//  Created by Zaki on 04.06.2023.
//

import UIKit

final class EpisodesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var character: Character!
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupTableView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character.episode.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        let episodeURL = character.episode[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        
        fetchEpisode(from: episodeURL) { episode in
            content.text = episode.name
            cell.contentConfiguration = content
        }

        return cell
    }

    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodeURL = character.episode[indexPath.row]
        fetchEpisode(from: episodeURL) { [unowned self] episode in
            performSegue(withIdentifier: "showEpisode", sender: episode)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeDetVC = segue.destination as? EpisodeDetailsViewController else { return }
        episodeDetVC.episode = sender as? Episode
    }
    
    // MARK: - Private Methods
    private func fetchEpisode(from url: URL, closure: @escaping(Episode) -> Void) {
        networkManager.fetch(Episode.self, from: url) { result in
            switch result {
            case .success(let episode):
                closure(episode)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Setup UI
extension EpisodesTableViewController {
    private func setupTableView() {
        tableView.rowHeight = 70
        tableView.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 1
        )
    }
    
    private func setupNavigationController() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 0.7
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.barTintColor = .white
    }
}
