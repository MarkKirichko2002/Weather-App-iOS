//
//  SplashViewController.swift
//  Weather-App
//
//  Created by Марк Киричко on 26.02.2024.
//

import UIKit

private extension CGFloat {
    static let fontSize: Self = 20
    static let iconWidth: Self = 130
    static let iconHeight: Self = 130
    static let titleLabelHeight: Self = 30
    static let titleLabelTop: Self = 50
}

private extension String {
    static let icon = "cloud"
    static let title = "Погода"
}

private extension Double {
    static let seconds = 2.0
}

@available(iOS 16.0, *)
class SplashViewController: UIViewController {
    
    // MARK: - UI
    private let icon: UIImageView = {
        let image = UIImageView()
        image.tintColor = .label
        image.image = UIImage(systemName: String.icon)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: CGFloat.fontSize, weight: .black)
        label.text = String.title
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var factory: IScreenFactory
    
    init(factory: IScreenFactory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        goToApp()
    }
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(views: icon, titleLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        NSLayoutConstraint.activate([
            
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.widthAnchor.constraint(equalToConstant: CGFloat.iconWidth),
            icon.heightAnchor.constraint(equalToConstant: CGFloat.iconHeight),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: CGFloat.titleLabelHeight),
            titleLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: CGFloat.titleLabelTop)
        ])
    }
    
    private func goToApp() {
        Timer.scheduledTimer(withTimeInterval: Double.seconds, repeats: false) { [weak self] _ in
            guard let vc = self?.factory.createScreen(screen: .tabbar) else {return}
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
    }
}
