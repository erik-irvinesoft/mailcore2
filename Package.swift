// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// TODO: move to toolchain
import Foundation

private func files(in folder: String, withExtension ext: Set<String>, anchor: String = #file) -> [String] {
    let baseURL = URL(fileURLWithPath: anchor)
        .deletingLastPathComponent()
        .appendingPathComponent(folder)

    let allFiles = FileManager.default
        .enumerator(atPath: baseURL.path)?
        .allObjects ?? []

    return allFiles
        .compactMap { $0 as? String }
        .map { URL(fileURLWithPath: $0) }
        .filter { ext.contains($0.pathExtension) }
        .map { folder + "/" + $0.relativePath } 
}
// end

let package = Package(
    name: "MailCore",
    defaultLocalization: "en",
    products: [
        .library(name: "MailCore", targets: ["CMailCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/readdle/libetpan.git", .branch("feature/spm-support")),
        .package(url: "https://github.com/readdle/tidy-html5.git", .branch("feature/spm-support")),
        .package(url: "https://github.com/readdle/ctemplate.git", .branch("feature/spm-support"))
    ],
    targets: [
        .target(
            name: "CMailCore",
            dependencies: [
                .product(name: "etpan", package: "libetpan"),
                .product(name: "RDHtml5Tidy", package: "tidy-html5"),
                .product(name: "ctemplate", package: "ctemplate")
            ],
            path: ".",
            exclude: files(in: "src", withExtension: ["mm"]) + [
                "src/core/zip/MiniZip/iowin32.c",
                "src/core/zip/MiniZip/miniunz.c",
                "src/core/zip/MiniZip/mztools.c",
                "src/core/zip/MiniZip/minizip.c",
                "src/core/zip/MiniZip/Makefile",
                "src/core/zip/MiniZip/make_vms.com",
                "src/core/zip/MiniZip/MiniZip64_info.txt",
                "src/core/zip/MiniZip/MiniZip64_Changes.txt",
                "src/core/basetypes/MCWin32.cpp",
                "src/core/basetypes/MCStringWin32.cpp",
                "src/core/basetypes/MCMainThreadGTK.cpp",
                "src/core/basetypes/MCMainThreadAndroid.cpp",
                "src/core/basetypes/MCMainThreadWin32.cpp",
                "src/core/basetypes/icu-ucsdet/cmemory.c",
                "src/core/basetypes/icu-ucsdet/csdetect.cpp",
                "src/core/basetypes/icu-ucsdet/csmatch.cpp",
                "src/core/basetypes/icu-ucsdet/csr2022.cpp",
                "src/core/basetypes/icu-ucsdet/csrecog.cpp",
                "src/core/basetypes/icu-ucsdet/csrmbcs.cpp",
                "src/core/basetypes/icu-ucsdet/csrsbcs.cpp",
                "src/core/basetypes/icu-ucsdet/csrucode.cpp",
                "src/core/basetypes/icu-ucsdet/csrutf8.cpp",
                "src/core/basetypes/icu-ucsdet/cstring.c",
                "src/core/basetypes/icu-ucsdet/inputext.cpp",
                "src/core/basetypes/icu-ucsdet/uarrsort.c",
                "src/core/basetypes/icu-ucsdet/ucln_cmn.cpp",
                "src/core/basetypes/icu-ucsdet/ucln_in.cpp",
                "src/core/basetypes/icu-ucsdet/ucsdet.cpp",
                "src/core/basetypes/icu-ucsdet/udataswp.c",
                "src/core/basetypes/icu-ucsdet/uenum.c",
                "src/core/basetypes/icu-ucsdet/uinvchar.c",
                "src/core/basetypes/icu-ucsdet/umutex.cpp",
                "src/core/basetypes/icu-ucsdet/uobject.cpp",
                "src/core/basetypes/icu-ucsdet/ustring.cpp",
                "src/core/basetypes/icu-ucsdet/utrace.c",
            ],
            sources: ["src/async", "src/c", "src/core"],
            cSettings: [
                .headerSearchPath("src/async/imap"),
                .headerSearchPath("src/async/pop"),
                .headerSearchPath("src/async/smtp"),
                .headerSearchPath("src/core/basetypes"),
                .headerSearchPath("src/core/zip/MiniZip"),
                .headerSearchPath("src/core/abstract"),
                .headerSearchPath("src/core/imap"),
                .headerSearchPath("src/core/nntp"),
                .headerSearchPath("src/core/pop"),
                .headerSearchPath("src/core/renderer"),
                .headerSearchPath("src/core/rfc822"),
                .headerSearchPath("src/core/security"),
                .headerSearchPath("src/core/smtp"),
                .headerSearchPath("src/core/zip"),
                .headerSearchPath("src/c"),
                .headerSearchPath("src/c/abstract"),
                .headerSearchPath("src/c/basetypes"),
                .headerSearchPath("src/c/imap"),
                .headerSearchPath("src/c/provider"),
                .headerSearchPath("src/c/rfc822"),
                .headerSearchPath("src/c/smtp"),
                .headerSearchPath("src/c/utils"),
                .define("ANDROID"),
                .unsafeFlags([
                    "-Wno-module-import-in-extern-c",
                ])
            ],
            linkerSettings: [
                .linkedLibrary("log"),
                .linkedLibrary("xml2"),
                .linkedLibrary("icuuc.73"),
                .linkedLibrary("icui18n.73"),
                .linkedLibrary("icudata.73"),
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
            ]
        ),
        .testTarget(
            name: "MailCoreTests", 
            dependencies: ["MailCore"],
            path: "unittest",
            sources: ["LibetpanHelperTests.swift", "unittest.swift"]
        )
    ],
    swiftLanguageVersions: [.v5],
    cxxLanguageStandard: .cxx11
)
