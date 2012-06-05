#include <alsa/asoundlib.h>

void allocate_alsa_hardware_parameters (snd_pcm_hw_params_t **hwparams_ptr) {
   snd_pcm_hw_params_alloca (hwparams_ptr);
};
