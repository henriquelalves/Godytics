#include "godytics.h"
#include "core/variant.h"
#include "core/message_queue.h"

#import <UIKit/UIKit.h>

#if VERSION_MAJOR == 3
#define CLASS_DB ClassDB
#include <core/engine.h>
#else
#define CLASS_DB ObjectTypeDB
#include "core/globals.h"
#endif

Godytics* GODYTICS_INSTANCE = NULL;

Godytics::Godytics() {
    ERR_FAIL_COND(GODYTICS_INSTANCE != NULL);
    GODYTICS_INSTANCE = this;
    initialized = false;
}

Godytics::~Godytics() {
    GODYTICS_INSTANCE = NULL;
}

void Godytics::init(const String &tId) {
  [[GAI sharedInstance] setDispatchInterval:30];
  [[GAI sharedInstance] setDryRun:NO];

  NSString * kGaPropertyId = [NSString stringWithCString:tId.utf8().get_data() encoding:NSUTF8StringEncoding];
  tracker = [[GAI sharedInstance] trackerWithTrackingId:kGaPropertyId];
  initialized = true;
}

void Godytics::screen(const String &name) {
  if(initialized) {
    NSString * screenName = [NSString stringWithCString:name.utf8().get_data() encoding:NSUTF8StringEncoding];
    [tracker set:kGAIScreenName value:screenName];
    [tracker send:[[GAIDictionaryBuilder createScreenView]  build]];
  }
}

void Godytics::event(const String &cat, const String &act, const String &lab, int val) {
    if(initialized) {
        NSString * category = [NSString stringWithCString:cat.utf8().get_data() encoding:NSUTF8StringEncoding];
        NSString * action = [NSString stringWithCString:act.utf8().get_data() encoding:NSUTF8StringEncoding];
        NSString * label = [NSString stringWithCString:lab.utf8().get_data() encoding:NSUTF8StringEncoding];
        NSNumber * value = [NSNumber numberWithInt:val];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category action:action label:label value:value] build]];
    }
}

void Godytics::_bind_methods() {
    CLASS_DB::bind_method("init",&Godytics::init);
    CLASS_DB::bind_method("screen",&Godytics::screen);
    CLASS_DB::bind_method("event",&Godytics::event);
}
