#  Color Palette

The purpose of this document is to be a step by step guide on how to support multiple color palettes in your app

### Interesting articles
* [Creating Slick Color Palette APIs](https://www.fabisevi.ch/2021/08/24/creating-slick-color-palette-apis/)
* [Building your Color Palette](https://www.refactoringui.com/previews/building-your-color-palette)

## Cherry-Pick the Color Palette support 🍒
1. Follow the steps described in the [Creating Slick Color Palette APIs](https://www.fabisevi.ch/2021/08/24/creating-slick-color-palette-apis/) article
2. For inspiration in this project, you can check out the UIColor extensions:
    * [UIColor+Hex](../SwiftyPick/Presentation/Extension/UIColor+Hex.swift)
    * [UIColor+Name](../SwiftyPick/Presentation/Extension/UIColor+Name.swift)
    * [UIColor+Palette](../SwiftyPick/Presentation/Extension/UIColor+Hex.swift)
3. You can also checkout the unit tests:
    * [ColorTests](../SwiftyPickTests/Resources/ColorTests.swift)

## Demo
| Default Palette Light Mode | Default Palette Dark Mode |
| - | - |
|<img src="https://user-images.githubusercontent.com/5333984/131167389-70a9cded-8ede-4a6f-b0ef-42927e021bdd.png" width="400px">|<img src="https://user-images.githubusercontent.com/5333984/131167393-dca08ff3-b656-4fa8-881d-8e4ef2381d96.png" width="400px">|

| Flashy Palette Light Mode | Flashy Palette Dark Mode |
| - | - |
|<img src="https://user-images.githubusercontent.com/5333984/131167471-670ae53c-2f10-4230-abd6-3fcaaaf28b30.png" width="400px">|<img src="https://user-images.githubusercontent.com/5333984/131167477-065ad134-9582-4c03-ad74-4a52f1059fc6.png" width="400px">|
