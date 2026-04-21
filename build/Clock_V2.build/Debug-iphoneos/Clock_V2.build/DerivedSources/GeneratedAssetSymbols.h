#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "Happy" asset catalog image resource.
static NSString * const ACImageNameHappy AC_SWIFT_PRIVATE = @"Happy";

/// The "Mid" asset catalog image resource.
static NSString * const ACImageNameMid AC_SWIFT_PRIVATE = @"Mid";

/// The "Sad" asset catalog image resource.
static NSString * const ACImageNameSad AC_SWIFT_PRIVATE = @"Sad";

#undef AC_SWIFT_PRIVATE
