//
//  DetailsViewModelProtocol.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import Foundation
import UIKit

// MARK: - DetailsViewModelProtocol

/// A protocol that defines the capabilities of an DetailsViewModel.
protocol DetailsViewModelProtocol {
    var detailsData: DetailsData { get }
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}
