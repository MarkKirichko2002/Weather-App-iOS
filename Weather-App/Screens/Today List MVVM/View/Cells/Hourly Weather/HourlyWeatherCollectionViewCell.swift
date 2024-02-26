//
//  HourlyWeatherCollectionViewCell.swift
//  Weather-App
//
//  Created by Марк Киричко on 11.02.2024.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let hourLabelFontSize = 16.0
    static let temperatureLabelFontSize = 16.0
}

private extension Int {
    static let hourLabelTop = 5
    static let weatherIconTop = 20
    static let weatherIconWidth = 50
    static let weatherIconHeight = 50
    static let temperatureLabelTop = 55
}

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: CGFloat.hourLabelFontSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = .label
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: CGFloat.temperatureLabelFontSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hourLabel.text = nil
        weatherIcon.image = nil
        temperatureLabel.text = nil
    }
    
    private func setUpView() {
        contentView.addSubview(hourLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(temperatureLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        hourLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(Int.hourLabelTop)
            maker.centerX.equalToSuperview()
        }
        weatherIcon.snp.makeConstraints { maker in
            maker.top.equalTo(hourLabel).inset(Int.weatherIconTop)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(Int.weatherIconWidth)
            maker.height.equalTo(Int.weatherIconHeight)
        }
        temperatureLabel.snp.makeConstraints { maker in
            maker.top.equalTo(weatherIcon).inset(Int.temperatureLabelTop)
            maker.centerX.equalToSuperview()
        }
    }
    
    func configure(with model: HourlyWeatherCollectionViewCellViewModel) {
        hourLabel.text = "\(model.hour)"
        weatherIcon.image = UIImage(systemName: model.icon)
        temperatureLabel.text = "\(model.temperature)°"
    }
}
