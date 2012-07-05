with Ada.Text_IO;
with Sound.Mono_Recording;

procedure Test_ALSA_Binding is
   Microphone  : Sound.Mono_Recording.Line_Type;
   Resolution  : Sound.Sample_Frequency := 44_100;
   Buffer_Size : Duration := 0.5;
   Period      : Duration := 0.1;
   Recording   : Sound.Mono_Recording.Frame_Array (1 .. 44_100);
   Filled_To   : Natural;
begin
   Sound.Mono_Recording.Open (Line        => Microphone,
                              Resolution  => Resolution,
                              Buffer_Size => Buffer_Size,
                              Period      => Period);
   Ada.Text_IO.Put_Line
     (File => Ada.Text_IO.Standard_Error,
      Item => "Resolution [samples/s]: " &
              Sound.Sample_Frequency'Image (Resolution));
   Ada.Text_IO.Put_Line
     (File => Ada.Text_IO.Standard_Error,
      Item => "Buffer size [s]: " & Duration'Image (Buffer_Size));
   Ada.Text_IO.Put_Line
     (File => Ada.Text_IO.Standard_Error,
      Item => "Period [s]: " & Duration'Image (Period));
   Sound.Mono_Recording.Read (Line => Microphone,
                              Item => Recording,
                              Last => Filled_To);
   Sound.Mono_Recording.Close (Line => Microphone);

   for Index in Recording'First .. Filled_To loop
      Ada.Text_IO.Put_Line (Recording (Index)'Img);
   end loop;
end Test_ALSA_Binding;
