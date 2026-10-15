# Lean Proofbook and Verified Algorithms

A newly built, independent Lean 4 project maintained by **Raja
([@rajak73](https://github.com/rajak73))**. It combines an approachable discrete
mathematics proofbook, small verified list algorithms, and a proof-review lab.

Every theorem under `WelcomeSDEWorld/` is checked by Lean and Mathlib. The
project contains no `sorry`, `admit`, or custom axioms. Deliberately broken
examples live only in [`ReviewLab/README.md`](ReviewLab/README.md), so they do
not weaken or break the build.

## What's inside

- **Discrete mathematics proofbook:** parity, divisibility, inequalities, and
  modular arithmetic, with plain-English statements and proof strategies in
  [`Proofbook/README.md`](Proofbook/README.md).
- **Verified algorithms:** accumulator-based reverse and tail-recursive map,
  proved equivalent to `List.reverse` and `List.map`, with length and
  round-trip properties.
- **Proof Review Lab:** realistic flawed proof attempts covering omitted
  assumptions, false statements, missing base cases, and boundary cases.

## Setup and build

Prerequisites: Git and `curl`. The commands below install `elan` (Lean's
toolchain manager), select the version pinned in `lean-toolchain`, download
Mathlib, and check every proof.

```bash
git clone https://github.com/rajak73/Welcome-in-SDE-world.git
cd Welcome-in-SDE-world
curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y
source "$HOME/.elan/env"
lake update
lake build
lake exe welcome-sde-world
```

If `elan` is already installed, start with `lake update`. To check one file
while editing, run for example:

```bash
lake env lean WelcomeSDEWorld/Proofbook/Parity.lean
```

## Project map

```text
WelcomeSDEWorld/
  Proofbook/Parity.lean
  Proofbook/NumberTheory.lean
  Algorithms/List.lean
  Algorithms/Count.lean
Proofbook/README.md
ReviewLab/README.md
Main.lean
```

GitHub Actions runs `lake build` on every push and pull request.

## License

Released under the MIT License. See [`LICENSE`](LICENSE).
