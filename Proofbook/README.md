# Discrete Mathematics Proofbook

The source files are short enough to read from top to bottom. Each result below
states what it means informally and identifies the central proof move.

## Parity

Source: [`WelcomeSDEWorld/Proofbook/Parity.lean`](../WelcomeSDEWorld/Proofbook/Parity.lean)

| Theorem | Plain English | Proof strategy |
| --- | --- | --- |
| `even_add_even` | Adding two even natural numbers gives an even natural number. | Combine the two parity witnesses with the additive closure of even numbers. |
| `odd_add_odd` | Adding two odd natural numbers gives an even natural number. | Write both as `2k + 1`; the two extra ones form another factor of two. |
| `even_mul_left` | An even natural number times any natural number is even. | Move the arbitrary factor into the witness. |
| `consecutive_not_both_odd` | Two consecutive naturals cannot both be odd. | Expand both oddness witnesses; linear arithmetic exposes the contradiction. |

## Divisibility, inequalities, and modular arithmetic

Source: [`WelcomeSDEWorld/Proofbook/NumberTheory.lean`](../WelcomeSDEWorld/Proofbook/NumberTheory.lean)

| Theorem | Plain English | Proof strategy |
| --- | --- | --- |
| `dvd_transitive` | If `a` divides `b` and `b` divides `c`, then `a` divides `c`. | Multiply the two divisibility witnesses. |
| `dvd_linear_combination` | A common divisor of `a` and `b` divides `m*a + n*b`. | Divisibility survives multiplication and addition. |
| `le_square` | A positive natural number is no larger than its square. | The positivity assumption supplies the boundary needed by nonlinear arithmetic. |
| `modEq_add_right` | Adding the same value preserves congruence modulo `n`. | Apply the additive compatibility of `Nat.ModEq`. |
| `modEq_square` | Congruent naturals have congruent squares. | Congruence is compatible with powers. |
| `remainder_lt` | For positive `n`, the remainder after division by `n` is below `n`. | Apply the defining bound for natural-number remainder, using positivity explicitly. |

These explanations are navigation aids; the checked Lean terms in the source
files are the proofs.
