//
//  InfoWeatherTableViewCell.swift
//  Weather-App
//
//  Created by Марк Киричко on 20.02.2024.
//

import UIKit

private extension CGFloat {
    static let windLabelFontSize = 16.0
    static let rainLabelFontSize = 16.0
    static let sunLabelFontSize = 16.0
    static let cloudLabelFontSize = 16.0
}

private extension Int {
    static let windLabelTop = 20
    static let rainLabelTop = 45
    static let sunLabelTop = 45
    static let cloudLabelTop = 45
    static let cloudLabelBottom = 20
}

class InfoWeatherTableViewCell: UITableViewCell {

    static var identifier: String {"\(Self.self)"}
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: CGFloat.windLabelFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: CGFloat.rainLabelFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sunLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: CGFloat.sunLabelFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cloudLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: CGFloat.cloudLabelFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        windLabel.text = nil
        rainLabel.text = nil
        sunLabel.text = nil
        cloudLabel.text = nil
    }
    
    private func setUpView() {
        contentView.addSubview(windLabel)
        contentView.addSubview(rainLabel)
        contentView.addSubview(sunLabel)
        contentView.addSubview(cloudLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        windLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(Int.windLabelTop)
            maker.centerX.equalToSuperview()
        }
        
        rainLabel.snp.makeConstraints { maker in
            maker.top.equalTo(windLabel).inset(Int.rainLabelTop)
            maker.centerX.equalToSuperview()
        }
        
        sunLabel.snp.makeConstraints { maker in
            maker.top.equalTo(rainLabel).inset(Int.sunLabelTop)
            maker.centerX.equalToSuperview()
        }
        
        cloudLabel.snp.makeConstraints { maker in
            maker.top.equalTo(sunLabel).inset(Int.cloudLabelTop)
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().inset(Int.cloudLabelBottom)
        }
    }
    
    func configure(with viewModel: InfoWeatherTableViewCellViewModel) {
        windLabel.text = viewModel.wind
        rainLabel.text = viewModel.rain
        sunLabel.text = viewModel.sun
        cloudLabel.text = viewModel.clouds
    }
}
