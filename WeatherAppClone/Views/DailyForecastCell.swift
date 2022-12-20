//
//  DailyForecastCell.swift
//  WeatherAppClone
//
//  Created by Askar on 09.12.2022.
//

import UIKit

final class DailyForecastCell: UITableViewCell {
    
    private lazy var weekDay: UILabel = {
        let label = UILabel()
        configureLabel(label, size: 20)
        label.text = "Wednesday"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var rainPercent: UILabel = {
        let label = UILabel()
        configureLabel(label, size: 14)
        label.text = "80%"
        label.textAlignment = .left
        label.textColor = Constants.Colors.darkenBlue
        return label
    }()
    
    private lazy var highDegree: UILabel = {
        let label = UILabel()
        configureLabel(label, size: 20)
        label.text = "14"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var lowDegree: UILabel = {
        let label = UILabel()
        configureLabel(label, size: 20)
        label.text = "5"
        label.textColor = Constants.Colors.darkenBlue
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWeather(with dayName: String) {
        weekDay.text = dayName
        weatherIcon.image = UIImage(named: "image\(Int.random(in: 2...8))")?.withAlignmentRectInsets(UIEdgeInsets(top: -7.5, left: -7.5, bottom: -7.5, right: -7.5))
    }
}

//MARK: - Private configure methods

private extension DailyForecastCell {
    
    func configureLabel(_ label: UILabel, size: CGFloat) {
        label.font = UIFont.systemFont(ofSize: size)
        label.textColor = .white
    }
}

//MARK: - Setup views and constraints methods

private extension DailyForecastCell {
    
    func setupViews() {
        contentView.addSubview(weekDay)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(rainPercent)
        contentView.addSubview(highDegree)
        contentView.addSubview(lowDegree)
    }
    
    func setupConstraints() {
        weekDay.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        weatherIcon.snp.makeConstraints { make in
            make.leading.equalTo(weekDay.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        rainPercent.snp.makeConstraints { make in
            make.leading.equalTo(weatherIcon.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        highDegree.snp.makeConstraints { make in
            make.leading.equalTo(rainPercent.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.1)
        }
        lowDegree.snp.makeConstraints { make in
            make.leading.equalTo(highDegree.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
