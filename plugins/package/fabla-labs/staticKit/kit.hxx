
#ifndef FABLA2_STATIC_KIT_HXX
#define FABLA2_STATIC_KIT_HXX

#include "hat.hxx"
#include "hat_open.hxx"
#include "hat_sizzle.hxx"
#include "ride.hxx"
#include "kick.hxx"
#include "snare.hxx"
#include "snare_clean.hxx"
#include "snare_rim_clean.hxx"

struct Samp
{
  int size;
  float* data;
};

static Samp samps[8] = {
{
  kick::size,
  kick::wavetable
},
{
  snare::size,
  snare::wavetable
},
{
  snare_clean::size,
  snare_clean::wavetable
},
{
  hat::size,
  hat::wavetable
},
{
  ride::size,
  ride::wavetable
},
{
  snare_rim_clean::size,
  snare_rim_clean::wavetable
},
{
  hat_sizzle::size,
  hat_sizzle::wavetable
},
{
  hat_open::size,
  hat_open::wavetable
},

};

#endif /* FABLA2_STATIC_KIT_HXX */
