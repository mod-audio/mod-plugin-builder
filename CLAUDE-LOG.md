# CLAUDE-LOG — mod-plugin-builder

Append-only contributor log. See `mod-publishing-ops/CLAUDE.md`, "Contributor log".

---

## 2026-10-02 — João (joao@mod.audio), MacBook (Apple Silicon) — local toolchains + MIDI Display

Sessions 2026-09-30 → 2026-10-02. No changes to this repo's code; this entry records use and bugs.

- **Toolchain images** built with `docker/Dockerfile` under Colima (arm64, 6 CPU / 6 GB / 150 GB):
  `mpbi_moddwarf-new`, `mpbi_modduox-new`, `mpbi_modduo-new` — ~40–45 min each.
- **Bug 1 — isl download 403.** `libisl.sourceforge.io` returns 403 for `isl-0.20`; ct-ng 1.25 (all
  `-new` platforms) fails in "Retrieving needed toolchain components". `bootstrap.sh` only has the
  Launchpad workaround for ct-ng 1.24. Worked around by adding, before the bootstrap `RUN`:
  `wget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/isl/0.20-1/isl_0.20.orig.tar.xz
  -O /root/mod-workdir/download/isl-0.20.tar.xz`.
- **Bug 2 — `target=toolchain` never finishes for buildroot-2016.02 platforms** (Duo, Duo X, Dwarf):
  `.clean-install.sh` runs `sed -i … staging/usr/lib/*.la` with no `.la` files present → sed exits
  2 under `set -e`. `docker-mount.sh` uses `target=toolchain`, so it is broken for these platforms.
  Worked around with `target=minimal`.
- Patched Dockerfile kept outside the repo at `~/mod-workdir-logs/docker-mac/` on João's Mac.
  Upstream fixes proposed in NOTES-FOR-GIANFRANCO.md (mod-publishing-ops); not made here.
- **MIDI Display** (`vallsv-midi-display`, recipe unchanged) built for all three platforms; installed
  via `/sdk/install` on João's Dwarf, Duo X and Duo; instantiated in mod-host on each and removed
  again; João confirmed it displays MIDI correctly.

## 2026-10-07 — João (joao@mod.audio), MacBook (Apple Silicon) — Portal manual + description

- Branch `joao/portal-docs`: `plugins/package/portal-lv2/` gets `documentation.pdf` (user manual,
  exported from the Portal Google Doc) installed into `portal.lv2/modgui/` with a
  `modgui:documentation` entry for Portal Sink and Source ("See documentation"), and
  `01_manual-description.patch` replacing both plugins' `rdfs:comment` with the manual's
  "What Portal Does" text. Upstream falkTX/portal-lv2 unchanged (`0c3599f`).
- Built with the local Docker toolchains for moddwarf-new, modduox-new, modduo-new; TTL validated
  with rapper. Installed via mod-ui `/sdk/install` (multipart field `package`, base64 tgz) on João's
  Dwarf, Duo X and Duo: description shown, PDF served (md5 match), both plugins load/unload cleanly.
- Dev publish attempted from this branch: rejected by pipeline-dev (`'project_id' was unexpected`),
  see mod-plugin-publisher/CLAUDE-LOG.md and NOTES-FOR-GIANFRANCO.md. **The dev publish must be run
  with this branch checked out**, since publish.py packages the local recipe folder.

## 2026-10-19 — João (joao@mod.audio), MacBook (Apple Silicon) — dm-TimeWarp v0.1.2 pin (PR #214)

