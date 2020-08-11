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

/**
  Your plugin class that subclases the base DPF Plugin one.
*/
class SynthPlugin : public Plugin
{
public:
    enum Parameters {
        //PARAM_,
        PARAM_COUNT
    };

   /**
      Plugin class constructor.
      You must set all parameter values to their defaults, matching the value in initParameter().
    */
    SynthPlugin()
        : Plugin(PARAM_COUNT, 0, 0) // parameters, programs, states
    {
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
        return "Synth";
    }

   /**
      Get an extensive comment/description about the plugin.
      Optional, returns nothing by default.
    */
    const char* getDescription() const override
    {
        return "DPF Synth example plugin.";
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
        return d_cconst('d', 'S', 'y', 'n');
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
        /*
        case PARAM_:
            parameter.hints      = kParameterIsAutomable;
            parameter.name       = "Name";
            parameter.symbol     = "name";
            parameter.unit       = "";
            parameter.ranges.def = 0.0f;
            parameter.ranges.min = 0.0f;
            parameter.ranges.max = 1.0f;
            break;
        */
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
        /*
        case PARAM_:
            return param1;
        */
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
        /*
        case PARAM_:
            param1 = value;
            break;
        */
        }
    }

    // -------------------------------------------------------------------
    // Process

   /**
      Run/process function for plugins with MIDI input.
    */
    void run(const float**, float** outputs, uint32_t frames, const MidiEvent* events, uint32_t eventCount) override
    {
        float* const output = outputs[0];

        for (uint32_t i=0; i<frames; ++i)
            output[i] = 0.0f;
    }

    // -------------------------------------------------------------------

private:
    // nothing yet
};

// -----------------------------------------------------------------------

Plugin* DISTRHO::createPlugin()
{
    return new SynthPlugin();
}

// -----------------------------------------------------------------------
