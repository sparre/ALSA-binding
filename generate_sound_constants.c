#include <stdio.h>
#include <alsa/asoundlib.h>

int main() {
   printf ("package Sound.Constants is\n");
   printf ("   Playback_Stream   : constant := %u;\n", (unsigned int)SND_PCM_STREAM_PLAYBACK);
   printf ("   Capture_Stream    : constant := %u;\n", (unsigned int)SND_PCM_STREAM_CAPTURE);
   printf ("\n");
   printf ("   State_Open         : constant := %u;\n", (unsigned int)SND_PCM_STATE_OPEN);
   printf ("   State_Setup        : constant := %u;\n", (unsigned int)SND_PCM_STATE_SETUP);
   printf ("   State_Prepared     : constant := %u;\n", (unsigned int)SND_PCM_STATE_PREPARED);
   printf ("   State_Running      : constant := %u;\n", (unsigned int)SND_PCM_STATE_RUNNING);
   printf ("   State_XRun         : constant := %u;\n", (unsigned int)SND_PCM_STATE_XRUN);
   printf ("   State_Draining     : constant := %u;\n", (unsigned int)SND_PCM_STATE_DRAINING);
   printf ("   State_Paused       : constant := %u;\n", (unsigned int)SND_PCM_STATE_PAUSED);
   printf ("   State_Suspended    : constant := %u;\n", (unsigned int)SND_PCM_STATE_SUSPENDED);
   printf ("   State_Disconnected : constant := %u;\n", (unsigned int)SND_PCM_STATE_DISCONNECTED);
   printf ("\n");
   printf ("   Sound_Stream_Non_Blocking : constant := %u;\n", (unsigned int)SND_PCM_NONBLOCK);
   printf ("   Sound_Stream_Asynchronous : constant := %u;\n", (unsigned int)SND_PCM_ASYNC);
   printf ("\n");
   printf ("   Error_Bad_File_Descriptor : constant := %u;\n", (unsigned int)EBADFD);
   printf ("   Error_Pipe                : constant := %u;\n", (unsigned int)EPIPE);
   printf ("   Error_Stream_Pipe         : constant := %u;\n", (unsigned int)ESTRPIPE);
   printf ("end Sound.Constants;\n");
   return 0;
};
