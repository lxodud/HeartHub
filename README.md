# 📸 HeartHub

## ⭐️ 프로젝트 소개
커플간의 사진을 공유할 수 있는 어플입니다.

## 📖 목차
1. [개발환경 및 라이브러리](#-개발환경-및-라이브러리)
2. [기능 소개](#-기능-소개)
3. [Diagram](#-diagram)
4. [고민한 점](#-고민한-점)

## 💻 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.8-orange)]() [![xcode](https://img.shields.io/badge/Xcode-14.2-blue)]() [![RxSwift](https://img.shields.io/badge/RxSwift-6.5.0-green)]()

## 🛠 기능 소개
>로그인
>
|<img src="https://github.com/lxodud/HeartHub/assets/85005933/ac1821bc-5787-4bdb-9a73-687468b776af" width=180>|
|:-:|

>회원가입

|<img src="https://github.com/lxodud/HeartHub/assets/85005933/e7ce3809-41a9-40e6-a0b4-0cd673afe116" width=180>|<img src="https://github.com/lxodud/HeartHub/assets/85005933/322392c8-afbf-4941-b94d-8a640baf594c" width=180>|<img src="https://github.com/lxodud/HeartHub/assets/85005933/cc383501-837e-46c5-8384-ae82534079faf" width=180>|
|:-:|:-:|:-:|

> 메인화면

|<img src="https://github.com/lxodud/HeartHub/assets/85005933/0282572b-a0c6-4076-b77e-cbcd60c07c6d" width=180>|
|:-:|


> 앨범

|<img src="https://github.com/lxodud/HeartHub/assets/85005933/1ee8aa87-e6e6-4c61-9685-26241762e8f5" width=180>|
|:-:|

> 커플 연동 화면

|<img src="https://github.com/lxodud/HeartHub/assets/85005933/0fea88a8-af55-4b2e-84cc-507e76898100" width=180>|
|:-:|


> 마이페이지

|<img src="https://github.com/lxodud/HeartHub/assets/85005933/4a3d1e0a-0ca9-49de-b172-764271eb0e9c" width=180>|<img src="https://github.com/lxodud/HeartHub/assets/85005933/71f9a7ed-dc60-474e-a005-9d5eb0624a15" width=180>|<img src="https://github.com/lxodud/HeartHub/assets/85005933/7b4cb9a8-907c-4636-a0a5-a57f634d6e0d" width=180>|
|:-:|:-:|:-:|

## 👀 Diagram

### Architecture
#### MVVM-C + Clean Architecture
![Untitled (4).jpg](https://hackmd.io/_uploads/S1yO5SZ76.jpg)

### Network Layer
#### Request Builder
![Untitled (3).jpg](https://hackmd.io/_uploads/BkjhwSZmp.jpg)

Request에서 공통되는 부분들을 추상화하고 contents type별로 구체 타입을 구현해서 사용하였습니다.

## 🤔 고민한 점

#### RxSwift의 도입

#### MVVM 이상의 관심사 분리가 필요했던 이유
