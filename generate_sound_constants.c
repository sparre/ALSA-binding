#include <stdio.h>
#include <alsa/asoundlib.h>

int main() {
   printf ("package Sound.Constants is\n");
   printf ("   Stream_Capture    : constant := %u;\n", (unsigned int)SND_PCM_STREAM_CAPTURE);
   printf ("   State_Prepared    : constant := %u;\n", (unsigned int)SND_PCM_STATE_PREPARED);
   printf ("   State_Running     : constant := %u;\n", (unsigned int)SND_PCM_STATE_RUNNING);
   printf ("end Sound.Constants;\n");
   return 0;
};
