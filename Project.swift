import ProjectDescription

let debugAction: ExecutionAction = .executionAction(scriptText: "echo Debug", target: "CommentTikTokView")
let userScheme: Scheme = .scheme(
    name: "CommentTikTokView-Staging",
    shared: false,
    buildAction: .buildAction(targets: ["CommentTikTokView"], preActions: [debugAction]),
    runAction: .runAction(executable: "App")
)

let debugScheme: Scheme = .scheme(
    name: "CommentTikTokView-Debug",
    shared: true,
    hidden: false,
    buildAction: .buildAction(
        targets: ["CommentTikTokView"],
        preActions: [debugAction],
        runPostActionsOnFailure: true
    )
)

let releaseAction: ExecutionAction = .executionAction(scriptText: "echo Release", target: "CommentTikTokView")
let releaseScheme: Scheme = .scheme(
    name: "CommentTikTokView-Release",
    shared: true,
    buildAction: .buildAction(targets: ["CommentTikTokView"], preActions: [releaseAction])
)

let project = Project(
    name: "CommentTikTokView",
    targets: [
        .target(
            name: "CommentTikTokView",
            destinations: .iOS,
            product: .app,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["CommentTikTokView/Sources/**"],
            resources: ["CommentTikTokView/Resources/**"],
            dependencies: [],
            settings: .settings(
                base: [:],
                configurations: [
                    .debug(name: "Debug", xcconfig: "Tuist/ConfigurationFiles/Debug.xcconfig"),
                    .release(
                        name: "Release",
                        xcconfig: "Tuist/ConfigurationFiles/Release.xcconfig"
                    ),
                    .release(
                        name: "Stagging",
                        xcconfig: "Tuist/ConfigurationFiles/Staging.xcconfig"
                    ),
                ]
            )
        ),
        .target(
            name: "CommentTikTokViewTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.iletai.CommentTikTokViewTests",
            infoPlist: .default,
            sources: ["CommentTikTokView/Tests/**"],
            resources: [],
            dependencies: [.target(name: "CommentTikTokView")]
        )
    ],
    schemes: [
        debugScheme,
        userScheme,
        releaseScheme,
    ]
)
