// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let ICUVersion = ProcessInfo.processInfo.environment["SWIFT_ANDROID_ICU_VERSION"] ?? ""

#if TARGET_ANDROID
let CMailCoreExtensionFiles: [String] = [
    "core/zip/MiniZip/zip.c",
    "core/zip/MiniZip/ioapi.c"
]
#else
let CMailCoreExtensionFiles: [String] = [
    "core/basetypes/MCMainThreadMac.mm",
    "core/basetypes/MCAutoreleasePoolMac.mm",
    "core/basetypes/MCObjectMac.mm",
    "core/zip/MCZipMac.mm",
    "objc/utils/MCOObjectWrapper.mm",
    "core/zip/MiniZip/zip.c",
    "core/zip/MiniZip/ioapi.c"
]
#endif

private func files(in folder: String, withExtension ext: Set<String>, anchor: String = #filePath) -> [String] {
    let baseURL = URL(fileURLWithPath: anchor)
        .deletingLastPathComponent()
        .appendingPathComponent("src")
        .appendingPathComponent(folder)

    let allFiles = FileManager.default
        .enumerator(atPath: baseURL.path)?
        .allObjects ?? []

    return allFiles
        .compactMap { $0 as? String }
        .map { URL(fileURLWithPath: $0) }
        .filter { ext.contains($0.pathExtension) || ext.contains($0.lastPathComponent) }
        .map { folder + "/" + $0.relativePath }
        .filter { !CMailCoreExtensionFiles.contains($0) }
}

let CMailCoreExcludes: [String] = files(in: "core", withExtension: ["mm"]) + 
                                  files(in: "objc", withExtension: ["mm"]) + 
                                  files(in: "core/zip/MiniZip", withExtension: ["c", "com", "txt", "Makefile"]) + 
                                  files(in: "core/basetypes/icu-ucsdet", withExtension: ["c", "cpp"])

let products: [Product] = [
    .library(name: "MailCore", type: .dynamic, targets: ["MailCore"]),
]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/readdle/libetpan.git", .branch("feature/spm-support")),
    .package(url: "https://github.com/readdle/tidy-html5.git", .branch("feature/spm-support")),
    .package(url: "https://github.com/readdle/ctemplate.git", .branch("feature/spm-support")),
    .package(name: "unicode", url: "https://github.com/readdle/swift-unicode", .exact("68.2.0"))
]

var targets: [Target] = [
    .target(
        name: "CMailCore",
        dependencies: [
            .product(name: "etpan", package: "libetpan"),
            .product(name: "RDHtml5Tidy", package: "tidy-html5"),
            .product(name: "ctemplate", package: "ctemplate"),
            .product(name: "unicode", package: "unicode", condition: .when(platforms: [.iOS, .macOS])),
        ],
        path: "src",
        exclude: [
            "core/basetypes/MCWin32.cpp",
            "core/basetypes/MCStringWin32.cpp",
            "core/basetypes/MCMainThreadGTK.cpp",
            "core/basetypes/MCMainThreadAndroid.cpp",
            "core/basetypes/MCMainThreadWin32.cpp"
        ] + CMailCoreExcludes,
        sources: [
            "async",
            "c",
            "core"
        ] + CMailCoreExtensionFiles,
        cSettings: [
            .headerSearchPath("async/imap"),
            .headerSearchPath("async/pop"),
            .headerSearchPath("async/smtp"),
            .headerSearchPath("core/basetypes"),
            .headerSearchPath("core/zip/MiniZip"),
            .headerSearchPath("core/abstract"),
            .headerSearchPath("core/basetypes"),
            .headerSearchPath("core/imap"),
            .headerSearchPath("core/nntp"),
            .headerSearchPath("core/pop"),
            .headerSearchPath("core/renderer"),
            .headerSearchPath("core/rfc822"),
            .headerSearchPath("core/security"),
            .headerSearchPath("core/smtp"),
            .headerSearchPath("core/zip"),
            .headerSearchPath("c"),
            .headerSearchPath("c/abstract"),
            .headerSearchPath("c/basetypes"),
            .headerSearchPath("c/imap"),
            .headerSearchPath("c/provider"),
            .headerSearchPath("c/rfc822"),
            .headerSearchPath("c/smtp"),
            .headerSearchPath("c/utils"),
            .headerSearchPath("objc/utils"),
            .define("ANDROID", .when(platforms: [.android])),
            .define("UCHAR_TYPE", to: "uint16_t", .when(platforms: [.macOS, .iOS])),
            .unsafeFlags(["-Wno-module-import-in-extern-c"]),
            .unsafeFlags(["-fsigned-char"], .when(platforms: [.android])),
            .unsafeFlags(["-fno-objc-arc"], .when(platforms: [.macOS, .iOS]))
        ],
        linkerSettings: [
            .linkedLibrary("z"),
            .linkedLibrary("xml2"),
            .linkedLibrary("resolv", .when(platforms: [.iOS, .macOS])),
            .linkedLibrary("log", .when(platforms: [.android])),
            .linkedLibrary("icuuc.\(ICUVersion)", .when(platforms: [.android])),
            .linkedLibrary("icui18n.\(ICUVersion)", .when(platforms: [.android])),
            .linkedLibrary("icudata.\(ICUVersion)", .when(platforms: [.android])),
        ]
    ),
    .target(
        name: "MailCore",
        dependencies: [
            .product(name: "etpan", package: "libetpan"),
            "CMailCore"
        ],
        path: "src/swift",
        exclude: [
            "utils/RSMLibetpanHelper.mm"
        ],
        linkerSettings: [
            .unsafeFlags(["-Xlinker", "-soname", "-Xlinker", "libMailCore.so"], .when(platforms: [.android]))
        ]
    ),
    .testTarget(
        name: "MailCoreTests", 
        dependencies: ["MailCore"],
        path: "unittest",
        exclude: [
            "Info.plist",
            "CMakeLists.txt",
            "unittest.cpp",
            "unittest.mm"
        ],
        sources: ["LibetpanHelperTests.swift", "unittest.swift"],
        resources: [
            .copy("data")
        ]
    )
]

let package = Package(
    name: "MailCore",
    defaultLocalization: "en",
    products: products,
    dependencies: dependencies,
    targets: targets,
    swiftLanguageVersions: [.v5],
    cxxLanguageStandard: .cxx11
)
