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
