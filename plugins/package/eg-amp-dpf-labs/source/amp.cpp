/*
  Copyright 2016 Filipe Coelho <falktx@falktx.com>

  Permission to use, copy, modify, and/or distribute this software for any
  purpose with or without fee is hereby granted, provided that the above
  copyright notice and this permission notice appear in all copies.

  THIS SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/

/** Include DPF */
#include "DistrhoPlugin.hpp"

/** Define a macro for converting a gain in dB to a coefficient. */
#define DB_CO(g) ((g) > -90.0f ? powf(10.0f, (g) * 0.05f) : 0.0f)

/**
  Your plugin class that subclases the base DPF Plugin one.
*/
class AmplifierPlugin : public Plugin
{
public:
    enum Parameters {
        PARAM_GAIN,
        PARAM_COUNT
    };

   /**
      Plugin class constructor.
      You must set all parameter values to their defaults, matching the value in initParameter().
    */
    AmplifierPlugin()
        : Plugin(PARAM_COUNT, 0, 0) // parameters, programs, states
    {
        gain = 0.0f;
    }

protected:
    // -------------------------------------------------------------------
    // Information

   /**
      Get the plugin label.
      This label is a short restricted name consisting of only _, a-z, A-Z and 0-9 characters.
    */
    const char* getLabel() const noexcept override
    {
        return "Amp";
    }

   /**
      Get an extensive comment/description about the plugin.
      Optional, returns nothing by default.
    */
    const char* getDescription() const override
    {
        return "DPF Amplifier example plugin.";
    }

   /**
      Get the plugin author/maker.
    */
    const char* getMaker() const noexcept override
    {
        return "falkTX";
    }

   /**
      Get the plugin license (a single line of text or a URL).
      For commercial plugins this should return some short copyright information.
    */
    const char* getLicense() const noexcept override
    {
        return "ISC";
    }

   /**
      Get the plugin version, in hexadecimal.
      @see d_version()
    */
    uint32_t getVersion() const noexcept override
    {
        return d_version(1, 0, 0);
    }

   /**
      Get the plugin unique Id.
      This value is used by LADSPA, DSSI and VST plugin formats.
      @see d_cconst()
    */
    int64_t getUniqueId() const noexcept override
    {
        return d_cconst('d', 'A', 'm', 'p');
    }

    // -------------------------------------------------------------------
    // Init

   /**
      Initialize the parameter @a index.
      This function will be called once, shortly after the plugin is created.
    */
    void initParameter(uint32_t index, Parameter& parameter) override
    {
        switch (index)
        {
        case PARAM_GAIN:
            parameter.hints      = kParameterIsAutomable;
            parameter.name       = "Gain";
            parameter.symbol     = "gain";
            parameter.unit       = "dB";
            parameter.ranges.def = 0.0f;
            parameter.ranges.min = -90.0f;
            parameter.ranges.max = 24.0f;
            break;
        }
    }

    // -------------------------------------------------------------------
    // Internal data

   /**
      Get the current value of a parameter.
      The host may call this function from any context, including realtime processing.
    */
    float getParameterValue(uint32_t index) const override
    {
        switch (index)
        {
        case PARAM_GAIN:
            return gain;
        }

        // fallback
        return 0.0f;
    }

   /**
      Change a parameter value.
      The host may call this function from any context, including realtime processing.
      When a parameter is marked as automable, you must ensure no non-realtime operations are performed.
    */
    void setParameterValue(uint32_t index, float value) override
    {
        switch (index)
        {
        case PARAM_GAIN:
            gain = value;
            break;
        }
    }

    // -------------------------------------------------------------------
    // Process

   /**
      Run/process function for plugins without MIDI input.
    */
    void run(const float** inputs, float** outputs, uint32_t frames) override
    {
        const float* const input  = inputs[0];
        /* */ float* const output = outputs[0];

        const float coef = DB_CO(gain);

        for (uint32_t i=0; i<frames; ++i)
            output[i] = input[i] * coef;
    }

    // -------------------------------------------------------------------

private:
    float gain;
};

// -----------------------------------------------------------------------

Plugin* DISTRHO::createPlugin()
{
    return new AmplifierPlugin();
}

// -----------------------------------------------------------------------
