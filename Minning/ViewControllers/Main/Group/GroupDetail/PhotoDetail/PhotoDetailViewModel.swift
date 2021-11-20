//
//  PhotoDetailViewModel.swift
//  Minning
//
//  Created by 고세림 on 2021/11/20.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem

final class PhotoDetailViewModel {
    
    let photoUrls: [String]
    private(set) var selectedPhotoIndex: DataBinding<Int>
    
    init(photoUrls: [String], selectedIndex: Int) {
        self.photoUrls = photoUrls
        self.selectedPhotoIndex = DataBinding(selectedIndex)
    }
    
    func increasePhotoIndex() {
        guard selectedPhotoIndex.value < photoUrls.count - 1 else { return }
        selectedPhotoIndex.accept(selectedPhotoIndex.value + 1)
    }
    
    func decreasePhotoIndex() {
        guard selectedPhotoIndex.value >= 0 else { return }
        selectedPhotoIndex.accept(selectedPhotoIndex.value - 1)
    }
}
