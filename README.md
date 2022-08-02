<br/>
<br/>

<div align="center"> 

# toGather

<img width="374" alt="image" src="https://user-images.githubusercontent.com/59302419/182025431-d9ed3181-2e7f-49c2-aca6-dfe4c6b046c2.png">

<br/>
<br/>

**💰저축목표를 설정해서 🤑친구랑 함께 저축을 할 수 있는 앱입니다** 

</div>

<br/>
<br/>

### 📱 Screenshots

| 목표 설정 | Home | 저축 기록하기 | 알림 |
|:---:|:---:|:---:|:---:|
|<img width="285" alt="image" src="https://user-images.githubusercontent.com/59302419/182025494-e520cab7-a344-488b-87f2-0dc0720b76eb.png">|<img width="285" alt="image" src="https://user-images.githubusercontent.com/59302419/182025512-0f823384-ae93-4539-b712-e3f76203256f.png">|<img width="285" alt="image" src="https://user-images.githubusercontent.com/59302419/182025537-2868ae84-9034-4649-a931-0120bf305ae9.png">|<img width="285" alt="image" src="https://user-images.githubusercontent.com/59302419/182025561-3ff4084d-2fc4-4203-b185-ba8445e22af0.png">|

<br/>
<br/>

### 🚀 KeyNote
[🍏 ToGather-7standard 🍏](https://github.com/DeveloperAcademy-POSTECH/toGather/files/9229074/ToGather.-.7standard.pdf)
<br/>
<br/>
### :sparkles: Skills & Tech Stack
* SwiftUI
* Firebase

###people_hugging: Authors
[@Neal](https://github.com/yudonlee) | [@Miller](https://github.com/KimDaeSeong8721) |   [@Lance](https://github.com/limhyoseok) |  [@Max](https://github.com/Sungwooo) | [@Eve](https://github.com/unuhqueen) | [@Bit](https://github.com/yeongwooCho) |
:---|:---|:---|:---|:---|:---
Tech|Tech|Design|Tech|Tech|Tech 
|<img width="150" src="https://user-images.githubusercontent.com/39371835/182309545-ec4271f3-98a6-4246-ae66-7d6207d74f07.png">|<img width="150" src="https://user-images.githubusercontent.com/39371835/182309685-2f4f406d-2e0b-4d59-af2f-6b0b47c659bf.png">|<img width="150" src="https://user-images.githubusercontent.com/39371835/182309701-9ba4da6e-539c-4a3c-8c0a-a6826efd3b94.jpeg">|<img width="150" src="https://user-images.githubusercontent.com/39371835/182310928-66367938-3eae-4865-b549-a8f820fb872e.png">|<img width="150" src="https://user-images.githubusercontent.com/39371835/182310289-281888fd-f9ec-461b-99ac-0dcef0ecf2f7.png">|<img width="150" src="https://user-images.githubusercontent.com/39371835/182310746-3a02a438-7417-4888-91fb-6f65d9547ea7.png">|


### :file_folder: Folder Structure
```
ToGather
    └── ToGather
        ├── Global
        │   ├── Extension
        │   │   ├── Color+Extension.swift
        │   │   └── UserDefaults+Extension.swift
        │   ├── Literal
        │   │   ├── ColorAsset.swift
        │   │   └── Constants.swift
        │   ├── Logic
        │   │   ├── MoneyLogic.swift
        │   │   └── TimeLogic.swift
        │   ├── Service
        │   │   └── FirebaseManager.swift
        │   └── UIComponent
        │       ├── CheckboxToggleStyle.swift
        │       ├── CustomNavigationLink.swift
        │       └── CustomProgressBar.swift
        ├── GoogleService-Info.plist
        ├── Models
        │   ├── DummyData.swift
        │   ├── ItemData.swift
        │   ├── Notification.swift
        │   ├── Product.swift
        │   ├── Saving.swift
        │   ├── ThisWeek.swift
        │   └── User.swift
        ├── Preview Content
        │   └── Preview Assets.xcassets
        │       └── Contents.json
        ├── Screens
        │   ├── Core
        │   │   ├── Main
        │   │   │   ├── UIComponent
        │   │   │   │   └── ProgressCircle
        │   │   │   │       ├── AddedCircleView.swift
        │   │   │   │       ├── FriendsProgressCircle.swift
        │   │   │   │       ├── MyProgressCircle.swift
        │   │   │   │       ├── ProgressCircle.swift
        │   │   │   │       └── RGBColorInProgressCircle.swift
        │   │   │   ├── View
        │   │   │   │   └── MainView.swift
        │   │   │   └── ViewModel
        │   │   │       └── MainViewModel.swift
        │   │   ├── Notifications
        │   │   │   ├── View
        │   │   │   │   ├── NotificaionCell.swift
        │   │   │   │   └── NotificationsView.swift
        │   │   │   └── ViewModel
        │   │   │       └── NotificationsViewModel.swift
        │   │   ├── SavingRecord
        │   │   │   └── View
        │   │   │       ├── ImagePicker.swift
        │   │   │       └── SavingRecordView.swift
        │   │   ├── SavingStatus
        │   │   │   └── View
        │   │   │       └── SavingStatusView.swift
        │   │   ├── Setting
        │   │   │   └── View
        │   │   │       ├── DisplayModeView.swift
        │   │   │       └── SettingView.swift
        │   │   ├── Start
        │   │   │   ├── View
        │   │   │   │   └── StartView.swift
        │   │   │   └── ViewModel
        │   │   │       └── OnboardingViewModel.swift
        │   │   └── mainFriendSaving
        │   │       └── FrSavingView.swift
        │   ├── Onboarding
        │   │   ├── FriendAddition
        │   │   │   ├── View
        │   │   │   │   ├── AlreadyAddedFriendView.swift
        │   │   │   │   ├── ApplyFriendIdTextView.swift
        │   │   │   │   ├── FriendAdditionView.swift
        │   │   │   │   ├── PinStackView.swift
        │   │   │   │   └── TitleView.swift
        │   │   │   └── ViewModel
        │   │   │       ├── FriendAdditionViewModel.swift
        │   │   │       └── TestLogic.Swift
        │   │   ├── GoalSetting
        │   │   │   └── View
        │   │   │       ├── GoalItem.swift
        │   │   │       ├── GoalSetting.swift
        │   │   │       └── GoalSettingTitleView.swift
        │   │   ├── LastOnboarding
        │   │   │   ├── View
        │   │   │   │   └── LastOnboardingView.swift
        │   │   │   └── ViewModel
        │   │   │       └── LastOnboardingViewModel.swift
        │   │   └── SettingPeriod
        │   │       └── SettingPeriod.swift
        │   └── ToGatherApp.swift
        └── ViewModels
            └── UserViewModel.swift

```
### :lock_with_ink_pen: License
MIT License

Copyright (c) 2022 SevenStandards

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


