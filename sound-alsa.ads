with
  Interfaces.C,
  Interfaces.C.Strings;
with
  Sound.Constants;

private
package Sound.ALSA is
   type void_ptr is private;
   type snd_pcm_t_ptr is private;

   type snd_pcm_stream_t is (Playback, Capture);
   for snd_pcm_stream_t use (Playback => Sound.Constants.Playback_Stream,
                             Capture  => Sound.Constants.Capture_Stream);

   type snd_pcm_state_t is (Open, Setup, Prepared, Running, XRun, Draining,
                            Paused, Suspended, Disconnected);
   for snd_pcm_state_t use (Open         => Sound.Constants.State_Open,
                            Setup        => Sound.Constants.State_Setup,
                            Prepared     => Sound.Constants.State_Prepared,
                            Running      => Sound.Constants.State_Running,
                            XRun         => Sound.Constants.State_XRun,
                            Draining     => Sound.Constants.State_Draining,
                            Paused       => Sound.Constants.State_Paused,
                            Suspended    => Sound.Constants.State_Suspended,
                            Disconnected => Sound.Constants.State_Disconnected);

   type snd_pcm_hw_params_t_ptr is private;

   type snd_pcm_sframes_t is new Interfaces.C.long;
   type snd_pcm_uframes_t is new Interfaces.C.unsigned_long;

   function snd_pcm_open (pcmp   : access snd_pcm_t_ptr;
                          name   : in     Interfaces.C.Strings.chars_ptr;
                          stream : in     snd_pcm_stream_t;
                          mode   : in     Interfaces.C.int) return Interfaces.C.int;
   pragma Import (C, snd_pcm_open);

   function snd_pcm_state (pcm : in     snd_pcm_t_ptr) return snd_pcm_state_t;
   pragma Import (C, snd_pcm_state);

   function snd_pcm_hw_params (pcm    : in    snd_pcm_t_ptr;
                               params : in    snd_pcm_hw_params_t_ptr) return Interfaces.C.int;
   pragma Import (C, snd_pcm_hw_params);

   function snd_pcm_readi (pcm    : in snd_pcm_t_ptr;
                           buffer : in void_ptr;
                           size   : in snd_pcm_uframes_t) return snd_pcm_sframes_t;
   pragma Import (C, snd_pcm_readi);

   procedure allocate_alsa_hardware_parameters (hwparams_ptr : access snd_pcm_hw_params_t_ptr);
   pragma Import (C, allocate_alsa_hardware_parameters);
private
   type void_ptr is new Interfaces.C.Strings.chars_ptr;
   type snd_pcm_t_ptr is new Interfaces.C.Strings.chars_ptr;
   type snd_pcm_hw_params_t_ptr is new Interfaces.C.Strings.chars_ptr;
end Sound.ALSA;
