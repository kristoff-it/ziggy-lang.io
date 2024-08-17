const std = @import("std");
const zine = @import("zine");

pub fn build(b: *std.Build) !void {
    zine.website(b, .{
        .title = "Ziggy",
        .host_url = "https://ziggy-lang.io",
        .layouts_dir_path = "layouts",
        .content_dir_path = "content",
        .assets_dir_path = "assets",
        .static_assets = &.{
            "CNAME",
            "BenchNine-Bold.ttf",
            "Gluegun.otf",
            "Epilogue/Epilogue-Black.ttf",
            "Epilogue/Epilogue-BlackItalic.ttf",
            "Epilogue/Epilogue-Bold.ttf",
            "Epilogue/Epilogue-BoldItalic.ttf",
            "Epilogue/Epilogue-ExtraBold.ttf",
            "Epilogue/Epilogue-ExtraBoldItalic.ttf",
            "Epilogue/Epilogue-ExtraLight.ttf",
            "Epilogue/Epilogue-ExtraLightItalic.ttf",
            "Epilogue/Epilogue-Italic.ttf",
            "Epilogue/Epilogue-Light.ttf",
            "Epilogue/Epilogue-LightItalic.ttf",
            "Epilogue/Epilogue-Medium.ttf",
            "Epilogue/Epilogue-MediumItalic.ttf",
            "Epilogue/Epilogue-Regular.ttf",
            "Epilogue/Epilogue-SemiBold.ttf",
            "Epilogue/Epilogue-SemiBoldItalic.ttf",
            "Epilogue/Epilogue-Thin.ttf",
            "Epilogue/Epilogue-ThinItalic.ttf",
        },
        .debug = true,
    });
}
