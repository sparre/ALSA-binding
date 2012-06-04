with
  Interfaces.C.Strings;

package body Sound.Mono_Recording is
   procedure Open (Line : in out Line_Type) is
      use Interfaces.C, Interfaces.C.Strings;
      Name       : aliased char_array := To_C ("hw:0,0");
      Error      : Interfaces.C.int;
      Local_Line : aliased Line_Type := Line;
   begin
      Error := snd_pcm_open (pcmp   => Local_Line'Access,
                             name   => To_Chars_Ptr (Name'Unchecked_Access),
                             stream => Sound.ALSA.Capture,
                             mode   => 0);
      if Error /= 0 then
         raise Program_Error;
      end if;
      Line := Local_Line;
   end Open;

   function Is_Open (Line : in     Line_Type) return Boolean is
      use Sound.ALSA;
   begin
      case snd_pcm_state (Line) is
         when Prepared | Running =>
            return True;
         when Open | Setup | XRun | Draining | Paused | Suspended | Disconnected =>
            return False;
      end case;
   end Is_Open;

   procedure Close (Line : in out Line_Type) is
   begin
      raise Program_Error;
   end Close;

   procedure Read (Line : in     Line_Type;
                   Item :    out Frame_Array;
                   Last :    out Natural) is
   begin
      raise Program_Error;
   end Read;
end Sound.Mono_Recording;
