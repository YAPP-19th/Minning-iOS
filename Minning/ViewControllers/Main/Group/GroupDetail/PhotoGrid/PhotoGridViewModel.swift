//
//  PhotoGridViewModel.swift
//  Minning
//
//  Created by 고세림 on 2021/10/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem

final class PhotoGridViewModel {
    private let coordinator: GroupCoordinator
    
    var selectedPhotoIndices: DataBinding<[Int]> = DataBinding([])
    
    public init(coordinator: GroupCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToPhotoDetail(viewModel: PhotoDetailViewModel) {
        coordinator.goToPhotoDetail(viewModel: viewModel)
    }
    
    func selectPhoto(index: Int) {
        var newIndices = selectedPhotoIndices.value
        newIndices.append(index)
        selectedPhotoIndices.accept(newIndices)
    }
    
    func deselectPhoto(index: Int) {
        let newIndices = selectedPhotoIndices.value.filter({ $0 != index })
        selectedPhotoIndices.accept(newIndices)
    }
    
    func deselectAllPhotos() {
        selectedPhotoIndices.accept([])
    }
}
