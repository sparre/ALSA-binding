with
  Interfaces.C.Strings;

package body Sound.Mono_Recording is
   procedure Open (Line       : in out Line_Type;
                   Resolution : in out Sample_Frequency) is
      use Interfaces.C, Interfaces.C.Strings;
      Name       : aliased char_array := To_C ("hw:0,0");
      Error      : Interfaces.C.int;
      Local_Line : aliased Line_Type := Line;
      Settings   : aliased Sound.ALSA.snd_pcm_hw_params_t_ptr;
   begin
      Error := snd_pcm_open (pcmp   => Local_Line'Access,
                             name   => To_Chars_Ptr (Name'Unchecked_Access),
                             stream => Sound.ALSA.Capture,
                             mode   => 0);
      if Error /= 0 then
         raise Program_Error;
      end if;

      Sound.ALSA.allocate_alsa_hardware_parameters
        (hwparams_ptr => Settings'Access);

  Set_Sample_Frequency:
      declare
         Sample_Rate   : aliased Interfaces.C.unsigned :=
                           Interfaces.C.unsigned (Resolution);
         Approximation : aliased Sound.ALSA.Approximation_Direction := +1;
      begin
         Error := snd_pcm_hw_params_set_rate_near
                    (pcm    => Local_Line,
                     params => Settings,
                     val    => Sample_Rate'Access,
                     dir    => Approximation'Access);

         if Error /= 0 then
            raise Program_Error;
         end if;

         Resolution := Sample_Frequency (Sample_Rate);
      end Set_Sample_Frequency;

  Set_Recording_Format:
      begin
         Error := snd_pcm_hw_params_set_format
                    (pcm    => Local_Line,
                     params => Settings,
                     format => Sound.ALSA.Unsigned_16_Bit_Little_Endian);

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
