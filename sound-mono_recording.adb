with
  Ada.Text_IO;
with
  Interfaces.C.Strings;

package body Sound.Mono_Recording is
   procedure Open (Line       : in out Line_Type;
                   Resolution : in out Sample_Frequency) is
      use Interfaces.C, Interfaces.C.Strings;
      Name       : aliased char_array := To_C ("plughw:0,0");
      Error      : Interfaces.C.int;
      Local_Line : aliased Line_Type := Line;
      Settings   : aliased Sound.ALSA.snd_pcm_hw_params_t;
   begin
      Error := snd_pcm_open (pcmp   => Local_Line'Access,
                             name   => To_Chars_Ptr (Name'Unchecked_Access),
                             stream => Sound.ALSA.Capture,
                             mode   => 0);
      if Error /= 0 then
         raise Program_Error with "Error code (snd_pcm_open): " & Error'Img;
      end if;

      Error := snd_pcm_hw_params_any (pcm    => Local_Line,
                                      params => Settings'Access);

      if Error /= 0 then
         raise Program_Error with
           "Error code (snd_pcm_hw_params_any): " & Error'Img;
      end if;

  Set_Sample_Frequency:
      declare
         Sample_Rate   : aliased Interfaces.C.unsigned :=
                           Interfaces.C.unsigned (Resolution);
         Approximation : aliased Sound.ALSA.Approximation_Direction := +1;
      begin
         Error := snd_pcm_hw_params_set_rate_near
                    (pcm    => Local_Line,
                     params => Settings'Access,
                     val    => Sample_Rate'Access,
                     dir    => Approximation'Access);

         if Error /= 0 then
            raise Program_Error with
              "Error code (snd_pcm_hw_params_set_rate_near): " & Error'Img;
         end if;

         Resolution := Sample_Frequency (Sample_Rate);
      end Set_Sample_Frequency;

  Set_Recording_Format:
      begin
         Error := snd_pcm_hw_params_set_format
                    (pcm    => Local_Line,
                     params => Settings'Access,
                     format => Sound.ALSA.Unsigned_16_Bit);

         if Error /= 0 then
            raise Program_Error;
         end if;
      end Set_Recording_Format;

      Line := Local_Line;
   end Open;

   function Is_Open (Line : in     Line_Type) return Boolean is
      use Sound.ALSA;
   begin
      case snd_pcm_state (Line) is
         when Prepared | Running =>
            return True;
         when Open | Setup | XRun | Draining | Paused | Suspended
                | Disconnected =>
            return False;
      end case;
   end Is_Open;

   procedure Close (Line : in out Line_Type) is
      use type Interfaces.C.int;
      Error : Interfaces.C.int;
   begin
      Error := snd_pcm_close (Line);

      if Error /= 0 then
         raise Program_Error;
      end if;
   end Close;

   procedure Read (Line : in     Line_Type;
                   Item :    out Frame_Array;
                   Last :    out Natural) is
      Frame_Pointer : access Frame := Item (Item'First)'Access;
      Void_Pointer  : Sound.ALSA.void_ptr;
      for Void_Pointer'Address use Frame_Pointer'Address;
      pragma Assert (Frame_Pointer'Size = Void_Pointer'Size);

      use type Sound.ALSA.snd_pcm_sframes_t;
      Received_Frame_Count : Sound.ALSA.snd_pcm_sframes_t;
   begin
      Received_Frame_Count := snd_pcm_readi
                                (pcm    => Line,
                                 buffer => Void_Pointer,
                                 size   => Item'Length);

      if Received_Frame_Count < 0 then
         raise Program_Error;
      else
         Last := Item'First - 1 + Natural (Received_Frame_Count);
      end if;
   end Read;
end Sound.Mono_Recording;
