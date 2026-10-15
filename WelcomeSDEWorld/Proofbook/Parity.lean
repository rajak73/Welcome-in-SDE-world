import Mathlib.Algebra.Ring.Parity

namespace WelcomeSDEWorld.Proofbook

/-- The sum of two even natural numbers is even. -/
theorem even_add_even {a b : ℕ} (ha : Even a) (hb : Even b) : Even (a + b) := by
  exact ha.add hb

/-- The sum of two odd natural numbers is even. -/
theorem odd_add_odd {a b : ℕ} (ha : Odd a) (hb : Odd b) : Even (a + b) := by
  exact ha.add_odd hb

/-- Multiplying an even natural number by any natural number produces an even number. -/
theorem even_mul_left {a b : ℕ} (ha : Even a) : Even (a * b) := by
  exact ha.mul_right b

/-- Consecutive natural numbers cannot both be odd. -/
theorem consecutive_not_both_odd (n : ℕ) : ¬(Odd n ∧ Odd (n + 1)) := by
  rintro ⟨hn, hnext⟩
  exact (Nat.not_even_iff_odd.mpr hnext) hn.add_one

end WelcomeSDEWorld.Proofbook
