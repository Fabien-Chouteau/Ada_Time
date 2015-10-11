#include <pebble.h>

void ada_watchface_init(void);
void ada_watchface_deinit(void);

extern int ada_patris_watchfaceinit ()  __attribute__((weak));;
extern int ada_patris_watchfacefinal ()  __attribute__((weak));;

extern int patris_commoninit ()  __attribute__((weak));;
extern int patris_commonfinal ()  __attribute__((weak));;

extern int pebble_bindinginit ()  __attribute__((weak));;
extern int pebble_bindingfinal ()  __attribute__((weak));;

int main(void) {
    /* Elaboration */
    if (ada_patris_watchfaceinit) {
        ada_patris_watchfaceinit();
    }

    if (patris_commoninit) {
        patris_commoninit();
    }

    if (pebble_bindinginit) {
        pebble_bindinginit();
    }

    ada_watchface_init();
    app_event_loop();
    ada_watchface_deinit();


    if (ada_patris_watchfacefinal) {
        ada_patris_watchfacefinal();
    }

    if (patris_commonfinal) {
        patris_commonfinal();
    }

    if (pebble_bindingfinal) {
        pebble_bindingfinal();
    }

}
