# Proof Review Lab

This lab trains proof review, not just tactic use. Every invalid example below
lives only in this Markdown file and is intentionally excluded from the Lean
build. For each case, review the statement before debugging the tactics.

## 1. Omitted assumption

**Exact proposed statement**

```lean
theorem square_positive_bad (n : ℕ) : 0 < n ^ 2
```

**Intentionally flawed attempt**

```lean
theorem square_positive_bad (n : ℕ) : 0 < n ^ 2 := by
  positivity
```

**Why it fails:** the statement omits the assumption `0 < n`. Automation cannot
prove a false claim.

**Counterexample:** set `n := 0`. The conclusion reduces to `0 < 0`, which is
false. Lean therefore leaves the positivity goal unsolved.

**Compare with:**
[`Proofbook.le_square`](../WelcomeSDEWorld/Proofbook/NumberTheory.lean), which
states its necessary boundary assumption explicitly:

```lean
theorem le_square {n : ℕ} (h : 1 ≤ n) : n ≤ n ^ 2
```

## 2. Incorrect conclusion

**Exact proposed statement**

```lean
theorem odd_add_odd_bad {a b : ℕ} (ha : Odd a) (hb : Odd b) : Odd (a + b)
```

**Intentionally flawed attempt**

```lean
theorem odd_add_odd_bad {a b : ℕ} (ha : Odd a) (hb : Odd b) : Odd (a + b) := by
  obtain ⟨m, rfl⟩ := ha
  obtain ⟨n, rfl⟩ := hb
  -- No oddness witness can close the remaining goal.
```

**Why it fails:** two odd numbers sum to an even number, so the requested
oddness witness does not exist.

**Counterexample:** `a := 1` and `b := 3` satisfy both assumptions, but their
sum is `4`; Lean can decide `¬ Odd 4`.

**Compare with:**
[`Proofbook.odd_add_odd`](../WelcomeSDEWorld/Proofbook/Parity.lean), whose
correct conclusion is:

```lean
theorem odd_add_odd {a b : ℕ} (ha : Odd a) (hb : Odd b) : Even (a + b)
```

## 3. Missing induction case

**Exact proposed statement**

```lean
theorem reverse_length_bad (xs : List α) : xs.reverse.length = xs.length
```

**Intentionally flawed attempt**

```lean
theorem reverse_length_bad (xs : List α) : xs.reverse.length = xs.length := by
  induction xs with
  | cons x xs ih => simp [ih]
```

**Why it fails:** list induction creates one goal for each constructor, but the
attempt handles only `List.cons`.

**Relevant Lean error:** Lean reports an unsolved `nil` alternative. Its goal is
the base case:

```text
⊢ [].reverse.length = [].length
```

**Compare with:**
[`Algorithms.reverseAcc_eq`](../WelcomeSDEWorld/Algorithms/List.lean), which
shows both required branches:

```lean
induction xs generalizing acc with
| nil => rfl
| cons x xs ih => ...
```

## 4. Unchecked modulus edge case

**Exact proposed statement**

```lean
theorem remainder_bad (a n : ℕ) : a % n < n
```

**Intentionally flawed attempt**

```lean
theorem remainder_bad (a n : ℕ) : a % n < n := by
  exact Nat.mod_lt a (by omega)
```

**Why it fails:** `Nat.mod_lt` requires a proof of `0 < n`, which cannot be
derived for an arbitrary natural number.

**Counterexample and goal:** for `n := 0`, the conclusion becomes `a % 0 < 0`,
which is impossible. In the attempted proof, Lean leaves the side goal:

```text
a n : ℕ
⊢ 0 < n
```

**Compare with:**
[`Proofbook.remainder_lt`](../WelcomeSDEWorld/Proofbook/NumberTheory.lean), which
accepts precisely that missing assumption:

```lean
theorem remainder_lt {a n : ℕ} (h : 0 < n) : a % n < n
```

## Review checklist

1. Try tiny examples, especially zero, one, and the empty list.
2. Separate a false statement from a merely incomplete proof.
3. Check that every induction constructor has a case.
4. Trace each hypothesis to where the proof uses it.
5. Reject `sorry`, `admit`, and new axioms as substitutes for evidence.
