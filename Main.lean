import WelcomeSDEWorld

open WelcomeSDEWorld.Algorithms

def main : IO Unit := do
  let values := [1, 2, 3, 4]
  IO.println s!"reverse {values} = {reverse values}"
  IO.println s!"double {values} = {mapTR (· * 2) values}"
  IO.println s!"even count = {countWhere (· % 2 == 0) values}"
