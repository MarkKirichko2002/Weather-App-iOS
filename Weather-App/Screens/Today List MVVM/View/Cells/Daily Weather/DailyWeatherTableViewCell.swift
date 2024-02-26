//
//  DailyWeatherTableViewCell.swift
//  Weather-App
//
//  Created by Марк Киричко on 11.02.2024.
//

import UIKit

private extension CGFloat {
    static let dayLabelFontSize = 16.0
}

private extension Int {
    static let dayLabelTop = 10
    static let dayLabelLeft = 10
    static let dayLabelBottom = 10
    static let weatherIconTop = 20
    static let weatherIconLeft = 50
    static let weatherIconWidth = 50
    static let weatherIconHeight = 50
    static let maxMinLabelTop = 20
    static let maxMinLabelRight = 10
    static let maxMinLabelBottom = 20
    static let maxMinLabelHeight = 50
}

class DailyWeatherTableViewCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .label
        label.font = .systemFont(ofSize: CGFloat.dayLabelFontSize, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = .label
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let maxMinLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .label
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
        dayLabel.text = nil
        weatherIcon.image = nil
        maxMinLabel.text = nil
    }
    
    private func setUpView() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(maxMinLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        dayLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(Int.dayLabelTop)
            maker.left.equalToSuperview().inset(Int.dayLabelLeft)
            maker.bottom.equalToSuperview().inset(Int.dayLabelBottom)
        }
        
        weatherIcon.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(Int.weatherIconTop)
            maker.left.equalToSuperview().inset(Int.weatherIconLeft)
            maker.width.equalTo(Int.weatherIconWidth)
            maker.height.equalTo(Int.weatherIconHeight)
        }
        
        maxMinLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(Int.maxMinLabelTop)
            maker.right.equalToSuperview().inset(Int.maxMinLabelRight)
            maker.bottom.equalToSuperview().inset(Int.maxMinLabelBottom)
            maker.height.equalTo(Int.maxMinLabelHeight)
        }
    }
    
    func configure(with viewModel: DailyWeatherTableViewCellViewModel) {
        dayLabel.text = viewModel.dayOfWeek
        weatherIcon.image = UIImage(systemName: viewModel.weatherIcon)
        maxMinLabel.text = "мин: \(viewModel.minTemperature)°, макс: \(viewModel.maxTemperature)°"
    }
}
