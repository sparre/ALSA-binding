private with Sound.ALSA;

package Sound.Mono_Recording is
   type Line_Type is private;

   type Frame is range 0 .. 2 ** 16 - 1;
   for Frame'Size use 16;
   type Frame_Array is array (Positive range <>) of aliased Frame;

   procedure Open (Line       : in out Line_Type;
                   Resolution : in out Sample_Frequency);
   function Is_Open (Line : in     Line_Type) return Boolean;
   procedure Close (Line : in out Line_Type);
   procedure Read (Line : in     Line_Type;
                   Item :    out Frame_Array;
                   Last :    out Natural);
private
   type Line_Type is new Sound.ALSA.snd_pcm_t_ptr;
end Sound.Mono_Recording;
