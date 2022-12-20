//
//  HourlyCell.swift
//  WeatherAppClone
//
//  Created by Askar on 08.12.2022.
//

import UIKit

final class HourlyForecastCell: UICollectionViewCell {
    
    private lazy var bigView = UIView()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        configureLabel(label, size: 17.5)
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
        configureLabel(label, size: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWeather(with row: Int) {
        let attrs1 = configureAtributedString(with: "\(row + 1)", ofSize: 17.5)
        let attrs2 = configureAtributedString(with: "PM", ofSize: 14)
        attrs1.append(attrs2)
        timeLabel.attributedText = attrs1
        weatherIcon.image = UIImage(named: "image\(Int.random(in: 3...4))")?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        weatherDegree.text = " \(Int.random(in: 8...9))°"
    }
}

//MARK: - Private configure methods

private extension HourlyForecastCell {
    
    func configureLabel(_ label: UILabel, size: CGFloat) {
        label.font = UIFont.systemFont(ofSize: size, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
    }
    
    func configureAtributedString(with text: String, ofSize size: CGFloat) -> NSMutableAttributedString {
        NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: size)])
    }
}

//MARK: - Setup views and constraints methods

private extension HourlyForecastCell {
    
    func setupViews() {
        contentView.addSubview(bigView)
        bigView.addSubview(timeLabel)
        bigView.addSubview(weatherIcon)
        bigView.addSubview(weatherDegree)
    }
    
    func setupConstraints() {
        bigView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        timeLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        weatherDegree.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}
