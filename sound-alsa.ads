with
  Interfaces.C,
  Interfaces.C.Strings;
with
  Sound.Constants;

private
package Sound.ALSA is
   use type Interfaces.C.int;

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

   type snd_pcm_format_t is (Unknown,
                             Signed_8_Bit,
                             Unsigned_8_Bit,
                             Signed_16_Bit_Little_Endian,
                             Signed_16_Bit_Big_Endian,
                             Unsigned_16_Bit_Little_Endian,
                             Unsigned_16_Bit_Big_Endian,
                             Signed_24_Bit_Little_Endian,
                             Signed_24_Bit_Big_Endian,
                             Unsigned_24_Bit_Little_Endian,
                             Unsigned_24_Bit_Big_Endian,
                             Signed_32_Bit_Little_Endian,
                             Signed_32_Bit_Big_Endian,
                             Unsigned_32_Bit_Little_Endian,
                             Unsigned_32_Bit_Big_Endian,
                             FLOAT_Little_Endian,
                             FLOAT_Big_Endian,
                             FLOAT64_Little_Endian,
                             FLOAT64_Big_Endian,
                             IEC958_SUBFRAME_Little_Endian,
                             IEC958_SUBFRAME_Big_Endian,
                             MU_LAW,
                             A_LAW,
                             IMA_ADPCM,
                             MPEG,
                             GSM,
                             SPECIAL,
                             S24_3LE,
                             S24_3BE,
                             U24_3LE,
                             U24_3BE,
                             S20_3LE,
                             S20_3BE,
                             U20_3LE,
                             U20_3BE,
                             S18_3LE,
                             S18_3BE,
                             U18_3LE,
                             U18_3BE);
   for snd_pcm_format_t use
     (Unknown                       => Sound.Constants.Format_Unknown,
      Signed_8_Bit                  => Sound.Constants.Format_Signed_8_Bit,
      Unsigned_8_Bit                => Sound.Constants.Format_Unsigned_8_Bit,
      Signed_16_Bit_Little_Endian   => Sound.Constants.Format_Signed_16_Bit_Little_Endian,
      Signed_16_Bit_Big_Endian      => Sound.Constants.Format_Signed_16_Bit_Big_Endian,
      Unsigned_16_Bit_Little_Endian => Sound.Constants.Format_Unsigned_16_Bit_Little_Endian,
      Unsigned_16_Bit_Big_Endian    => Sound.Constants.Format_Unsigned_16_Bit_Big_Endian,
      Signed_24_Bit_Little_Endian   => Sound.Constants.Format_Signed_24_Bit_Little_Endian,
      Signed_24_Bit_Big_Endian      => Sound.Constants.Format_Signed_24_Bit_Big_Endian,
      Unsigned_24_Bit_Little_Endian => Sound.Constants.Format_Unsigned_24_Bit_Little_Endian,
      Unsigned_24_Bit_Big_Endian    => Sound.Constants.Format_Unsigned_24_Bit_Big_Endian,
      Signed_32_Bit_Little_Endian   => Sound.Constants.Format_Signed_32_Bit_Little_Endian,
      Signed_32_Bit_Big_Endian      => Sound.Constants.Format_Signed_32_Bit_Big_Endian,
      Unsigned_32_Bit_Little_Endian => Sound.Constants.Format_Unsigned_32_Bit_Little_Endian,
      Unsigned_32_Bit_Big_Endian    => Sound.Constants.Format_Unsigned_32_Bit_Big_Endian,
      FLOAT_Little_Endian           => Sound.Constants.Format_FLOAT_LE,
      FLOAT_Big_Endian              => Sound.Constants.Format_FLOAT_BE,
      FLOAT64_Little_Endian         => Sound.Constants.Format_FLOAT64_LE,
      FLOAT64_Big_Endian            => Sound.Constants.Format_FLOAT64_BE,
      IEC958_SUBFRAME_Little_Endian => Sound.Constants.Format_IEC958_SUBFRAME_LE,
      IEC958_SUBFRAME_Big_Endian    => Sound.Constants.Format_IEC958_SUBFRAME_BE,
      MU_LAW                        => Sound.Constants.Format_MU_LAW,
      A_LAW                         => Sound.Constants.Format_A_LAW,
      IMA_ADPCM                     => Sound.Constants.Format_IMA_ADPCM,
      MPEG                          => Sound.Constants.Format_MPEG,
      GSM                           => Sound.Constants.Format_GSM,
      SPECIAL                       => Sound.Constants.Format_SPECIAL,
      S24_3LE                       => Sound.Constants.Format_S24_3LE,
      S24_3BE                       => Sound.Constants.Format_S24_3BE,
      U24_3LE                       => Sound.Constants.Format_U24_3LE,
      U24_3BE                       => Sound.Constants.Format_U24_3BE,
      S20_3LE                       => Sound.Constants.Format_S20_3LE,
      S20_3BE                       => Sound.Constants.Format_S20_3BE,
      U20_3LE                       => Sound.Constants.Format_U20_3LE,
      U20_3BE                       => Sound.Constants.Format_U20_3BE,
      S18_3LE                       => Sound.Constants.Format_S18_3LE,
      S18_3BE                       => Sound.Constants.Format_S18_3BE,
      U18_3LE                       => Sound.Constants.Format_U18_3LE,
      U18_3BE                       => Sound.Constants.Format_U18_3BE);
   for snd_pcm_format_t'Size use Interfaces.C.int'Size;
   function Signed_16_Bit return snd_pcm_format_t;
   function Unsigned_16_Bit return snd_pcm_format_t;

   type snd_pcm_hw_params_t_ptr is private;

   type snd_pcm_sframes_t is new Interfaces.C.long;
   type snd_pcm_uframes_t is new Interfaces.C.unsigned_long;

   function snd_pcm_open
     (pcmp   : access snd_pcm_t_ptr;
      name   : in     Interfaces.C.Strings.chars_ptr;
      stream : in     snd_pcm_stream_t;
      mode   : in     Interfaces.C.int) return Interfaces.C.int;
   pragma Import (C, snd_pcm_open);

   function snd_pcm_state (pcm : in     snd_pcm_t_ptr) return snd_pcm_state_t;
   pragma Import (C, snd_pcm_state);

   function snd_pcm_hw_params
     (pcm    : in    snd_pcm_t_ptr;
      params : in    snd_pcm_hw_params_t_ptr) return Interfaces.C.int;
   pragma Import (C, snd_pcm_hw_params);

   subtype Approximation_Direction is Interfaces.C.int range -1 .. 1;

   function snd_pcm_hw_params_set_rate_near
     (pcm    : in     snd_pcm_t_ptr;
      params : in     snd_pcm_hw_params_t_ptr;
      val    : access Interfaces.C.unsigned;
      dir    : access Approximation_Direction) return Interfaces.C.int;
   pragma Import (C, snd_pcm_hw_params_set_rate_near);

   function snd_pcm_hw_params_set_format
     (pcm    : in     snd_pcm_t_ptr;
      params : in     snd_pcm_hw_params_t_ptr;
      format : in     snd_pcm_format_t) return Interfaces.C.int;
   pragma Import (C, snd_pcm_hw_params_set_format);

   function snd_pcm_readi
     (pcm    : in snd_pcm_t_ptr;
      buffer : in void_ptr;
      size   : in snd_pcm_uframes_t) return snd_pcm_sframes_t;
   pragma Import (C, snd_pcm_readi);

   procedure allocate_alsa_hardware_parameters
     (hwparams_ptr : access snd_pcm_hw_params_t_ptr);
   pragma Import (C, allocate_alsa_hardware_parameters);
private
   type void_ptr is new Interfaces.C.Strings.chars_ptr;
   type snd_pcm_t_ptr is new Interfaces.C.Strings.chars_ptr;
   type snd_pcm_hw_params_t_ptr is new Interfaces.C.Strings.chars_ptr;
end Sound.ALSA;
