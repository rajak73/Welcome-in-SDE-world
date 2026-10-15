import Mathlib.Data.List.Defs

namespace WelcomeSDEWorld.Algorithms

/-- Reverse `xs` onto `acc`, using constant stack space after compilation. -/
def reverseAcc (xs : List α) (acc : List α) : List α :=
  match xs with
  | [] => acc
  | x :: rest => reverseAcc rest (x :: acc)

theorem reverseAcc_eq (xs acc : List α) : reverseAcc xs acc = xs.reverse ++ acc := by
  induction xs generalizing acc with
  | nil => rfl
  | cons x xs ih =>
      simp [reverseAcc, ih, List.reverse_cons, List.append_assoc]

/-- The accumulator invariant also accounts for every output element. -/
theorem reverseAcc_length (xs acc : List α) :
    (reverseAcc xs acc).length = xs.length + acc.length := by
  induction xs generalizing acc with
  | nil => simp [reverseAcc]
  | cons x xs ih =>
      simp [reverseAcc, ih, Nat.add_assoc, Nat.add_left_comm, Nat.add_comm]

/-- A public accumulator-based reverse. -/
def reverse (xs : List α) : List α := reverseAcc xs []

theorem reverse_eq_list_reverse (xs : List α) : reverse xs = xs.reverse := by
  simp [reverse, reverseAcc_eq]

theorem reverse_length (xs : List α) : (reverse xs).length = xs.length := by
  rw [reverse_eq_list_reverse, List.length_reverse]

theorem reverse_reverse (xs : List α) : reverse (reverse xs) = xs := by
  simp [reverse_eq_list_reverse]

/-- Build the mapped list backwards in an accumulator. -/
def mapRevAcc (f : α → β) (xs : List α) (acc : List β) : List β :=
  match xs with
  | [] => acc
  | x :: rest => mapRevAcc f rest (f x :: acc)

theorem mapRevAcc_eq (f : α → β) (xs : List α) (acc : List β) :
    mapRevAcc f xs acc = (xs.map f).reverse ++ acc := by
  induction xs generalizing acc with
  | nil => rfl
  | cons x xs ih =>
      simp [mapRevAcc, ih, List.reverse_cons, List.append_assoc]

/-- Mapping changes values but the accumulator invariant fixes the output size. -/
theorem mapRevAcc_length (f : α → β) (xs : List α) (acc : List β) :
    (mapRevAcc f xs acc).length = xs.length + acc.length := by
  induction xs generalizing acc with
  | nil => simp [mapRevAcc]
  | cons x xs ih =>
      simp [mapRevAcc, ih, Nat.add_assoc, Nat.add_left_comm, Nat.add_comm]

/-- A tail-recursive map assembled by reversing the accumulated result. -/
def mapTR (f : α → β) (xs : List α) : List β :=
  reverse (mapRevAcc f xs [])

theorem mapTR_eq_map (f : α → β) (xs : List α) : mapTR f xs = xs.map f := by
  simp [mapTR, reverse_eq_list_reverse, mapRevAcc_eq]

theorem mapTR_length (f : α → β) (xs : List α) : (mapTR f xs).length = xs.length := by
  rw [mapTR_eq_map, List.length_map]

end WelcomeSDEWorld.Algorithms
