//
//  CurrentWeatherTableViewCell.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let cityLabelFontSize = 17.0
    static let temperatureLabelFontSize = 20.0
    static let conditionLabelFontSize = 17.0
    static let maxMinTemperatureLabelFontSize = 17.0
}

private extension Int {
    static let weatherIconLeft = 20
    static let weatherIconWidth = 80
    static let weatherIconHeight = 80
    static let cityLabelTop = 20
    static let temperatureLabelTop = 45
    static let conditionLabelTop = 45
    static let maxMinTemperatureLabelTop = 45
    static let maxMinTemperatureLabelBottom = 20
}

class CurrentWeatherTableViewCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    private let weatherIcon: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = .label
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: CGFloat.cityLabelFontSize, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: CGFloat.temperatureLabelFontSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: CGFloat.conditionLabelFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxMinTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: CGFloat.maxMinTemperatureLabelFontSize, weight: .medium)
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
        cityLabel.text = nil
        temperatureLabel.text = nil
        conditionLabel.text = nil
        maxMinTemperatureLabel.text = nil
    }
    
    private func setUpView() {
        contentView.addSubview(weatherIcon)
        contentView.addSubview(cityLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(maxMinTemperatureLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        weatherIcon.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().inset(Int.weatherIconLeft)
            maker.width.equalTo(Int.weatherIconWidth)
            maker.height.equalTo(Int.weatherIconHeight)
        }
        
        cityLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(Int.cityLabelTop)
            maker.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { maker in
            maker.top.equalTo(cityLabel).inset(Int.temperatureLabelTop)
            maker.centerX.equalToSuperview()
        }
        
        conditionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(temperatureLabel).inset(Int.conditionLabelTop)
            maker.centerX.equalToSuperview()
        }
        
        maxMinTemperatureLabel.snp.makeConstraints { maker in
            maker.top.equalTo(conditionLabel).inset(Int.maxMinTemperatureLabelTop)
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().inset(Int.maxMinTemperatureLabelBottom)
        }
    }
    
    func configure(with viewModel: CurrentWeatherTableViewCellViewModel) {
        weatherIcon.image = UIImage(systemName: viewModel.icon)
        cityLabel.text = viewModel.city
        temperatureLabel.text = "\(viewModel.temperature)°"
        conditionLabel.text = viewModel.condition
        maxMinTemperatureLabel.text = "Макс: \(viewModel.maxTemperature)°, мин: \(viewModel.minTemperature)°"
    }
}

