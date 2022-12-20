//
//  TodaysDescriptionCell.swift
//  WeatherAppClone
//
//  Created by Askar on 09.12.2022.
//

import UIKit

class TodaysDescriptionCell: UICollectionViewCell {

    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Sunrise"
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "07:05"
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
}

//MARK: - Setup views and constraints methods

private extension TodaysDescriptionCell {
    
    func setupViews() {
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
    }
    
    func setupConstraints() {
        topLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}
