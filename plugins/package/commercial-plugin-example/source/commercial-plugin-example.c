#include <libmodla.h>

#include <stdlib.h>
#include <string.h>

#define PLUGIN_URI "urn:mod:commercial-plugin-example"

typedef struct {
    const float* input;
    float* output;
    uint32_t run_count;
} Plugin;

static LV2_Handle plugin_instantiate(const LV2_Descriptor* d, double sr, const char* b, const LV2_Feature* const* f)
{
    mod_license_check(f, PLUGIN_URI);
    return calloc(1, sizeof(Plugin));

    // unused
    (void)d;
    (void)sr;
    (void)b;
}

static void plugin_connect_port(LV2_Handle instance, uint32_t port, void* data_location)
{
    Plugin* const plugin = (Plugin*)instance;

    switch (port)
    {
    case 0:
        plugin->input = (const float*)data_location;
        break;
    case 1:
        plugin->output = (float*)data_location;
        break;
    }
}

static void plugin_run(LV2_Handle instance, uint32_t nsamples)
{
    Plugin* const plugin = (Plugin*)instance;

    plugin->run_count = mod_license_run_begin(plugin->run_count, nsamples);

    if (plugin->input != plugin->output)
        memcpy(plugin->output, plugin->input, sizeof(float)*nsamples);

    mod_license_run_silence(plugin->run_count, plugin->output, nsamples, 0);
}

static void plugin_cleanup(LV2_Handle instance)
{
    free(instance);
}

static const void* plugin_extension_data(const char* uri)
{
    return mod_license_interface(uri);
}

static const LV2_Descriptor plugin_descriptor = {
    PLUGIN_URI,
    plugin_instantiate,
    plugin_connect_port,
    NULL,
    plugin_run,
    NULL,
    plugin_cleanup,
    plugin_extension_data
};

LV2_SYMBOL_EXPORT
const LV2_Descriptor* lv2_descriptor(uint32_t index)
{
    return (index == 0) ? &plugin_descriptor : NULL;
}
