#include <version_generated.gen.h>

#if VERSION_MAJOR == 3
#include <core/class_db.h>
#include <core/engine.h>
#else
#include "object_type_db.h"
#include "core/globals.h"
#endif

#include "register_types.h"
#include "ios/src/godytics.h"

void register_godytics_types() {
#if VERSION_MAJOR == 3
    Engine::get_singleton()->add_singleton(Engine::Singleton("Godytics", memnew(Godytics)));
#else
    Globals::get_singleton()->add_singleton(Globals::Singleton("Godytics", memnew(Godytics)));
#endif
}

void unregister_godytics_types() {
}
