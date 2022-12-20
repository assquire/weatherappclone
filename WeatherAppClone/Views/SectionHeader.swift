//
//  SectionHeader.swift
//  WeatherAppClone
//
//  Created by Askar on 08.12.2022.
//

import UIKit

final class SectionHeader: UIView {

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeaderLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(with text: String) {
        headerLabel.text = text
    }
}

//MARK: - Views setup methods

private extension SectionHeader {
    
    func setupHeaderLabel() {
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

