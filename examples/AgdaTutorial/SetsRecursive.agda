module SetsRecursive where

data ℕ⁺ : Set where
  one      : ℕ⁺
  double   : ℕ⁺ → ℕ⁺
  double+1 : ℕ⁺ → ℕ⁺

data ℕ₂ : Set where
  zero : ℕ₂
  id   : ℕ⁺ → ℕ₂

-- -- To pick ℕ⁺ or ℕ₂ -- -- 
-- n * 2
-- TODO: read about functions

