//
//  TodayWeatherListTableViewController.swift
//  Weather-App
//
//  Created by Марк Киричко on 08.02.2024.
//

import UIKit
import Combine

private extension String  {
    static let refreshIcon = "arrow.clockwise"
    static let optionsIcon = "list.bullet"
    static let navigationTitle = "Сегодня"
    static let placeHolder = "Введите город"
    static let menuTitle = "Погода"
    static let citiesActionTitle = "Города"
    static let celsiusActionTitle = "Градусы в Цельсии"
    static let fahrenheitActionTitle = "Градусы в Фаренгейте"
    static let calvinActionTitle = "Градусы в Кельвинах"
}

private extension CGFloat {
    static let heightForRowInFirstSection = 200.0
    static let heightForRowInSecondSection = 200.0
    static let heightForRowInThirdSection = 100.0
    static let heightForRowInFourthSection = 100.0
}

private extension Int {
    static let numberOfSections = 4
    static let numberOfRowsInFirstSection = 1
    static let numberOfRowsInSecondSection = 1
    static let numberOfRowsInThirdSection = 1
}

@available(iOS 16.0, *)
class TodayWeatherListTableViewController: UITableViewController {
    
    private var todayWeatherListViewModel: TodayWeatherListViewModel
    var cancellable: AnyCancellable?
    
    init(todayWeatherListViewModel: TodayWeatherListViewModel) {
        self.todayWeatherListViewModel = todayWeatherListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpSearch()
        setUpTable()
        bindViewModel()
    }
    
    private func setUpNavigation() {
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: String.refreshIcon), style: .plain, target: self, action: #selector(refreshWeather))
        refreshButton.tintColor = .label
        let options = UIBarButtonItem(image: UIImage(systemName: String.optionsIcon), menu: setUpMenu())
        options.tintColor = .label
        navigationItem.leftBarButtonItem = refreshButton
        navigationItem.rightBarButtonItem = options
        navigationItem.title = String.navigationTitle
        self.hidesBottomBarWhenPushed = true
    }
    
    private func setUpMenu()-> UIMenu {
        let citiesAction = UIAction(title: String.citiesActionTitle) { _ in
            self.openCitiesList()
        }
        let celsiusAction = UIAction(title: String.celsiusActionTitle, state: .on) { _ in
            self.todayWeatherListViewModel.convertToCelsius()
        }
        let fahrenheitAction = UIAction(title: String.fahrenheitActionTitle) { _ in
            self.todayWeatherListViewModel.convertToFahrenheit()
        }
        let calvinAction = UIAction(title: String.calvinActionTitle) { _ in
            self.todayWeatherListViewModel.convertToCalvin()
        }
        let divider = UIMenu(title: "", options: [.displayInline, .singleSelection], children: [celsiusAction, fahrenheitAction, calvinAction])
        
        let menu = UIMenu(title: String.menuTitle, options: .displayInline, children: [citiesAction, divider])
        return menu
    }
    
    @objc private func openCitiesList() {
        let container = Injection.makeContainer()
        guard let dependency = container.resolve(SavedCitiesListViewModel.self) else {return}
        let vc = SavedCitiesListTableViewController(viewModel: dependency)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func refreshWeather() {
        todayWeatherListViewModel.refresh()
    }
    
    private func setUpSearch() {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.searchBar.placeholder = String.placeHolder
        navigationItem.searchController = search
    }
    
    private func setUpTable() {
        tableView.register(CurrentWeatherTableViewCell.self, forCellReuseIdentifier: CurrentWeatherTableViewCell.identifier)
        tableView.register(InfoWeatherTableViewCell.self, forCellReuseIdentifier: InfoWeatherTableViewCell.identifier)
        tableView.register(HourlyWeatherTableViewCell.self, forCellReuseIdentifier: HourlyWeatherTableViewCell.identifier)
        tableView.register(DailyWeatherTableViewCell.self, forCellReuseIdentifier: DailyWeatherTableViewCell.identifier)
    }
    
    private func bindViewModel() {
        todayWeatherListViewModel.getCurrentLocation()
        cancellable = todayWeatherListViewModel.$isFetched.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CGFloat.heightForRowInFirstSection
        case 1:
            return CGFloat.heightForRowInSecondSection
        case 2:
            return CGFloat.heightForRowInThirdSection
        case 3:
            return CGFloat.heightForRowInFourthSection
        default:
            return CGFloat.heightForRowInThirdSection
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Int.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Int.numberOfRowsInFirstSection
        case 1:
            return Int.numberOfRowsInSecondSection
        case 2:
            return Int.numberOfRowsInThirdSection
        default:
            return todayWeatherListViewModel.dailyWeather.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.identifier, for: indexPath) as? CurrentWeatherTableViewCell else {return UITableViewCell()}
            if let weather = todayWeatherListViewModel.currentWeather {
                cell.configure(with: weather)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoWeatherTableViewCell.identifier, for: indexPath) as? InfoWeatherTableViewCell else {return UITableViewCell()}
            if let weather = todayWeatherListViewModel.weatherInfo {
                cell.configure(with: weather)
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableViewCell.identifier, for: indexPath) as? HourlyWeatherTableViewCell else {return UITableViewCell()}
            cell.configure(with: todayWeatherListViewModel.hourlyWeather)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTableViewCell.identifier, for: indexPath) as? DailyWeatherTableViewCell else {return UITableViewCell()}
            cell.configure(with: todayWeatherListViewModel.dailyWeather[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}

@available(iOS 16.0, *)
extension TodayWeatherListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if !text.isEmpty {
            todayWeatherListViewModel.getLocation(by: text)
        }
    }
}

@available(iOS 16.0, *)
extension TodayWeatherListTableViewController: SavedCitiesListTableViewControllerDelegate {
    
    func citySelected(city: String) {
        todayWeatherListViewModel.getLocation(by: city)
    }
}