- Branch `joao/dm-timewarp-0.1.2` (`f9962c9`), **PR #214** to master: `DM_TIMEWARP_VERSION`
  `fdbc753` (v0.1.0) → `16bc2259e0037aadf796461436e65d43bd8c8628` (Dave Mollen's latest, v0.1.2).
  Upstream change is TTL only: LV2 port groups + `minorVersion 1` / `microVersion 2` (v0.1.0 declared
  none, so devices couldn't see it as an update). Same 28 controls; manual unchanged.
- Built with the local Docker toolchains for moddwarf-new, modduox-new, modduo-new, recipe identical
  to the PR. Tested on João's Dwarf, Duo X, Duo (USB audio off): reports 1.2,
  manual served (identical to Dave's PDF), sweep of all 28 controls + worst case (8 voices, density 8)
  + bypass ×4 with **0 xruns**; DSP with TimeWarp at defaults 19.6% / 9.2% / 24.6%, worst case
  29.6% / 12.0% / 48.1%; GUI renders. Dwarf: old "TimeWrap test" pedalboard restores 28/28 values and
  4/4 cables.
- Going to the **main store** (`stable: true`, João's call), but **not published**: still needs João's
  sound check, factory presets, `pablito` out of `dm-timewarp.json` (Gianfranco) and the `project_id`
  answer. See mod-publishing-ops `JOAO-NOTES.md` (dm-TimeWarp).

## 2026-10-27 — João (joao@mod.audio), MacBook (Apple Silicon) — max-gen-zwabo pin for MIRRORZz (PR #215)

- Branch `joao/zwabo-mirrorz-pin`, **PR #215** merged by João (`c4abcf8`): `MAX_GEN_ZWABO_VERSION`
  `97047bc` → `f005a9724bc5230b15e61f8266c5939d5b139078` (merge of max-gen-plugins PR #7).
- `f005a97` has the same tree as `bf31d80`, the MIRRORZz build tested on Dwarf, Duo X and Duo (2026-10-16), presets
  on the Dwarf (2026-10-21). From `97047bc` to `f005a97` only MIRRORZz files and `CLAUDE-LOG.md` change, so the other
  six zwabo bundles build as before.
- MIRRORZz main-store requirements present at `f005a97`: PDF manual (`custom-ttl/zwabo-mirrorz/modgui.ttl:11`),
  6 factory presets, stereo port group on the audio ports.
- Going to the **main store** (`zwabo-mirrorz.lv2` `"stable": true`, publisher PR #5); other zwabo bundles stay beta.
  **Not built from this recipe and not published yet.**

## 2026-10-27 — João (joao@mod.audio), MacBook (Apple Silicon) — max-gen-zwabo pin for MIRRORZz port groups (PR #216)

- **PR #216** merged by João (`526f240`): `MAX_GEN_ZWABO_VERSION` `f005a97` → `32ca3299ac30c89f67af971d46de5d1563d17c89`
  (merge of max-gen-plugins PR #8: MIRRORZz control port groups Reverse / Speed / Tone & Mix). TTL only.
- Correction to the PR #215 entry above: at `f005a97` MIRRORZz had only its audio stereo group, no control groups,
  so it did not yet meet the port-groups rule. It does at `32ca329`.
- Dwarf: groups valid in mod-ui, settings panel checked by João and by headless screenshot, presets load, 0 xruns.
  **Not built from this recipe and not published yet.**

## 2026-10-27 — João (joao@mod.audio), MacBook (Apple Silicon) — max-gen-zwabo at -O2 (PR #217)

- Builder-recipe build of `526f240` gave **5–7 xruns each time MIRRORZz was added** to a board on the Dwarf
  (v1.14.0.3366, 128 frames); wiring, running, presets, bypass and remove: 0. The direct source build had none.
- Cause found: the recipe passes buildroot's `TARGET_CXXFLAGS`, which append `-O3` (`BR2_OPTIMIZE_3=y`) after DPF's
  `-O2`. MIRRORZz allocates two 7.2M-frame stereo float buffers (~115 MB, `gen_exported.cpp:169,175`) and genlib
  clears them with a byte loop (`genlib.cpp:96`). GCC 9.4 at -O3 vectorises it. Add tests, 6 runs each: -O3 5/6 with
  xruns; -O3 without loop→memset 5/6; -O3 without vectorisation 0/6; -O2 0/6. Running DSP the same (~18% on the board).
  The flags the toolchain wrapper injects (`-mcpu=cortex-a35`, `-D__MOD_DEVICES__`, …) are the same in both builds.
- **PR #217** merged by João (`9442804`): `CFLAGS`/`CXXFLAGS` = buildroot's + `-O2` for all seven zwabo bundles.
  Built through the recipe for moddwarf-new and modduox-new (compile ends in -O2). Dwarf: 0 xruns on 6 adds,
  6 presets, bypass ×4.
- modduo-new does not build in the local Apple Silicon Docker (`lv2_ttl_generator: Exec format error`); the unchanged
  recipe fails the same way, so it is local, not this change.
- `publish-plugin --check` passed (`zwabo-mirrorz.lv2` main store, other six beta; 8 warnings: no `updated_toolchain`,
  no `image_required`). **Not published.** Open: the cloud recompiles on its own toolchain; which GCC it uses with
  `updated_toolchain` unset is not known, so the store build must get the same add test after publishing.

## 2026-11-04 — João (joao@mod.audio), MacBook (Apple Silicon) — new recipe: jtbasssynth (JTBassSynth)

- New package `plugins/package/jtbasssynth/jtbasssynth.mk`: JTBassSynth by Jonas Temple, monophonic pitch-tracking
  bass synth, https://github.com/jtemple967/JTBassSynth, pinned to `268f847fadc0975d02e37e69586c2614e973bc10`
  (2026-10-25, "Added license file"). Licence GPL-3.0-or-later (`LICENSE`, README § License). Plain C, LV2, the
  plugin's own Makefile (`make install INSTALL_DIR=...`). Same recipe as João's local one of 2026-10-22 (which pinned
  `9c8e047`); only the pin changed.
- Since `9c8e047` the author changed the URI from `urn:jtbasssynth:bass-synth` to
  `https://github.com/jtemple967/JTBassSynth` and the licence from ISC to GPL-3.0; DSP code unchanged.
- Built locally (Docker, `mpbi_<platform>` images) for moddwarf-new, modduox-new, modduo-new: all OK.
- Device test (`~/mod-workdir-logs/test-jtbass.sh`; old 1.0 with the old URI uninstalled first on each unit):
  10 controls, GUI complete, **no presets, no documentation, no port groups** (fine for beta, needed for main store).
  - Dwarf v1.14.0.3368, 128 frames: DSP ~13% → ~25% (max 29.9%), 0 new xruns through sweep, 8 voices, worst case,
    bypass ×4.
  - Duo X v1.14.0.3364: ~7% → 10–14%, 0 xruns.
  - Duo v1.14.0.3364: ~12% → ~26% (max 30.1%), **1 xrun at the first add after install**, none in 10 more
    remove/add cycles. João: acceptable on the Duo.
  - Listen check on the Dwarf (João): good; the tracker sometimes jumps octaves, something for the author to improve.
- Target: beta (`"stable": false`), project JSON in mod-plugin-publisher.

## 2026-11-11 — João (joao@mod.audio), MacBook (Apple Silicon) — new recipe: hvcc-freezer (Freezer) — ON HOLD

- New package `plugins/package/hvcc-freezer/hvcc-freezer.mk`: Freezer by Jacube (forum) / GitHub `Battery-not-included`
  (maker field `J.Velcl@seznam.cz`, brand `BattNotIncluded`; same person per João), from `mod-audio/hvcc-plugins`
  `plugins/BatteryNotIncluded-Freezer` (PR #1, merged 2024-10-03) + `custom-ttl/BatteryNotIncluded-Freezer`
  (`8951053`, 2024-10-11), pinned to `8951053f960e5cfb780cacc38631037e1c6b83b7`. Licence ISC (repo `LICENSE`,
  `plugin.json`). URI `urn:hvcc:Freezer`, bundle `Freezer.lv2`. Forum: https://forum.mod.audio/t/freezer-freeze-your-tone-forever/10848
- Recipe follows `sensorium-plugins` (deps `dpf hvcc`, builds only Freezer, not the hvcc-plugins top Makefile), plus
  `-DDISTRHO_PLUGIN_USES_CUSTOM_MODGUI=1`: with `"enable_modgui": true` the builder's DPF (`6b04262`) generates a
  modgui and fails on `DISTRHO_UI_DEFAULT_WIDTH` (the DPF pinned by hvcc-plugins, `fc4ad61`, guarded it with
  `DISTRHO_PLUGIN_HAS_EMBED_UI`). The modgui comes from `custom-ttl` anyway.
- Local builds (Docker `mpbi_<platform>`, `~/mod-workdir-logs/build-freezer.sh`) OK for modduo-new, modduox-new,
  moddwarf-new. Local-only workarounds, not in the recipe: the `hvcc` package is an x86_64 binary (replaced by hvcc
  0.12.1 from PyPI in the arm64 container); the Duo's 32-bit ARM ttl generator run through `qemu-arm-static`.
- Dwarf v1.14.0.3370, 128 frames (`~/mod-workdir-logs/test-freezer.sh`): 0 xruns in all steps, DSP ~16%, GUI OK.
  **But João's listen check: big gain increase.** Cause: the repo's `plugin.pd` is an older Freezer with 7 parameters
  (attack, decay, dry, freeze, mode, speed, wet; checked in the hvcc 0.12.1 output), while `custom-ttl/.../Freezer_dsp.ttl`
  declares 12 controls and is byte-identical to the TTL in Jacube's May 14, 2024 build (with layers). Ports are
  mismatched (e.g. the TTL "decay" knob, 0–2000, drives `dry`; "layers", 1–6, drives `wet`). The test only checked
  CPU/xruns/GUI, not output level.
- **On hold** until Jacube sends his current Pd patch (message drafted for João 2026-11-11); then a PR to hvcc-plugins,
  a new pin here, rebuild, tests on all three units. Branch `joao/freezer` (local, not pushed).
- Dwarf restored to Jacube's `hvcc-Freezer.lv2` (May 14, 2024, from his forum Drive link, copy in
  `~/mod-workdir-logs/freezer-jacube-dl/`).
