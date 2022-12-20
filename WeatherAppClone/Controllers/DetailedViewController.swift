//
//  DetailedViewController.swift
//  WeatherAppClone
//
//  Created by Askar on 08.12.2022.
//

import UIKit

final class DetailedViewController: UIViewController {
    
    private let weekDays: [String] = ["Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Monday", "Tuesday"]
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.delegate = self
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var testView = UIView()
    
    private lazy var topView = UIView()
    
    private lazy var emptySpaceView = UIView()
    
    private lazy var cityName: UILabel = {
        let label = UILabel()
        configureLabel(label, size: 35)
        label.text = "New York"
        return label
    }()
    
    private lazy var weatherDegree: UILabel = {
        let label = UILabel()
        configureLabel(label, size: 100)
        label.font = UIFont.systemFont(ofSize: 100, weight: .thin)
        label.text = " 7°"
        return label
    }()
    
    private lazy var weatherCondition: UILabel = {
        let label = UILabel()
        configureLabel(label, size: 20)
        label.text = "Mostly Cloudy"
        return label
    }()
    
    private lazy var highestLowestDegree: UILabel = {
        let label = UILabel()
        configureLabel(label, size: 20)
        label.text = "H:8° L:0°"
        return label
    }()
    
    private lazy var hourlyForecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let height = view.frame.size.height * 0.15
        let width = height / 2.0
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HourlyForecastCell.self, forCellWithReuseIdentifier: Constants.Identifiers.hourlyForecastCell)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.borderColor = Constants.Colors.collectionViewBorder.cgColor
        collectionView.layer.borderWidth = 1
        return collectionView
    }()
    
    private lazy var dailyForecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DailyForecastCell.self, forCellReuseIdentifier: Constants.Identifiers.dailyForecastCell)
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.rowHeight = view.frame.size.height * 0.05
        tableView.separatorStyle = .none
        tableView.layer.borderColor = Constants.Colors.collectionViewBorder.cgColor
        tableView.layer.borderWidth = 1
        return tableView
    }()
    
    private lazy var descriptionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let height = 45.0
        let width = view.frame.width / 2.0
        layout.itemSize = CGSize(width: width, height: height)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TodaysDescriptionCell.self, forCellWithReuseIdentifier: Constants.Identifiers.descriptionCell)
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = false
        collectionView.isScrollEnabled = false
        collectionView.layer.borderColor = Constants.Colors.collectionViewBorder.cgColor
        collectionView.layer.borderWidth = 1
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.Colors.detailedViewBackground
        navigationController?.navigationBar.tintColor = .white
        
        hourlyForecastCollectionView.dataSource = self
        dailyForecastTableView.dataSource = self
        descriptionCollectionView.dataSource = self
        
        setupViews()
        setupConstraints()
    }
}

//MARK: - Private configure methods

private extension DetailedViewController {
    
    func configureLabel(_ label: UILabel, size: CGFloat) {
        label.font = UIFont.systemFont(ofSize: size)
        label.textColor = .white
        label.textAlignment = .center
    }
}

//MARK: - Scroll view delegate methods

extension DetailedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}

//MARK: - Collection view data source methods

extension DetailedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView  {
        case hourlyForecastCollectionView: return 24
        default: return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView  {
        case hourlyForecastCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.hourlyForecastCell, for: indexPath) as! HourlyForecastCell
            cell.setWeather(with: indexPath.row)
            cell.backgroundColor = .clear
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.descriptionCell, for: indexPath) as! TodaysDescriptionCell
            cell.backgroundColor = .clear
            return cell
        }
    }
}

//MARK: - Table view data source methods

extension DetailedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weekDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.dailyForecastCell, for: indexPath) as! DailyForecastCell
        cell.setWeather(with: weekDays[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
}

//MARK: - Setup views and constraints methods

private extension DetailedViewController {
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topView)
        topView.addSubview(cityName)
        topView.addSubview(weatherDegree)
        topView.addSubview(weatherCondition)
        topView.addSubview(highestLowestDegree)
        topView.addSubview(emptySpaceView)
        contentView.addSubview(hourlyForecastCollectionView)
        contentView.addSubview(dailyForecastTableView)
//        contentView.addSubview(descriptionCollectionView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.size.equalToSuperview()
        }
        topView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        cityName.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        weatherDegree.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        weatherCondition.snp.makeConstraints { make in
            make.top.equalTo(weatherDegree.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        highestLowestDegree.snp.makeConstraints { make in
            make.top.equalTo(weatherCondition.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        emptySpaceView.snp.makeConstraints { make in
            make.top.equalTo(weatherDegree.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        hourlyForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        dailyForecastTableView.snp.makeConstraints { make in
            make.top.equalTo(hourlyForecastCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
        }
//        descriptionCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(dailyForecastTableView.snp.bottom)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.35)
//        }
    }
}
