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
