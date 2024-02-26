//
//  SavedCitiesListTableViewController.swift
//  Weather-App
//
//  Created by Марк Киричко on 13.02.2024.
//

import UIKit

private extension String {
    static let navigationTitle = "Города"
    static let cellIdentifier = "cityCell"
}

private extension Int {
    static let defaultRowsCount = 0
}

protocol SavedCitiesListTableViewControllerDelegate: AnyObject {
    func citySelected(city: String)
}

class SavedCitiesListTableViewController: UITableViewController {
    
    weak var delegate: SavedCitiesListTableViewControllerDelegate?
    var viewModel: ISavedCitiesListViewModel?
    
    init(viewModel: ISavedCitiesListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpTable()
        bindViewModel()
    }
    
    private func setUpNavigation() {
        navigationItem.title = String.navigationTitle
    }
    
    private func setUpTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String.cellIdentifier)
    }
    
    private func bindViewModel() {
        viewModel?.getCities()
        viewModel?.isFetched.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = viewModel?.cities[indexPath.row] else {return}
        delegate?.citySelected(city: city)
        navigationController?.popViewController(animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let cities = viewModel?.cities[indexPath.row] else {return}
            viewModel?.removeCity(name: cities)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cities.count ?? Int.defaultRowsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel?.cities[indexPath.row]
        return cell
    }
}
