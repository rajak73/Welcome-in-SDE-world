import Mathlib.Data.Nat.ModEq

namespace WelcomeSDEWorld.Proofbook

/-- Divisibility is transitive. -/
theorem dvd_transitive {a b c : ℕ} (hab : a ∣ b) (hbc : b ∣ c) : a ∣ c := by
  obtain ⟨k, rfl⟩ := hab
  obtain ⟨m, rfl⟩ := hbc
  exact ⟨k * m, by simp [Nat.mul_assoc]⟩

/-- A common divisor divides a natural-number linear combination. -/
theorem dvd_linear_combination {d a b m n : ℕ} (ha : d ∣ a) (hb : d ∣ b) :
    d ∣ m * a + n * b := by
  exact Nat.dvd_add (dvd_mul_of_dvd_right ha m) (dvd_mul_of_dvd_right hb n)

/-- Every positive natural number is at most its square. -/
theorem le_square {n : ℕ} (h : 1 ≤ n) : n ≤ n ^ 2 := by
  simpa [pow_two] using Nat.mul_le_mul_left n h

/-- Adding the same number to congruent naturals preserves congruence. -/
theorem modEq_add_right {a b c n : ℕ} (h : a ≡ b [MOD n]) :
    a + c ≡ b + c [MOD n] := by
  exact h.add_right c

/-- Squaring congruent naturals preserves congruence. -/
theorem modEq_square {a b n : ℕ} (h : a ≡ b [MOD n]) :
    a ^ 2 ≡ b ^ 2 [MOD n] := by
  exact h.pow 2

/-- A remainder modulo a positive modulus is strictly smaller than the modulus. -/
theorem remainder_lt {a n : ℕ} (h : 0 < n) : a % n < n := by
  exact Nat.mod_lt a h

end WelcomeSDEWorld.Proofbook
