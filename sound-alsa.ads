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

   type snd_pcm_hw_params_t_ptr is private;

   type snd_pcm_sframes_t is new Interfaces.C.long;
   type snd_pcm_uframes_t is new Interfaces.C.unsigned_long;

   function snd_pcm_open (pcm    : access snd_pcm_t_ptr;
                          name   : in     Interfaces.C.Strings.chars_ptr;
                          stream : in     snd_pcm_stream_t;
                          mode   : in     Interfaces.C.int) return Interfaces.C.int;
   pragma Import (C, snd_pcm_open);

   function snd_pcm_hw_params (pcm    : in    snd_pcm_t_ptr;
                               params : in    snd_pcm_hw_params_t_ptr) return Interfaces.C.int;
   pragma Import (C, snd_pcm_hw_params);

   function snd_pcm_readi (pcm    : in snd_pcm_t_ptr;
                           buffer : in void_ptr;
                           size   : in snd_pcm_uframes_t) return snd_pcm_sframes_t;
   pragma Import (C, snd_pcm_readi);

private
   type void_ptr is new Interfaces.C.Strings.chars_ptr;
   type snd_pcm_t_ptr is new Interfaces.C.Strings.chars_ptr;
   type snd_pcm_hw_params_t_ptr is new Interfaces.C.Strings.chars_ptr;
end Sound.ALSA;
