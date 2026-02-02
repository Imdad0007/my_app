#ifndef FLUTTER_attendanceLICATION_H_
#define FLUTTER_attendanceLICATION_H_

#include <gtk/gtk.h>

G_DECLARE_FINAL_TYPE(MyApplication,
                     attendancelication,
                     MY,
                     APPLICATION,
                     GtkApplication)

/**
 * attendancelication_new:
 *
 * Creates a new Flutter-based application.
 *
 * Returns: a new #MyApplication.
 */
MyApplication* attendancelication_new();

#endif  // FLUTTER_attendanceLICATION_H_
