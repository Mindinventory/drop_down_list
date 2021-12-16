#import "DropDownPlugin.h"
#if __has_include(<drop_down_plugin/drop_down_plugin-Swift.h>)
#import <drop_down_plugin/drop_down_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "drop_down_plugin-Swift.h"
#endif

@implementation DropDownPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDropDownPlugin registerWithRegistrar:registrar];
}
@end
