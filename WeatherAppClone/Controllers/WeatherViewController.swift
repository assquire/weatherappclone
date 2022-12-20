//
//  ViewController.swift
//  WeatherAppClone
//
//  Created by Askar on 07.12.2022.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    var weatherManager = WeatherManager()

//    private lazy var citiesList: [String] = ["Warsaw","Bucharest","Martuni","Shah Alam","Karmie","Budapest","Munich","Netivot","Santa Cruz de la Sierra","Porto Alegre","Kfar Yona","Palermo","Bremen","Jermuk","Beit Shemesh","Florence","Utrecht","Buenos Aires","Guayaquil","Rosario","Soledad","Subang Jaya","Valencia","Pasir Gudang","Akhtala"]
    
    private lazy var citiesList: [(Double, Double)] = [(43.26, 76.93), (52.23, 21.01), (44.43, 26.11), (38.13, 13.34), (39.47, -0.38)]
    
    private lazy var cityModelsList: [WeatherModel] = []
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CityCell.self, forCellReuseIdentifier: Constants.Identifiers.cityCell)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        weatherManager.delegate = self
        weatherManager.fetchRequest(with: citiesList)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        configureNavBar()
        setupViews()
        setupConstraints()
    }
}

//MARK: - Private configure methods

private extension WeatherViewController {
    
    func configureNavBar() {
        navigationItem.backButtonTitle = ""
    }
}

//MARK: - Search bar delegate methods

extension WeatherViewController: SearchFieldCellDelegate {
    
    func didChangeTextField(with text: String) {
//        if text == "" {
//            filteredList = citiesList
//            mainTableView.reloadSections(IndexSet(1..<mainTableView.numberOfSections), with: .automatic)
//        } else {
//            filteredList = citiesList.filter { $0.hasPrefix(text) }
//            mainTableView.reloadSections(IndexSet(1..<mainTableView.numberOfSections), with: .automatic)
//        }
    }
}

//MARK: - Main table view data source methods

extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return cityModelsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = SearchFieldCell()
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.cityCell, for: indexPath) as! CityCell
            cell.setCity(with: cityModelsList[indexPath.row])
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }
    }
}

//MARK: - Main table view delegate methods

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = SectionHeader()
            headerView.configureHeader(with: "Weather")
            return headerView
        default: return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = DetailedViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Weather manager delegate methods

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(with weatherModels: [WeatherModel]) {
        DispatchQueue.main.async {
            self.cityModelsList = weatherModels
        }
    }
    
    func didFailWithError(error: Error) {
        print("Following error occured: \(error)")
    }
}

//MARK: - Setup views and constraints methods

private extension WeatherViewController {
    
    func setupViews() {
        view.addSubview(mainTableView)
    }
    
    func setupConstraints() {
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setupAnything() {
        
    }
}

