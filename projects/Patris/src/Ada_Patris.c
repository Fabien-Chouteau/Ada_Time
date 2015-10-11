#include <pebble.h>

uint32_t icon_play_resource_id = RESOURCE_ID_PLAY;
uint32_t icon_menu_resource_id = RESOURCE_ID_MENU;
uint32_t splash_resource_id = RESOURCE_ID_SPLASH;

void ada_main(void);

extern int ada_patrisinit ()  __attribute__((weak));;
extern int ada_patrisfinal ()  __attribute__((weak));;

int main(void) {

    /* Elaboration */
    if (ada_patrisinit) {
        ada_patrisinit();
    }

    ada_main();

    if (ada_patrisfinal) {
        ada_patrisfinal();
    }
}
