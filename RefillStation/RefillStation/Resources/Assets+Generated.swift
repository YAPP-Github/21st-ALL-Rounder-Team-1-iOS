// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {
    internal static let correct = ColorAsset(name: "Correct")
    internal static let error = ColorAsset(name: "Error")
    internal static let gray0 = ColorAsset(name: "Gray0")
    internal static let gray1 = ColorAsset(name: "Gray1")
    internal static let gray2 = ColorAsset(name: "Gray2")
    internal static let gray3 = ColorAsset(name: "Gray3")
    internal static let gray4 = ColorAsset(name: "Gray4")
    internal static let gray5 = ColorAsset(name: "Gray5")
    internal static let gray6 = ColorAsset(name: "Gray6")
    internal static let gray7 = ColorAsset(name: "Gray7")
    internal static let kakao = ColorAsset(name: "Kakao")
    internal static let lv1Light = ColorAsset(name: "Lv.1 light")
    internal static let lv1 = ColorAsset(name: "Lv.1")
    internal static let lv2Light = ColorAsset(name: "Lv.2 light")
    internal static let lv2 = ColorAsset(name: "Lv.2")
    internal static let lv3Light = ColorAsset(name: "Lv.3 light")
    internal static let lv3 = ColorAsset(name: "Lv.3")
    internal static let naver = ColorAsset(name: "Naver")
    internal static let primary1 = ColorAsset(name: "Primary1")
    internal static let primary10 = ColorAsset(name: "Primary10")
    internal static let primary2 = ColorAsset(name: "Primary2")
    internal static let primary3 = ColorAsset(name: "Primary3")
    internal static let primary4 = ColorAsset(name: "Primary4")
    internal static let primary5 = ColorAsset(name: "Primary5")
    internal static let primary6 = ColorAsset(name: "Primary6")
    internal static let primary7 = ColorAsset(name: "Primary7")
    internal static let primary8 = ColorAsset(name: "Primary8")
    internal static let primary9 = ColorAsset(name: "Primary9")
  }
  internal enum Images {
    internal static let checkbox = ImageAsset(name: "Checkbox")
    internal static let iconMy = ImageAsset(name: "Icon_My")
    internal static let iconSearch = ImageAsset(name: "Icon_Search")
    internal static let iconApple = ImageAsset(name: "Icon_apple")
    internal static let iconKakao = ImageAsset(name: "Icon_kakao")
    internal static let iconNaver = ImageAsset(name: "Icon_naver")
    internal static let iconPump = ImageAsset(name: "Icon_pump")
    internal static let avatar = ImageAsset(name: "avatar")
    internal static let cryFace = ImageAsset(name: "cry_face")
    internal static let iconAlbum = ImageAsset(name: "icon_Album")
    internal static let iconKebab = ImageAsset(name: "icon_Kebab")
    internal static let iconTrashcan = ImageAsset(name: "icon_Trashcan")
    internal static let iconArrowBottomSmall = ImageAsset(name: "icon_arrow_bottom_small")
    internal static let iconArrowLeft = ImageAsset(name: "icon_arrow_left")
    internal static let iconArrowRightSmall = ImageAsset(name: "icon_arrow_right_small")
    internal static let iconArrowTopSmall = ImageAsset(name: "icon_arrow_top_small")
    internal static let iconBell = ImageAsset(name: "icon_bell")
    internal static let iconCall = ImageAsset(name: "icon_call")
    internal static let iconClock = ImageAsset(name: "icon_clock")
    internal static let iconClose = ImageAsset(name: "icon_close")
    internal static let iconClosePhoto = ImageAsset(name: "icon_close_photo")
    internal static let iconDirection = ImageAsset(name: "icon_direction")
    internal static let iconEdit = ImageAsset(name: "icon_edit")
    internal static let iconLink = ImageAsset(name: "icon_link")
    internal static let iconLocation = ImageAsset(name: "icon_location")
    internal static let iconOperationCall = ImageAsset(name: "icon_operation_call")
    internal static let iconOperationLink = ImageAsset(name: "icon_operation_link")
    internal static let iconPhoto = ImageAsset(name: "icon_photo")
    internal static let iconPosition = ImageAsset(name: "icon_position")
    internal static let iconSns = ImageAsset(name: "icon_sns")
    internal static let iconSocialloginKakao = ImageAsset(name: "icon_sociallogin_Kakao")
    internal static let iconSocialloginApple = ImageAsset(name: "icon_sociallogin_apple")
    internal static let iconSocialloginNaver = ImageAsset(name: "icon_sociallogin_naver")
    internal static let iconThumbsup = ImageAsset(name: "icon_thumbsup")
    internal static let iconThumbsupFill = ImageAsset(name: "icon_thumbsup_fill")
    internal static let iconWrite = ImageAsset(name: "icon_write")
    internal static let imageLocationInfo = ImageAsset(name: "image_location info")
    internal static let imgKeywordClean = ImageAsset(name: "img_keyword_clean")
    internal static let imgKeywordKind = ImageAsset(name: "img_keyword_kind")
    internal static let imgKeywordNoKeyword = ImageAsset(name: "img_keyword_no keyword")
    internal static let imgKeywordPoint = ImageAsset(name: "img_keyword_point")
    internal static let imgKeywordPosition = ImageAsset(name: "img_keyword_position")
    internal static let imgKeywordPrice = ImageAsset(name: "img_keyword_price")
    internal static let imgKeywordProduct = ImageAsset(name: "img_keyword_product")
    internal static let imgKeywordStore = ImageAsset(name: "img_keyword_store")
    internal static let imgOnboarding1 = ImageAsset(name: "img_onboarding1")
    internal static let imgOnboarding2 = ImageAsset(name: "img_onboarding2")
    internal static let imgOnboarding3 = ImageAsset(name: "img_onboarding3")
    internal static let imgServiceArea = ImageAsset(name: "img_service area")
    internal static let levelBeginner = ImageAsset(name: "level_beginner")
    internal static let levelFancier = ImageAsset(name: "level_fancier")
    internal static let levelProspect = ImageAsset(name: "level_prospect")
    internal static let levelRegular = ImageAsset(name: "level_regular")
    internal static let loginbackground = ImageAsset(name: "loginbackground")
    internal static let profileImageGroup = ImageAsset(name: "profileImageGroup")
    internal static let selectedBox = ImageAsset(name: "selectedBox")
    internal static let storeDefualtImage = ImageAsset(name: "store defualt image")
    internal static let unselectedBox = ImageAsset(name: "unselectedBox")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
