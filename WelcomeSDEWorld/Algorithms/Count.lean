import Mathlib.Data.List.Basic

namespace WelcomeSDEWorld.Algorithms

/-- Count list elements satisfying a decidable predicate. -/
def countWhere (p : α → Bool) : List α → Nat
  | [] => 0
  | x :: xs => (if p x then 1 else 0) + countWhere p xs

theorem countWhere_le_length (p : α → Bool) (xs : List α) :
    countWhere p xs ≤ xs.length := by
  induction xs with
  | nil => simp [countWhere]
  | cons x xs ih =>
      by_cases h : p x = true
      · simp only [countWhere, h, if_pos, List.length_cons]
        calc
          1 + countWhere p xs ≤ 1 + xs.length := Nat.add_le_add_left ih 1
          _ = xs.length + 1 := Nat.add_comm 1 xs.length
      · have hp : p x = false := Bool.of_not_eq_true h
        simp only [countWhere, hp, Bool.false_eq_true, if_false, List.length_cons]
        rw [Nat.zero_add]
        exact Nat.le_succ_of_le ih

theorem countWhere_append (p : α → Bool) (xs ys : List α) :
    countWhere p (xs ++ ys) = countWhere p xs + countWhere p ys := by
  induction xs with
  | nil => simp [countWhere]
  | cons x xs ih => simp [countWhere, ih, Nat.add_assoc]

theorem countWhere_map (p : β → Bool) (f : α → β) (xs : List α) :
    countWhere p (xs.map f) = countWhere (fun x => p (f x)) xs := by
  induction xs with
  | nil => rfl
  | cons x xs ih => simp [countWhere, ih]

/-- A predicate and its Boolean complement partition every list. -/
theorem countWhere_complement (p : α → Bool) (xs : List α) :
    countWhere p xs + countWhere (fun x => !(p x)) xs = xs.length := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
      cases h : p x <;>
        simp [countWhere, h, ih, Nat.add_assoc, Nat.add_left_comm, Nat.add_comm]

end WelcomeSDEWorld.Algorithms
