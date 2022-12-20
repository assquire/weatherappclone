//
//  CityCell.swift
//  WeatherAppClone
//
//  Created by Askar on 08.12.2022.
//

import UIKit

final class CityCell: UITableViewCell {

    private lazy var bigView = UIView()
    
    private lazy var cityView = UIView()
    
    private lazy var cityTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .label
        label.text = "19:54"
        return label
    }()
    
    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Moscow"
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var weatherDegree: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        label.textColor = .label
        label.textAlignment = .right
        label.text = "-10°"
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
    
    func setCity(with model: WeatherModel) {
        DispatchQueue.main.async { [self] in
            cityTime.text = model.time
            cityName.text = model.cityName
            weatherDegree.text = "\(model.temperature)°"
            weatherIcon.image = UIImage(named: "image\(Int.random(in: 2...8))")?.withAlignmentRectInsets(UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10))
        }
    }
}

//MARK: - Custom private methods

private extension CityCell {
    
    func setupLabel(size: Int) -> UILabel {
        let label = UILabel()
        return label
    }
}

//MARK: - Setup views and constraints methods

private extension CityCell {
    
    func setupViews() {
        contentView.addSubview(bigView)
        bigView.addSubview(cityView)
        cityView.addSubview(cityTime)
        cityView.addSubview(cityName)
        bigView.addSubview(weatherIcon)
        bigView.addSubview(weatherDegree)
    }
    
    func setupConstraints() {
        bigView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        cityView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        cityTime.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.33)
        }
        cityName.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(cityTime.snp.bottom)
        }
        weatherIcon.snp.makeConstraints { make in
            make.leading.equalTo(cityView.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        weatherDegree.snp.makeConstraints { make in
            make.leading.equalTo(weatherIcon.snp.trailing)
            make.top.trailing.bottom.equalToSuperview()
        }
    }
}
