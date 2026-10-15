# Proof Review Lab

This lab trains proof review, not just tactic use. Each broken snippet is kept
in Markdown and is intentionally **not** imported by the Lean build. Try to
identify the mathematical defect before reading the review notes.

## 1. Omitted assumption

```lean
-- Broken proof approach: positivity is not available.
theorem square_positive_bad (n : ℕ) : 0 < n ^ 2 := by
  positivity
```

**Why it fails:** the claim is false at `n = 0`. The theorem omitted the
assumption `0 < n`, which the informal argument needs.

**Review habit:** inspect the smallest values and list every condition used by
the paper proof. Compare the explicit boundary assumption in
`Proofbook.le_square`.

## 2. Incorrect theorem statement

```lean
-- Broken: 1 and 3 are odd, but their sum is 4, not odd.
theorem odd_add_odd_bad {a b : ℕ} (ha : Odd a) (hb : Odd b) : Odd (a + b) := by
  obtain ⟨m, rfl⟩ := ha
  obtain ⟨n, rfl⟩ := hb
  -- no valid witness exists
```

**Why it fails:** the conclusion is mathematically false. No tactic should be
expected to repair it.

**Review habit:** test a concrete example before reviewing proof mechanics. The
correct conclusion is `Even (a + b)`; see `Proofbook.odd_add_odd`.

## 3. Missing base case

```lean
-- Broken sketch: the empty list case is absent.
theorem reverse_length_bad (xs : List α) : xs.reverse.length = xs.length := by
  induction xs with
  | cons x xs ih => simp [ih]
```

**Why it fails:** structural induction on a list creates both `nil` and `cons`
goals. Handling only the recursive case leaves a goal unsolved.

**Review habit:** after every `induction`, account for every constructor. The
verified algorithm proves its length property in `Algorithms.reverse_length`.

## 4. Edge case hidden by an over-broad claim

```lean
-- Broken: `% 0` is defined for naturals, but its result is not less than 0.
theorem remainder_bad (a n : ℕ) : a % n < n := by
  exact Nat.mod_lt a (by omega)
```

**Why it fails:** `Nat.mod_lt` requires `0 < n`; that cannot be derived for an
arbitrary natural `n`. At `n = 0`, the strict inequality is impossible.

**Review habit:** inspect zero denominators, empty structures, and interval
endpoints. The corrected `Proofbook.remainder_lt` exposes `0 < n` as an input.

## Review checklist

1. Try tiny examples, especially zero, one, and the empty list.
2. Separate a false statement from a merely incomplete proof.
3. Check that every induction constructor has a case.
4. Trace each hypothesis to where the proof uses it.
5. Reject `sorry`, `admit`, and new axioms as substitutes for evidence.
