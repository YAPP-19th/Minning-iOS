//
//  RecommendViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/02.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets

final class RecommendViewModel {
    let coordinator: HomeCoordinator
    
    private var titles: [String] = ["작지만 소중한 변화🌤", "가벼운것부터 시작해요✨", "상쾌하게 여는 오늘의 아침🏡", "하루 더 성장할 나를 위한 시간👩‍💻"]
    
    private var cellTitles: [[String]] = [
        ["명상하기", "확언하기", "시각화", "감사한 일 쓰기", "다이어리 작성"],
        ["아침에 물 한잔 마시기", "침구정리", "영양제 챙겨 먹기", "아침밥 챙겨 먹기", "환기하기", "방 정리하기", "모닝 커피 마시기", "샤워하기"],
        ["스트레칭", "요가", "산책하기", "러닝", "수면 일기 작성하기"],
        ["독서", "30분 자기개발", "단어 외우기", "블로그 글 쓰기", "뉴스읽기"]
    ]
    private var cellContents: [[String]] = [
        ["고요히 자기 자신을\n느껴보는 시간이예요", "말할수록 더욱 선명해지는\n나의 무한한 가능성", "눈을 감고, 당신이 그리는\n미래를 떠올려보세요", "감사한 기억, 소중한 대상을\n떠올리며 적어보세요", "오늘 할 일, 어제에 대한 성찰\n등 무엇이든 좋아요"],
        ["발끝까지 깨워주는\n아침 물 한잔", "하루를 시작하는\n나만의 출발선!", "내 건강은 내가 챙겨요", "든든한 아침밥은\n에너지의 원천이에요", "아침의 공기로 방 안을 가득 채우세요", "나를 소중히 여기는\n작고 가벼운 습관", "모닝 커피 한 잔과\n여유로운 아침을 시작해봐요", "몸과 마음의 긴장을 풀어주는\n가장 간단한 방법"],
        ["팔 다리 쭉쭉! 발끝까지\n펴지는 시원함을 느껴봐요", "매 동작과 호흡에 집중하며\n수련하는 시간이예요", "여유롭게 동네 한바퀴\n돌아볼까요?", "폐를 가득 채우는 시원한\n아침 공기", "성공적인 미라클 모닝은\n잘 자는것으로부터!"],
        ["한 페이지씩 채우는\n마음의 자양분", "내가 원하는 나의 모습을\n만나기 위한 30분", "티끌 모아 태산! 오늘부터\n시작해보는건 어때요?", "나의 깊이를 쌓고 싶다면,\n아침 시간을 활용해 보세요","더 넓은 세상으로 나아갈\n나를 위하여"]
    ]
    
    private var cellColors: [UIColor] = [.cateSky100, .cateRed100, .cateGreen100, .yellowFFC700]
    
    var numberOfTitles: Int {
        return titles.count
    }
    
    func titleInfo(at index: Int) -> String {
        return titles[index]
    }
    
    func subTitleInfo(at index: Int) -> [String] {
        return cellTitles[index]
    }
    
    func subContentsInfo(at index: Int) -> [String] {
        return cellContents[index]
    }
    
    func cellColorInfo(at index: Int) -> UIColor {
        return cellColors[index]
    }
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
}
