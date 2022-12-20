//
//  SearchFieldCell.swift
//  WeatherAppClone
//
//  Created by Askar on 08.12.2022.
//

import UIKit

protocol SearchFieldCellDelegate {
    func didChangeTextField(with text: String)
}

final class SearchFieldCell: UITableViewCell {
    
    var delegate: SearchFieldCellDelegate?

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.searchTextField.textColor = .label
        return searchBar
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        searchBar.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchFieldCell: UISearchBarDelegate {
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didChangeTextField(with: searchText)
    }
}

//MARK: - Setup views and constraints methods

private extension SearchFieldCell {
    
    func setupViews() {
        contentView.addSubview(searchBar)
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
