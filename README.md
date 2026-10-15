# Lean Proofbook and Verified Algorithms

[![Lean](https://github.com/rajak73/Welcome-in-SDE-world/actions/workflows/lean.yml/badge.svg)](https://github.com/rajak73/Welcome-in-SDE-world/actions/workflows/lean.yml)

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

## A proof, line by line

The theorem `reverseAcc_eq` states the invariant behind the accumulator-based
reverse: reversing `xs` onto `acc` gives the ordinary reverse of `xs`, followed
by `acc`.

```lean
theorem reverseAcc_eq (xs acc : List α) :
    reverseAcc xs acc = xs.reverse ++ acc := by
  induction xs generalizing acc with
  | nil => rfl
  | cons x xs ih =>
      simp [reverseAcc, ih, List.reverse_cons, List.append_assoc]
```

1. `induction xs generalizing acc` performs structural induction on `xs` while
   keeping the accumulator arbitrary. This stronger induction hypothesis is
   essential because the recursive call changes `acc` to `x :: acc`.
2. In the `nil` case, `reverseAcc [] acc` reduces directly to `acc`, while
   `[].reverse ++ acc` does the same, so `rfl` closes the goal.
3. In the `cons` case, `ih` describes the recursive call on `xs` for every
   accumulator, including `x :: acc`.
4. `simp` unfolds `reverseAcc`, applies `ih`, expands the reverse of a cons, and
   reassociates list append. Both sides then have exactly the same form.

This proof establishes the algorithm's reusable invariant. The later theorem
`reverse_eq_list_reverse` specializes it to the empty accumulator.

## License

Released under the MIT License. See [`LICENSE`](LICENSE).
