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
